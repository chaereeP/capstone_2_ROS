#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <fstream>
#include <chrono>
#include <string>
#include <signal.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <ros/ros.h>
#include <boost/thread.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <ros/package.h>

#include "ros/ros.h"


#include "sensor_msgs/CompressedImage.h"

#include "opencv2/opencv.hpp"

using namespace std;

int main(int argc, char **argv)
{

    ros::init(argc, argv, "testimage_publisher");
    ros::NodeHandle n;
    ros::Publisher pub;
    pub = n.advertise<sensor_msgs::CompressedImage>("catdog/image", 1); //setting publisher



    cv::Mat image;
    // Write down your image directory
    image = cv::imread("/home/kaistbot/capstone_design_ROS/capstone_design/src/cnn_for_jetson/src/cat.325.jpg",CV_LOAD_IMAGE_COLOR);

    while(ros::ok){

      sensor_msgs::CompressedImage msg;

      cv::imencode(".jpg", image, msg.data);
      pub.publish(msg);
      cv::imshow("Frame",image);
      cv::waitKey(30);

      ros::spinOnce();
    }

    return 0;
}
