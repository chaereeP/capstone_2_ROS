import sys, os, itertools, collections, time
import numpy as np
import tensorflow as tf
import cv2
import simulator

from estimators import ValueEstimator, PolicyEstimator
from worker import make_copy_params_op

class PolicyMonitor(object):
    def __init__(self, env, policy_net):
        self.env = env
        self.global_policy_net = policy_net

        # Local policy net
        with tf.variable_scope("policy_eval"):
            self.policy_net = PolicyEstimator(policy_net.num_outputs)

        self.copy_params_op = make_copy_params_op(
        tf.contrib.slim.get_variables(scope="global", collection=tf.GraphKeys.TRAINABLE_VARIABLES),
        tf.contrib.slim.get_variables(scope="policy_eval", collection=tf.GraphKeys.TRAINABLE_VARIABLES))

    def _policy_net_predict(self, state, rnn_state, sess):
        self.policy_net.state_in[0] = rnn_state[0]
        self.policy_net.state_in[1] = rnn_state[1]
        feed_dict = { self.policy_net.states: [state] }
        preds, state_out = sess.run([self.policy_net.predictions, self.policy_net.state_out], feed_dict)
        return preds["probs"][0], state_out

def main():
    VALID_ACTIONS = list(range(10))
    MODEL_DIR = "data/train"
    CHECKPOINT_DIR = os.path.join(MODEL_DIR, "checkpoints")

    env = simulator.Task(debug_flag=True, test_flag=True, state_blink=True, state_inaccurate=True)

    with tf.variable_scope("global") as vs:
        policy_net = PolicyEstimator(num_outputs=len(VALID_ACTIONS))

    saver = tf.train.Saver(keep_checkpoint_every_n_hours=2.0, max_to_keep=10)
    pe = PolicyMonitor(
        env=env,
        policy_net=policy_net)

    sess = tf.Session()
    sess.run(tf.global_variables_initializer())
    coord = tf.train.Coordinator()

    # Load a previous checkpoint if it exists
    latest_checkpoint = tf.train.latest_checkpoint(CHECKPOINT_DIR)
    if latest_checkpoint:
        print("Loading model checkpoint: {}".format(latest_checkpoint))
        saver.restore(sess, latest_checkpoint)
    else:
        print("Fail to load model")
        return

    with sess.as_default(), sess.graph.as_default():
        _ = sess.run(pe.copy_params_op)

    done = False
    state = np.stack([pe.env.reset().reshape(93,93)] * 4, axis=2)
    rnn_state = pe.policy_net.state_init
    total_reward = 0.0

    num_episode = 0
    while(1):
        action_probs, next_rnn_state = pe._policy_net_predict(state, rnn_state, sess)
        action = np.random.choice(np.arange(len(action_probs)), p=action_probs)
        next_state, reward, done = pe.env.step(action)
        next_state = np.append(state[:,:,1:], np.expand_dims(next_state.reshape(93,93), 2), axis=2)
        total_reward += reward
        state = next_state
        rnn_state = next_rnn_state

        if done == True: # done was True in latest transition; we have already stored that
            done = False
            state = np.stack([pe.env.reset().reshape(93,93)] * 4, axis=2)
            rnn_state = pe.policy_net.state_init
            total_reward = 0.0
            num_episode = num_episode + 1

        cv2.waitKey(30)

        if num_episode >= 10:
            break;

if __name__ == "__main__":
    main()
