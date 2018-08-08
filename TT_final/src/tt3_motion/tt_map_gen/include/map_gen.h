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

#include "tt_core_msgs/Vector3DArray.h"
#include "tt_core_msgs/ROIPointArray.h"
#include "tt_core_msgs/MapFlag.h"
#include "tt_core_msgs/CompressedImagePoint.h"
#include "std_msgs/Int32.h"
#include "geometry_msgs/Pose2D.h"
#include "geometry_msgs/Vector3.h"
#include "sensor_msgs/CompressedImage.h"

#include "opencv2/opencv.hpp"
#include <boost/thread.hpp>

#define min(a,b) ((a)<(b)?(a):(b))

// std::vector<geometry_msgs::Vector3> ball_points;
std::vector<geometry_msgs::Vector3> obstacle_points;
boost::mutex map_mutex_;

int flag_odom_reset;
geometry_msgs::Pose2D odom_now;
geometry_msgs::Pose2D odom_init;
geometry_msgs::Pose2D global_odom_init;

int lidar_count = 0;
float lidar_angle_min = 0;
float lidar_angle_increment = 0.001;

cv::Mat H_inv;
double camera_fx = 194.7;
double camera_fy = 194.3;
double camera_cx = 328.9;
double camera_cy = 168.0;

ros::Publisher pub_map;
tt_core_msgs::MapFlagPtr msg_map;

ros::Publisher pub_rl_map;
tt_core_msgs::MapFlagPtr msg_rl_map;

ros::Publisher pub_map_monitor;
tt_core_msgs::MapFlagPtr msg_map_monitor;

ros::Publisher pub_ball;
ros::Publisher pub_april;
ros::Publisher pub_obstacle;

ros::ServiceClient mobile_net_client;
tt_core_msgs::ROIPointArrayPtr msg_mobilenet;

int monitor_ball_draw_flag = 0;
std::vector<std::pair<int,int>> monitor_ball_array;
std::vector<std::pair<int,int>> monitor_path_array;

// int num_imwrite = 0;

struct timeTF{
    float time; // elapse from previous time
    float x;
    float y;
    float theta;
};

std::deque<timeTF> odom_queue;

struct map_data{
    int ball_track;
    int ball;
    int obstacle;
    int obstacle_padding;
};

struct state_data{
    int ball;
    int obstacle;
    int robot;
    int robot_padding;
};

float map_resol = 0.05;
float map_monitor_resol = 0.02;
int map_width = 100;
int map_height = 100;
int padding_obstacle = 2;
int padding_april_tag = 0;
int length_april_tag = 0;
int obstacle_connect_max = 15;
float map_cx = 50.5;
float map_cy = 97.5;
int tracker_state = 0;

float rl_resol = 0.15;
int rl_width = 31;
int rl_height = 31;
int rl_center = 15;
int rl_debug = 10;
float rl_guide = 0.57735; // 1/tan(camera_fov/2)

map_data params_data;
state_data params_data_rl;

// map_data params_data = {1,2,200,150};
// state_data params_data_rl = {255,100,200,150};


class BallPoints{
private:
    sensor_msgs::CompressedImage crop;

public:
    float x, y, ball_x, ball_y;
    int lost, tag;
    float cx, cy, size;

    BallPoints(float _x, float _y, float _size, sensor_msgs::CompressedImage _crop){
        x = _x;
        y = _y;
        size = _size;
        lost = 0;
        tag = 0; // tag -1 : wrong target, 0: not classified, >0: classified
        crop = _crop;
    }
    BallPoints(float _x, float _y, float _size){
        x = _x;
        y = _y;
        size = _size;
        lost = 0;
        tag = 0;
    }

    void setBallPosRaw(float _x, float _y, float _size){
        x = _x;
        y = _y;
        size = _size;
        lost = 0;
    }
    void setBallPos(float _x, float _y, cv::Mat& _H_inv){
        ball_x = _x;
        ball_y = _y;

        cv::Mat T_0 = cv::Mat::zeros(3,1,CV_64FC1);

		T_0.at<double>(0) = ball_x;
		T_0.at<double>(1) = ball_y;
		T_0.at<double>(2) = 1.0;

		cv::Mat pos0 = _H_inv*T_0;

		cx = pos0.at<double>(0)/pos0.at<double>(2)*camera_fx+camera_cx;
		cy = pos0.at<double>(1)/pos0.at<double>(2)*camera_fy+camera_cy;
    }
    sensor_msgs::CompressedImage getCrop(){
        return crop;
    }
    void setCrop(sensor_msgs::CompressedImage _crop){
        crop = _crop;
    }
    void ballLost(){
        x = ball_x;
        y = ball_y;
        lost++;
    }
};
std::vector<BallPoints> ball_points;

int done_score = 0;

bool check_vgg_input(int cx, int cy, bool initial)
{
    if(initial){
        return cx >= 100 && cx <= 540 && cy <= 300;
    }else{
        return cx >= 100 && cx <= 540 && cy <= 200;
    }
}

int point_window_x(int cx)
{
    if(cx < 0) cx = 0;
    else if (cx >= map_width) cx = map_width-1;
    return cx;
}

int point_window_y(int cy)
{
    if(cy < 0) cy = 0;
    else if (cy >= map_height) cy = map_height-1;
    return cy;
}

bool check_out(int cx, int cy)
{
    return (cx<map_width-1)&&(cx>0)&&(cy<map_height-1)&&(cy>0);
}

bool check_out_monitor(int cx, int cy)
{
    return (cx<map_width*2-1)&&(cx>0)&&(cy<map_height*2-1)&&(cy>0);
}

int point_window_rl_x(int cx)
{
    if(cx < 0) cx = 0;
    else if (cx >= rl_width) cx = rl_width-1;
    return cx;
}

int point_window_rl_y(int cy)
{
    if(cy < 0) cy = 0;
    else if (cy >= rl_height) cy = rl_height-1;
    return cy;
}

bool check_out_rl(int cx, int cy)
{
    return (cx<rl_width)&&(cx>=0)&&(cy<rl_height)&&(cy>=0);
}

bool check_out_rect(int cx1, int cy1, int cx2, int cy2)
{
    bool check1 = (cx1<=map_width-1)&&(cx1>=0)&&(cy1<=map_height-1)&&(cy1>=0);
    bool check2 = (cx2<=map_width-1)&&(cx2>=0)&&(cy2<=map_height-1)&&(cy2>=0);

    return check1 && check2;
}

void map_init();
void draw_map();

void saveTF(float time_slice, float x, float y, float theta);
int match_ball_points(std::vector<geometry_msgs::Vector3>& ball_points_new, std::vector<sensor_msgs::CompressedImage>& img_crops_new, float time_delay);

void draw_obstacle(std::vector<geometry_msgs::Vector3>& obstacle_points, cv::Mat& map, cv::Mat& map_gray, cv::Mat& map_rl, cv::Mat& map_gray_rl);
int draw_ball(std::vector<geometry_msgs::Vector3>& obstacle_points, cv::Mat& map, cv::Mat& map_gray, cv::Mat& map_rl, cv::Mat& map_gray_rl);

void draw_robot_rl(cv::Mat& map, cv::Mat& map_gray);
void draw_guide_rl(cv::Mat& map);

void draw_april(std::vector<int> tag_ids, std::vector<geometry_msgs::Vector3>& april_points, cv::Mat& map, cv::Mat& map_gray);
void draw_path(std::vector<geometry_msgs::Vector3>& path_points, cv::Mat& map, cv::Mat& map_gray);
void draw_robot(cv::Mat& map);

int monitor_draw_obstacle(cv::Mat& map_monitor_raw, cv::Mat& map_monitor, geometry_msgs::Pose2D global_odom_now);
void monitor_draw_ball(cv::Mat& map_monitor_raw, cv::Mat& map_monitor, geometry_msgs::Pose2D global_odom_now);
void monitor_draw_path(cv::Mat& map_monitor, geometry_msgs::Pose2D global_odom_now);
void monitor_draw_path_final(cv::Mat& map_monitor_resized);
void monitor_draw_ball_final(cv::Mat& map_monitor_resized, cv::Mat& map_monitor_raw_resized);
