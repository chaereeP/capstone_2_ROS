cmake_minimum_required(VERSION 2.8.3)
project(rplidar)

set(RPLIDAR_SDK_PATH "./sdk/")

FILE(GLOB RPLIDAR_SDK_SRC
  "${RPLIDAR_SDK_PATH}/src/arch/linux/*.cpp"
  "${RPLIDAR_SDK_PATH}/src/hal/*.cpp"
  "${RPLIDAR_SDK_PATH}/src/*.cpp"
)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rosconsole
  sensor_msgs
  tt_core_msgs
  geometry_msgs
)

include_directories(
  ${RPLIDAR_SDK_PATH}/include
  ${RPLIDAR_SDK_PATH}/src
  ${catkin_INCLUDE_DIRS}
)

catkin_package()

add_executable(tt_rplidar_node src/node.cpp ${RPLIDAR_SDK_SRC})
add_dependencies(tt_rplidar_node tt_core_msgs_generate_messages_cpp)
target_link_libraries(tt_rplidar_node ${catkin_LIBRARIES})

add_executable(rplidar_client src/client.cpp)
add_dependencies(rplidar_client tt_core_msgs_generate_messages_cpp)
target_link_libraries(rplidar_client ${catkin_LIBRARIES})

install(TARGETS tt_rplidar_node rplidar_client
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY launch rviz sdk
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
  USE_SOURCE_PERMISSIONS
)
