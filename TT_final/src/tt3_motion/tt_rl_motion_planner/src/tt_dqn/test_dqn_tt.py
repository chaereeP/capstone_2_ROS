import argparse
import os.path as osp
import random
import numpy as np
import tensorflow as tf
import tensorflow.contrib.layers as layers

import dqn
from dqn_utils import *

import simulator
import cv2, time

def tt_model_dqn(img_in, num_actions, scope, reuse=False):
    # as described in https://storage.googleapis.com/deepmind-data/assets/papers/DeepMindNature14236Paper.pdf
    with tf.variable_scope(scope, reuse=reuse):
        out = img_in
        with tf.variable_scope("convnet"):
            # original architecture
            out = layers.convolution2d(out, num_outputs=32, kernel_size=8, stride=4, activation_fn=tf.nn.relu)
            out = layers.convolution2d(out, num_outputs=64, kernel_size=4, stride=2, activation_fn=tf.nn.relu)
            out = layers.convolution2d(out, num_outputs=64, kernel_size=3, stride=1, activation_fn=tf.nn.relu)
        out = layers.flatten(out)
        with tf.variable_scope("action_value"):
            out = layers.fully_connected(out, num_outputs=512,         activation_fn=tf.nn.relu)
            out = layers.fully_connected(out, num_outputs=num_actions, activation_fn=None)

        return out

def tt_model_dueling_dqn(img_in, num_actions, scope, reuse=False):
    # as described in https://storage.googleapis.com/deepmind-data/assets/papers/DeepMindNature14236Paper.pdf
    with tf.variable_scope(scope, reuse=reuse):
        out = img_in
        with tf.variable_scope("convnet"):
            # original architecture
            out = layers.convolution2d(out, num_outputs=32, kernel_size=8, stride=4, activation_fn=tf.nn.relu)
            out = layers.convolution2d(out, num_outputs=64, kernel_size=4, stride=2, activation_fn=tf.nn.relu)
            out = layers.convolution2d(out, num_outputs=64, kernel_size=3, stride=1, activation_fn=tf.nn.relu)
            out = layers.convolution2d(out, num_outputs=64, kernel_size=7, stride=1, activation_fn=tf.nn.relu)

        outA = layers.flatten(out)
        outV = layers.flatten(out)

        with tf.variable_scope("action_value"):
            outA = layers.fully_connected(outA, num_outputs=512,         activation_fn=tf.nn.relu)
            outA = layers.fully_connected(outA, num_outputs=num_actions, activation_fn=None)
            outV = layers.fully_connected(outV, num_outputs=512,         activation_fn=tf.nn.relu)
            outV = layers.fully_connected(outV, num_outputs=1, activation_fn=None)

        outQ = outV + tf.subtract(outA,tf.reduce_max(outA,axis=1,keep_dims=True))
        return outQ

def tt_test(env,session):
    replay_buffer_size=100
    frame_history_len=4

    img_h, img_w, img_c = env.observation_space.shape
    input_shape = (img_h, img_w, frame_history_len * img_c)
    num_actions = env.action_space.size

    obs_t_ph              = tf.placeholder(tf.uint8, [None] + list(input_shape))
    act_t_ph              = tf.placeholder(tf.int32,   [None])
    rew_t_ph              = tf.placeholder(tf.float32, [None])
    obs_t_float           = tf.cast(obs_t_ph,   tf.float32) / 255.0

    current_q_func = tt_model_dueling_dqn(obs_t_float, num_actions, scope="q_func", reuse=False)
    replay_buffer = ReplayBuffer(replay_buffer_size, frame_history_len)

    ###########
    # RUN ENV #
    ###########
    last_obs = env.reset(max_balls=5)

    saver = tf.train.Saver(tf.global_variables())
    ckpt = tf.train.get_checkpoint_state('model/model')
    if ckpt and tf.train.checkpoint_exists(ckpt.model_checkpoint_path):
        saver.restore(session, ckpt.model_checkpoint_path)
    else:
        print "no model found"

    num_episode = 0
    while(1):
        t0 = time.time()

        idx = replay_buffer.store_frame(last_obs)
        input_batch = replay_buffer.encode_recent_observation()
        q_vals = session.run(current_q_func, {obs_t_ph: input_batch[None, :]})
        act = np.argmax(q_vals)
        print act
        print q_vals
        last_obs, reward, done = env.step(act)
        replay_buffer.store_effect(idx, act, 0, done)

        t1 = time.time()
        print "Elapsed %.5f sec" % (t1-t0)

        if done == True: # done was True in latest transition; we have already stored that
            last_obs = env.reset(max_balls=5) # Reset observation
            done = False
            num_episode = num_episode + 1

        cv2.waitKey(30)

        if num_episode >= 10:
            break;


def get_session():
    tf.reset_default_graph()
    gpu_options = tf.GPUOptions(per_process_gpu_memory_fraction=0.4)
    tf_config = tf.ConfigProto(
        intra_op_parallelism_threads=1,
        gpu_options=gpu_options)
    session = tf.Session(config=tf_config)
    print("AVAILABLE GPUS: ", get_available_gpus())
    return session

def get_available_gpus():
    from tensorflow.python.client import device_lib
    local_device_protos = device_lib.list_local_devices()
    return [x.physical_device_desc for x in local_device_protos if x.device_type == 'GPU']

def main():
    session = get_session()
    env = simulator.Task(debug_flag=True, test_flag=True, state_blink=False, state_inaccurate=False)
    tt_test(env, session)

if __name__ == "__main__":
    main()
