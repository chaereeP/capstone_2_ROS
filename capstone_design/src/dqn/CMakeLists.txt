cmake_minimum_required(VERSION 2.8.3)
project(dqn)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  sensor_msgs
  std_msgs
  core_msgs
  image_transport message_generation

)

find_package(OpenCV REQUIRED )
find_package( cv_bridge REQUIRED )

# catkin_package(
# #  INCLUDE_DIRS include
# #  CATKIN_DEPENDS roscpp
# #  sensor_msgs
# #  std_msgs
# #  core_msgs
# #  DEPENDS system_lib
# )

catkin_package(
  CATKIN_DEPENDS
  roscpp
  rospy
  std_msgs
  sensor_msgs
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
  ${OpenCV_INCLUDE_DIRS}
  ${cv_bridge_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
  include
)

add_executable(covert_to_simulator_image src/covert_to_simulator_image.cpp)
add_dependencies(covert_to_simulator_image core_msgs_generate_messages_cpp)

target_link_libraries(covert_to_simulator_image
  ${catkin_LIBRARIES} ${OpenCV_LIBS} ${cv_bridge_LIBRARIES}
)
