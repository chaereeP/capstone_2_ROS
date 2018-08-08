import sys
import itertools
import numpy as np
import random
import tensorflow                as tf
import tensorflow.contrib.layers as layers
from collections import namedtuple
from dqn_utils import *

OptimizerSpec = namedtuple("OptimizerSpec", ["constructor", "kwargs", "lr_schedule"])

def learn(env,
          q_func,
          optimizer_spec,
          session,
          exploration=LinearSchedule(1000000, 0.1),
          stopping_criterion=None,
          replay_buffer_size=1000000,
          batch_size=32,
          gamma=0.99,
          learning_starts=50000,
          learning_freq=4,
          frame_history_len=4,
          target_update_freq=10000,
          target_update_rate=0.001,
          grad_norm_clipping=10,
          model_save_t=100000,
          double_net=False):
    """Run Deep Q-learning algorithm.

    You can specify your own convnet using q_func.

    All schedules are w.r.t. total number of steps taken in the environment.

    Parameters
    ----------
    env: gym.Env
        gym environment to train on.
    q_func: function
        Model to use for computing the q function. It should accept the
        following named arguments:
            img_in: tf.Tensor
                tensorflow tensor representing the input image
            num_actions: int
                number of actions
            scope: str
                scope in which all the model related variables
                should be created
            reuse: bool
                whether previously created variables should be reused.
    optimizer_spec: OptimizerSpec
        Specifying the constructor and kwargs, as well as learning rate schedule
        for the optimizer
    session: tf.Session
        tensorflow session to use.
    exploration: rl_algs.deepq.utils.schedules.Schedule
        schedule for probability of chosing random action.
    stopping_criterion: (env, t) -> bool
        should return true when it's ok for the RL algorithm to stop.
        takes in env and the number of steps executed so far.
    replay_buffer_size: int
        How many memories to store in the replay buffer.
    batch_size: int
        How many transitions to sample each time experience is replayed.
    gamma: float
        Discount Factor
    learning_starts: int
        After how many environment steps to start replaying experiences
    learning_freq: int
        How many steps of environment to take between every experience replay
    frame_history_len: int
        How many past frames to include as input to the model.
    target_update_freq: int
        How many experience replay rounds (not steps!) to perform between
        each update to the target Q network
    grad_norm_clipping: float or None
        If not None gradients' norms are clipped to this value.
    double_net: parameters for double dueling net
    """

    ###############
    # BUILD MODEL #
    ###############

    img_h, img_w, img_c = env.observation_space.shape
    input_shape = (img_h, img_w, frame_history_len * img_c)
    num_actions = env.action_space.size

    global_step = tf.Variable(0, name='global_step', trainable=False, dtype=tf.int32)
    inc_global_step_op = tf.assign(global_step, global_step+1)

    episode_step = tf.Variable(0, name='episode_step', trainable=False, dtype=tf.int32)
    inc_episode_step_op = tf.assign(episode_step, episode_step+1)

    # set up placeholders
    # placeholder for current observation (or state)
    obs_t_ph              = tf.placeholder(tf.uint8, [None] + list(input_shape))
    # placeholder for current action
    act_t_ph              = tf.placeholder(tf.int32,   [None])
    # placeholder for current reward
    rew_t_ph              = tf.placeholder(tf.float32, [None])
    # placeholder for next observation (or state)
    obs_tp1_ph            = tf.placeholder(tf.uint8, [None] + list(input_shape))
    # placeholder for end of episode mask
    # this value is 1 if the next state corresponds to the end of an episode,
    # in which case there is no Q-value at the next state; at the end of an
    # episode, only the current state reward contributes to the target, not the
    # next state Q-value (i.e. target is just rew_t_ph, not rew_t_ph + gamma * q_tp1)
    done_mask_ph          = tf.placeholder(tf.float32, [None])

    # casting to float on GPU ensures lower data transfer times.
    obs_t_float   = tf.cast(obs_t_ph,   tf.float32) / 255.0
    obs_tp1_float = tf.cast(obs_tp1_ph, tf.float32) / 255.0


    current_q_func = q_func(obs_t_float, num_actions, scope="q_func", reuse=False) # Current Q-Value Function
    q_func_vars = tf.get_collection(tf.GraphKeys.GLOBAL_VARIABLES, scope='q_func')

    main_q_func = q_func(obs_tp1_float, num_actions, scope="q_func", reuse=True)

    target_q_func = q_func(obs_tp1_float, num_actions, scope="target_q_func", reuse=False) # Target Q-Value Function
    target_q_func_vars = tf.get_collection(tf.GraphKeys.GLOBAL_VARIABLES, scope='target_q_func')

    act_t = tf.one_hot(act_t_ph, depth=num_actions, dtype=tf.float32, name="action_one_hot")
    q_act_t = tf.reduce_sum(act_t*current_q_func, axis=1)

    if double_net:
        y = rew_t_ph + gamma * tf.gather_nd(target_q_func,tf.concat((tf.transpose([tf.range(batch_size, dtype=tf.int64)]),tf.transpose([tf.argmax(main_q_func, axis=1)])),axis=1))
    else:
        y = rew_t_ph + gamma * tf.reduce_max(target_q_func, reduction_indices=[1]) #which axis for max?

    total_error = tf.square(tf.subtract(y, q_act_t)) #(reward + gamma*V(s') - Q(s, a))**2

    # construct optimization op (with gradient clipping)
    learning_rate = tf.placeholder(tf.float32, (), name="learning_rate")
    optimizer = optimizer_spec.constructor(learning_rate=learning_rate, **optimizer_spec.kwargs)
    train_fn = minimize_and_clip(optimizer, total_error,
                 var_list=q_func_vars, clip_val=grad_norm_clipping)

    # update_target_fn will be called periodically to copy Q network to target Q network
    update_target_fn = []
    for var, var_target in zip(sorted(q_func_vars,        key=lambda v: v.name),
                               sorted(target_q_func_vars, key=lambda v: v.name)):
        if double_net:
            update_target_fn.append(var_target.assign(target_update_rate*var+(1-target_update_rate)*var_target))
        else:
            update_target_fn.append(var_target.assign(var))

    update_target_fn = tf.group(*update_target_fn)

    # construct the replay buffer
    replay_buffer = ReplayBuffer(replay_buffer_size, frame_history_len)

    ###############
    # RUN ENV     #
    ###############
    model_initialized = False
    num_param_updates = 0
    mean_episode_reward      = -float('nan')
    best_mean_episode_reward = -float('inf')
    last_obs = env.reset()
    LOG_EVERY_N_STEPS = 10000

    saver = tf.train.Saver(tf.global_variables())
    ckpt = tf.train.get_checkpoint_state('model/model')
    if ckpt and tf.train.checkpoint_exists(ckpt.model_checkpoint_path):
        saver.restore(session, ckpt.model_checkpoint_path)
    else:
        session.run(tf.global_variables_initializer())

    writer = tf.summary.FileWriter("board/tt_dqn_logs", session.graph)
    summary = tf.Summary()

    for t in itertools.count(session.run(global_step)):
        # print session.run(global_step)
        session.run(inc_global_step_op)

        if stopping_criterion is not None and stopping_criterion(env, t):
            break

        # Store last_obs into replay buffer
        idx = replay_buffer.store_frame(last_obs)

        # Choose action
        epsilon = exploration.value(t)

        if not model_initialized or random.random() < epsilon:
            # With probability epsilon OR if model hasn't been initialized, choose a random action
            act = env.action_space_sample()
        else:
            # With probability 1 - epsilon, choose the best action from Q
            input_batch = replay_buffer.encode_recent_observation()
            q_vals = session.run(current_q_func, {obs_t_ph: input_batch[None, :]})
            act = np.argmax(q_vals)

        # Step simulator forward one step
        last_obs, reward, done = env.step(act)
        replay_buffer.store_effect(idx, act, reward, done) # Store action taken after last_obs and corresponding reward

        if done == True: # done was True in latest transition; we have already stored that
            last_obs = env.reset() # Reset observation
            done = False
            session.run(inc_episode_step_op)
            # print session.run(episode_step)

        if (t > learning_starts and
                t % learning_freq == 0 and
                replay_buffer.can_sample(batch_size)):

            # 3.a Sample a batch of transitions
            obs_t_batch, act_batch, rew_batch, obs_tp1_batch, done_mask = replay_buffer.sample(batch_size)

            # 3.b Initialize model if not initialized yet
            if not model_initialized:
                initialize_interdependent_variables(session, tf.global_variables(), {
                   obs_t_ph: obs_t_batch,
                   obs_tp1_ph: obs_tp1_batch,
                })
                session.run(update_target_fn)
                model_initialized = True

            # 3.c Train the model using train_fn and total_error
            session.run(train_fn, {obs_t_ph: obs_t_batch, act_t_ph: act_batch, rew_t_ph: rew_batch, obs_tp1_ph: obs_tp1_batch,
                done_mask_ph: done_mask, learning_rate: optimizer_spec.lr_schedule.value(t)})

            # 3.d Update target network every taret_update_freq steps
            if double_net:
                session.run(update_target_fn)
            else:
                if t % target_update_freq == 0:
                    session.run(update_target_fn)
                    num_param_updates += 1

            #####
        if t%model_save_t == 0:
            saver.save(session, 'model/model/tt_dqn.ckpt', global_step=global_step)
            print "save model"

        ### 4. Log progress
        episode_rewards = env.get_episode_rewards()
        if len(episode_rewards) > 0:
            mean_episode_reward = np.mean(episode_rewards[-100:])
        if len(episode_rewards) > 100:
            best_mean_episode_reward = max(best_mean_episode_reward, mean_episode_reward)
        if t % LOG_EVERY_N_STEPS == 0 and model_initialized:
            print("Timestep %d" % (t,))
            print("mean reward (100 episodes) %f" % mean_episode_reward)
            print("best mean reward %f" % best_mean_episode_reward)
            print("episodes %d" % len(episode_rewards))
            print("exploration %f" % exploration.value(t))
            print("learning_rate %f" % optimizer_spec.lr_schedule.value(t))

            print "q-value"+format(session.run(current_q_func[0], {obs_t_ph: obs_t_batch, act_t_ph: act_batch, rew_t_ph: rew_batch, obs_tp1_ph: obs_tp1_batch,\
                done_mask_ph: done_mask, learning_rate: optimizer_spec.lr_schedule.value(t)}))

            summary.value.add(tag="mean_episode_reward", simple_value=mean_episode_reward)
            writer.add_summary(summary, global_step=session.run(episode_step))
            writer.flush()

            sys.stdout.flush()
