execute_process(COMMAND "/home/naverlabs/ros/TT_final/build/tt3_motion/tt_rl_motion_planner/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/naverlabs/ros/TT_final/build/tt3_motion/tt_rl_motion_planner/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
