# Caution when catkin_make

you should install the xbox controller driver.

please commend that before catkin_make

sudo apt-get install libudev-dev ncurses-dev


----------------------------------------------------------------------------------------------------
If you downloaded this files and catkin_make, there could be a 'fatal error: core_msgs/ball_position.h: No such file or directory)

If so, just
catkin_make --pkg core_msgs

and then,

catkin_make

again. 
