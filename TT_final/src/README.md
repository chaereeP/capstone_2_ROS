# NaverLabs Intern Project

## TT3

Final version of ball collecting robot

### TODO

- [x] MobileNet based vision recognition
- [x] Optical Flow Multibody Tracker
- [x] Simulator for Reinforcement Learning
- [x] Deep Q Learning
- [x] Double DQN, LSTM, Value Iteration Network
- [x] Robot System Calibration and Test
- [x] Paper for ICRA 2018

### Usage
```
roslaunch tt3_description tt3_robot_nuc.launch
roslaunch tt3_description tt3_robot_jetson.launch
roslaunch tt3_description tt3_server.launch
```

To terminate and save recorded data,
```
rostopic pub /tt_end_system std_msgs/Int32 1
```

### Dependencies
- Basic installation
  ```
  sudo apt-get install libncurses5-dev libudev-dev libhdf5-dev python-h5py
  ```

- [Eigen 3.1](http://eigen.tuxfamily.org/index.php?title=News:Eigen_3.1.2_released!) -> after installation, follow [this instruction](https://stackoverflow.com/questions/23284473/fatal-error-eigen-dense-no-such-file-or-directory)

- [Boost](http://www.boost.org/)

- ROS Kinetic (desktop)

    install laser-scan-matcher, ros-pcl, csm

- [OpenCV full version](https://github.com/opencv/opencv_contrib.git)

- [cv_bridge](https://github.com/ros-perception/vision_opencv)

- keras

    pip install -U keras

    **In order to use 0.25 MobileNet-128, remove "or weights" in line 385 of "/usr/local/lib/python2.7/dist-packages/keras/applications/mobilenet.py"**

- Add alias
  ```
  alias end_tt='rostopic pub /tt_end_system std_msgs/Int32 1'
  alias record_tt='rostopic pub /tt_start_path_record std_msgs/Int32 1'
  ```

### Jetson TX1 Setting

- JetPack 2.3.1

- TensorFlow (Haha it's secret~ :D)

- keras

- Basic installation
  ```
  sudo apt-get install libhdf5-dev python-h5py
  ```
