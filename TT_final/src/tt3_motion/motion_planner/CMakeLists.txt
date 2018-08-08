cmake_minimum_required(VERSION 2.8.3)
project(motion_planner)

add_definitions(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  sensor_msgs
  message_filters
  roslib
  tt_core_msgs
  geometry_msgs
)

catkin_package(
  # INCLUDE_DIRS include

  LIBRARIES motion_planner

  CATKIN_DEPENDS
  roscpp
  std_msgs
  sensor_msgs
  roslib
  tt_core_msgs
  geometry_msgs

  DEPENDS system_lib
)

include_directories(
  ${OpenCV_INCLUDE_DIRS}
  ${Eigen3_INCLUDE_DIRS}
  ${cv_bridge_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
)

add_executable(${PROJECT_NAME}_node src/motion_planner_node.cpp)
add_executable(astar_planner src/tt_astar_planner_node.cpp)
add_executable(send_signal_node src/send_signal.cpp)

add_dependencies(${PROJECT_NAME}_node tt_core_msgs_generate_messages_cpp)
add_dependencies(astar_planner tt_core_msgs_generate_messages_cpp)
add_dependencies(send_signal_node tt_core_msgs_generate_messages_cpp)

find_package( OpenCV REQUIRED )
find_package( Eigen3 REQUIRED )
find_package( cv_bridge REQUIRED )

target_link_libraries(${PROJECT_NAME}_node
  ${catkin_LIBRARIES} ${Eigen3_LIBS} ${OpenCV_LIBS} ${cv_bridge_LIBRARIES}
)
target_link_libraries(astar_planner
  ${catkin_LIBRARIES} ${Eigen3_LIBS} ${OpenCV_LIBS} ${cv_bridge_LIBRARIES}
)
target_link_libraries(send_signal_node
  ${catkin_LIBRARIES} ${Eigen3_LIBS} ${OpenCV_LIBS} ${cv_bridge_LIBRARIES}
)
