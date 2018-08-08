/*
 * Copyright (c) 2014, RoboPeak
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */
/*
 *  RoboPeak LIDAR System
 *  RPlidar ROS Node client test app
 *
 *  Copyright 2009 - 2014 RoboPeak Team
 *  http://www.robopeak.com
 *
 */


#include "ros/ros.h"
#include "sensor_msgs/LaserScan.h"
#include "geometry_msgs/Vector3.h"
#include "tt_core_msgs/ROIPointArray.h"

#define RAD2DEG(x) ((x)*180./M_PI)

ros::Publisher m_pub_point;
tt_core_msgs::ROIPointArrayPtr msg_map_points_;

void scanCallback(const sensor_msgs::LaserScan::ConstPtr& scan)
{
    int count = scan->scan_time / scan->time_increment;
    // ROS_INFO("I heard a laser scan %s[%d]:", scan->header.frame_id.c_str(), count);
    // ROS_INFO("angle_range, %f, %f", RAD2DEG(scan->angle_min), RAD2DEG(scan->angle_max));

    msg_map_points_->Vector3DArray.clear();
    geometry_msgs::Vector3 msg_point_;

    for(int i = 0; i < count; i++) {
        float degree = scan->angle_min + scan->angle_increment * i;
        // float degree = RAD2DEG(scan->angle_min + scan->angle_increment * i);
        // ROS_INFO(": [%f, %f]", degree, scan->ranges[i]);
        // msg_point_.x = (scan->ranges[i])*cos(degree+M_PI);
        // msg_point_.y = (scan->ranges[i])*sin(degree+M_PI);
        msg_point_.x = scan->ranges[i];
        msg_point_.y = degree+M_PI;
        msg_point_.z = 1;
        msg_map_points_->Vector3DArray.push_back(msg_point_);
    }
    msg_map_points_->id.push_back(count);
    msg_map_points_->extra.push_back(scan->angle_min+M_PI);
    msg_map_points_->extra.push_back(scan->angle_increment);

    msg_map_points_->header.stamp = ros::Time::now();
    m_pub_point.publish(msg_map_points_);
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "rplidar_client");
    ros::NodeHandle nh;

    m_pub_point = nh.advertise<tt_core_msgs::ROIPointArray>("/obstacle_detect/map_points", 1);
    msg_map_points_.reset(new tt_core_msgs::ROIPointArray);

    ros::Subscriber sub = nh.subscribe<sensor_msgs::LaserScan>("/scan", 1000, scanCallback);

    ros::spin();

    return 0;
}
