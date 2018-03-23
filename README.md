# Caution when catkin_make

you should install the xbox controller driver before catkin_make.

please commend that

sudo apt-get install libudev-dev ncurses-dev


----------------------------------------------------------------------------------------------------
If you downloaded this files and catkin_make, there could be a 'fatal error: core_msgs/ball_position.h: No such file or directory)

If so, just
catkin_make --pkg core_msgs

and then,

catkin_make

again. 
