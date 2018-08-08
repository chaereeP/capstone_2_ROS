# Install script for directory: /home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/naverlabs/ros/TT_final/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tt_core_msgs/msg" TYPE FILE FILES
    "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ImagePoint.msg"
    "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/CompressedImagePoint.msg"
    "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/ROIPointArray.msg"
    "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/Vector3DArray.msg"
    "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/MapFlag.msg"
    "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/msg/XboxFlag.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tt_core_msgs/srv" TYPE FILE FILES
    "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraImg.srv"
    "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MapGenPoint.srv"
    "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/CameraCrop.srv"
    "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/srv/MobileNetCrop.srv"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tt_core_msgs/cmake" TYPE FILE FILES "/home/naverlabs/ros/TT_final/build/tt3_common/tt_core_msgs/catkin_generated/installspace/tt_core_msgs-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/naverlabs/ros/TT_final/devel/include/tt_core_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/naverlabs/ros/TT_final/devel/share/roseus/ros/tt_core_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/naverlabs/ros/TT_final/devel/share/common-lisp/ros/tt_core_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/naverlabs/ros/TT_final/devel/share/gennodejs/ros/tt_core_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/home/naverlabs/anaconda3/bin/python" -m compileall "/home/naverlabs/ros/TT_final/devel/lib/python3/dist-packages/tt_core_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/naverlabs/ros/TT_final/devel/lib/python3/dist-packages/tt_core_msgs")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/naverlabs/ros/TT_final/build/tt3_common/tt_core_msgs/catkin_generated/installspace/tt_core_msgs.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tt_core_msgs/cmake" TYPE FILE FILES "/home/naverlabs/ros/TT_final/build/tt3_common/tt_core_msgs/catkin_generated/installspace/tt_core_msgs-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tt_core_msgs/cmake" TYPE FILE FILES
    "/home/naverlabs/ros/TT_final/build/tt3_common/tt_core_msgs/catkin_generated/installspace/tt_core_msgsConfig.cmake"
    "/home/naverlabs/ros/TT_final/build/tt3_common/tt_core_msgs/catkin_generated/installspace/tt_core_msgsConfig-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/tt_core_msgs" TYPE FILE FILES "/home/naverlabs/ros/TT_final/src/tt3_common/tt_core_msgs/package.xml")
endif()

