cmake_minimum_required(VERSION 2.8.3)
project(tt_map_gen)

## Add support for C++11, supported in ROS Kinetic and newer
add_definitions(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  roscpp
  tt_core_msgs
  std_msgs
  sensor_msgs
  message_filters
  geometry_msgs
  image_transport
)

catkin_package(
  INCLUDE_DIRS include

  LIBRARIES map_gen

  CATKIN_DEPENDS
  roscpp
  std_msgs
  sensor_msgs
  tt_core_msgs
  geometry_msgs
  image_transport

  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
# include_directories(include)
include_directories(
  ${OpenCV_INCLUDE_DIRS}
  ${Eigen3_INCLUDE_DIRS}
  ${cv_bridge_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
  include
)
## Declare a C++ library
add_library(${PROJECT_NAME}
  src/map_gen.cpp
)

add_executable(map_node src/rl_map.cpp)
add_executable(map_monitor src/map_monitor.cpp)
add_executable(ball_detect_monitor_node src/ball_detect_monitor.cpp)

add_dependencies(map_node tt_core_msgs_generate_messages_cpp)
add_dependencies(map_monitor tt_core_msgs_generate_messages_cpp)
add_dependencies(ball_detect_monitor_node tt_core_msgs_generate_messages_cpp)

## Specify libraries to link a library or executable target against
find_package( OpenCV REQUIRED )
find_package( Eigen3 REQUIRED )
find_package( cv_bridge REQUIRED )

target_link_libraries(map_node
  ${catkin_LIBRARIES} ${Eigen3_LIBS} ${OpenCV_LIBS} ${cv_bridge_LIBRARIES} ${PROJECT_NAME}
)

target_link_libraries(map_monitor
  ${catkin_LIBRARIES} ${Eigen3_LIBS} ${OpenCV_LIBS} ${cv_bridge_LIBRARIES} ${PROJECT_NAME}
)

target_link_libraries(ball_detect_monitor_node
  ${catkin_LIBRARIES} ${Eigen3_LIBS} ${OpenCV_LIBS} ${cv_bridge_LIBRARIES} ${PROJECT_NAME}
)
