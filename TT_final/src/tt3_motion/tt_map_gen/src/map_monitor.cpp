#include <iostream>
#include <stdio.h>
#include <algorithm>
#include <fstream>
#include <chrono>
#include <string>
#include <signal.h>
#include <math.h>
#include "deque"

#include <ros/ros.h>
#include <ros/package.h>

#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/Image.h>
#include <image_transport/image_transport.h>

#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>
#include "tt_core_msgs/MapFlag.h"
#include "std_msgs/Int32.h"
#include "opencv2/opencv.hpp"

cv::VideoWriter outputVideo_HD;
cv::VideoWriter outputVideo_RL;

void callback(const tt_core_msgs::MapFlagConstPtr& map_hd, const tt_core_msgs::MapFlagConstPtr& map_rl)
{
    cv_bridge::CvImageConstPtr cv_ptr_hd, cv_ptr_rl;
    try
    {
        boost::shared_ptr<void const> tracked_object_tmp;
        cv_ptr_hd = cv_bridge::toCvShare(map_hd->frame, tracked_object_tmp);
        boost::shared_ptr<void const> tracked_object_tmp2;
        cv_ptr_rl = cv_bridge::toCvShare(map_rl->frame, tracked_object_tmp2);
    }
    catch (cv_bridge::Exception& e)
    {
        ROS_ERROR("cv_bridge exception: %s", e.what());
        return;
    }
    cv::Mat map_hd_m = cv_ptr_hd->image.clone();
    cv::Mat map_rl_m = cv_ptr_rl->image.clone();

    cv::Mat map_resized_real = cv::Mat::zeros(500,500,CV_8UC3);
    cv::resize(map_hd_m, map_resized_real, cv::Size(500,500), 0, 0, CV_INTER_NN);

    outputVideo_HD << map_resized_real;
    outputVideo_RL << map_rl_m;

    cv::imshow("HD Map", map_resized_real);
    cv::imshow("RL Map", map_rl_m);
    cv::waitKey(30);
}

void callbackTerminate(const std_msgs::Int32Ptr& record){
    outputVideo_HD.release();
    outputVideo_RL.release();
    ros::shutdown();
    return;
}

int main(int argc, char** argv)
{

    std::string path1 = ros::package::getPath("tt_map_gen");
    std::string path2 = ros::package::getPath("tt_map_gen");
    path1 += "/../../../data/test_data/map_hd_monitor.mp4";
    path2 += "/../../../data/test_data/map_rl_monitor.mp4";

    outputVideo_HD.open(path1, cv::VideoWriter::fourcc('H', '2', '6', '4'), 50, cv::Size(500,500), true);
    outputVideo_RL.open(path2, cv::VideoWriter::fourcc('H', '2', '6', '4'), 50, cv::Size(93,93), false);

    ros::init(argc, argv, "tt3_map_gen_node");
    ros::start();

    ros::NodeHandle nh;

    message_filters::Subscriber<tt_core_msgs::MapFlag> map_sub(nh, "/map_gen/map_monitor", 1);
    message_filters::Subscriber<tt_core_msgs::MapFlag> rl_map_sub(nh, "/map_gen/rl_map", 1);
    typedef message_filters::sync_policies::ApproximateTime<tt_core_msgs::MapFlag, tt_core_msgs::MapFlag> sync_pol;
    message_filters::Synchronizer<sync_pol> sync(sync_pol(100), map_sub, rl_map_sub);
    sync.registerCallback(boost::bind(&callback, _1, _2));

    ros::Subscriber end_record_sub = nh.subscribe("/tt_end_system", 1, callbackTerminate);

    ros::spin();

    return 0;
}
