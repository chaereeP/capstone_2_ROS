cmake_minimum_required(VERSION 2.8.3)
project(tt_core_msgs)

find_package(catkin REQUIRED
  message_generation
  std_msgs
  geometry_msgs
  sensor_msgs
)

add_message_files( DIRECTORY msg
  FILES
  ImagePoint.msg
  CompressedImagePoint.msg
  ROIPointArray.msg
  Vector3DArray.msg
  MapFlag.msg
  XboxFlag.msg
)

## Generate services in the 'srv' folder
add_service_files( DIRECTORY srv
  FILES
  CameraImg.srv
  MapGenPoint.srv
  CameraCrop.srv
  MobileNetCrop.srv
)

## Generate actions in the 'action' folder
# add_action_files(
#   FILES
#   Action1.action
#   Action2.action
# )

## Generate added messages and services with any dependencies listed here
generate_messages(DEPENDENCIES std_msgs geometry_msgs sensor_msgs)

catkin_package(CATKIN_DEPENDS message_runtime std_msgs geometry_msgs sensor_msgs)
