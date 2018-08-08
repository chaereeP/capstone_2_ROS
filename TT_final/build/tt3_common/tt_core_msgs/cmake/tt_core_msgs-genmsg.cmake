# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "tt_core_msgs: 6 messages, 4 services")

set(MSG_I_FLAGS "-Itt_core_msgs:/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/kinetic/share/sensor_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(tt_core_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg" NAME_WE)
add_custom_target(_tt_core_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tt_core_msgs" "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg" "sensor_msgs/Image:geometry_msgs/Vector3:std_msgs/Header"
)

get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg" NAME_WE)
add_custom_target(_tt_core_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tt_core_msgs" "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg" "geometry_msgs/Vector3:std_msgs/Header:sensor_msgs/CompressedImage"
)

get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg" NAME_WE)
add_custom_target(_tt_core_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tt_core_msgs" "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg" "geometry_msgs/Vector3:std_msgs/Header:sensor_msgs/CompressedImage"
)

get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg" NAME_WE)
add_custom_target(_tt_core_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tt_core_msgs" "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg" "geometry_msgs/Vector3:std_msgs/Header"
)

get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg" NAME_WE)
add_custom_target(_tt_core_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tt_core_msgs" "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg" "sensor_msgs/Image:std_msgs/Header"
)

get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg" NAME_WE)
add_custom_target(_tt_core_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tt_core_msgs" "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg" "std_msgs/MultiArrayDimension:std_msgs/Float32MultiArray:std_msgs/MultiArrayLayout:std_msgs/Header"
)

get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv" NAME_WE)
add_custom_target(_tt_core_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tt_core_msgs" "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv" "std_msgs/Int32:std_msgs/Header:sensor_msgs/CompressedImage"
)

get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv" NAME_WE)
add_custom_target(_tt_core_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tt_core_msgs" "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv" "tt_core_msgs/ROIPointArray:geometry_msgs/Vector3:std_msgs/Int32:std_msgs/Header:sensor_msgs/CompressedImage"
)

get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv" NAME_WE)
add_custom_target(_tt_core_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tt_core_msgs" "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv" "tt_core_msgs/ROIPointArray:geometry_msgs/Vector3:std_msgs/Header:tt_core_msgs/Vector3DArray:sensor_msgs/CompressedImage"
)

get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv" NAME_WE)
add_custom_target(_tt_core_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tt_core_msgs" "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv" "tt_core_msgs/ROIPointArray:geometry_msgs/Vector3:std_msgs/Header:sensor_msgs/CompressedImage"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_cpp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_cpp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_cpp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_cpp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_cpp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
)

### Generating Services
_generate_srv_cpp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Int32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_cpp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Int32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_cpp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_cpp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
)

### Generating Module File
_generate_module_cpp(tt_core_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(tt_core_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(tt_core_msgs_generate_messages tt_core_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_cpp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_cpp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_cpp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_cpp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_cpp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_cpp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_cpp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_cpp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_cpp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_cpp _tt_core_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tt_core_msgs_gencpp)
add_dependencies(tt_core_msgs_gencpp tt_core_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tt_core_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_eus(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_eus(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_eus(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_eus(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_eus(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
)

### Generating Services
_generate_srv_eus(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Int32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_eus(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Int32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_eus(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_eus(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
)

### Generating Module File
_generate_module_eus(tt_core_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(tt_core_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(tt_core_msgs_generate_messages tt_core_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_eus _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_eus _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_eus _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_eus _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_eus _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_eus _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_eus _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_eus _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_eus _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_eus _tt_core_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tt_core_msgs_geneus)
add_dependencies(tt_core_msgs_geneus tt_core_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tt_core_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_lisp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_lisp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_lisp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_lisp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_lisp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
)

### Generating Services
_generate_srv_lisp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Int32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_lisp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Int32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_lisp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_lisp(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
)

### Generating Module File
_generate_module_lisp(tt_core_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(tt_core_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(tt_core_msgs_generate_messages tt_core_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_lisp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_lisp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_lisp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_lisp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_lisp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_lisp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_lisp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_lisp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_lisp _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_lisp _tt_core_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tt_core_msgs_genlisp)
add_dependencies(tt_core_msgs_genlisp tt_core_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tt_core_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_nodejs(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_nodejs(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_nodejs(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_nodejs(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_nodejs(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
)

### Generating Services
_generate_srv_nodejs(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Int32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_nodejs(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Int32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_nodejs(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_nodejs(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
)

### Generating Module File
_generate_module_nodejs(tt_core_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(tt_core_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(tt_core_msgs_generate_messages tt_core_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_nodejs _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_nodejs _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_nodejs _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_nodejs _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_nodejs _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_nodejs _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_nodejs _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_nodejs _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_nodejs _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_nodejs _tt_core_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tt_core_msgs_gennodejs)
add_dependencies(tt_core_msgs_gennodejs tt_core_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tt_core_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_py(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_py(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_py(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_py(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Image.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
)
_generate_msg_py(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/MultiArrayDimension.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Float32MultiArray.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/MultiArrayLayout.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
)

### Generating Services
_generate_srv_py(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/std_msgs/cmake/../msg/Int32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_py(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Int32.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_py(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
)
_generate_srv_py(tt_core_msgs
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv"
  "${MSG_I_FLAGS}"
  "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/CompressedImage.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
)

### Generating Module File
_generate_module_py(tt_core_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(tt_core_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(tt_core_msgs_generate_messages tt_core_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_py _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_py _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_py _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_py _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_py _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_py _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_py _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_py _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_py _tt_core_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv" NAME_WE)
add_dependencies(tt_core_msgs_generate_messages_py _tt_core_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tt_core_msgs_genpy)
add_dependencies(tt_core_msgs_genpy tt_core_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tt_core_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tt_core_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(tt_core_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(tt_core_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(tt_core_msgs_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tt_core_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(tt_core_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(tt_core_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(tt_core_msgs_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tt_core_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(tt_core_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(tt_core_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(tt_core_msgs_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tt_core_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(tt_core_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(tt_core_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(tt_core_msgs_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs)
  install(CODE "execute_process(COMMAND \"/home/naverlabs/anaconda3/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tt_core_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(tt_core_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(tt_core_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(tt_core_msgs_generate_messages_py sensor_msgs_generate_messages_py)
endif()
