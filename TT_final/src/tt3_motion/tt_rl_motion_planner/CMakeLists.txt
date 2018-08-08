cmake_minimum_required(VERSION 2.8.3)
project(tt_rl_motion_planner)

add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  rospy
  sensor_msgs
  std_msgs
  tt_core_msgs
)

catkin_python_setup()

catkin_package(
  CATKIN_DEPENDS
  rospy
  sensor_msgs
  std_msgs
  tt_core_msgs
)

install(PROGRAMS bin/dqn_planner
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(PROGRAMS bin/a3c_planner
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
