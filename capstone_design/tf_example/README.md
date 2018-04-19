#date: 2018.04.19
#written by seojh (seojh1989@gmail.com)

These packages are for tutorial of transformation-related issues in ROS. 
Follow the procedures summarized below.

1. Run 'fake_ball_in_rviz' node

- rosrun fake_ball_in_rviz fake_ball_in_rviz
- rviz
- Add -> By Topics -> select '/balls' -> OK
- change the fixed frame to 'camera_link'
- check whether balls are visualized well in rviz. 

2. Run 'static_tf_example' node

- rosrun static_tf_example static_tf_example
- Add -> By display tpye -> selct 'TF' -> OK
- check wheter two frame("world"&"camera_link") are visulized well.
- change the fixed frame to 'world'

3. Run 'compute_position_in_other_frame' node

- rosrun compute_position_in_other_frame compute_position_in_other_frame 
(*this node will receive two messages. 
the first one is transformation between "world" & "camera_link" published by 'static_tf_example' node
the second one is ball's position published by 'fake_ball_in_rviz' node
then, this node will compute positions of balls in "world" frame. 

These are basic things that you should know...

Lastly, the procedure of advanced(just a little bit...) tutorial with dynamic transformation is like below.
In your project, you can use dynamic transformation publisher for your mobile platform because it is not fixed. 

1. Terminate all the nodes activated.

2. Run 'fake_ball_in_rviz' node

3. Run 'dynamic_tf_example' node
- rosrun dynamic_tf_example dynamic_tf_example
- Add -> By display tpye -> selct 'TF' -> OK
- check wheter two frame("world"&"camera_link") are visulized well.
- you can see that 'camera_link' is moving while 'world' is fixed. 

4. Run 'compute_position_in_other_frame' node
-you can see the values in changing.







