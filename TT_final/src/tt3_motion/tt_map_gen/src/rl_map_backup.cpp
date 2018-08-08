#include "map_gen.h"
#include <ctime>
#include "tt_core_msgs/MapGenPoint.h"

int test = 0;
clock_t begin, end;
ros::Time time_prev_ball, time_prev_tf;
ros::Time time_now_ball, time_now_tf;
ros::Duration elapse_ball, elapse_tf, ball_delay;

bool writeBallPoints(tt_core_msgs::MapGenPoint::Request& req, tt_core_msgs::MapGenPoint::Response& res)
{
    // map_mutex_.lock();
    if (match_ball_points(req.reqArray.Vector3DArray, req.reqArray.extra[0]) != 0){
        flag_odom_reset = 0;
        time_now_ball = req.reqArray.header.stamp;
        ball_delay = time_now_ball - ros::Time::now();
        elapse_ball = time_now_ball - time_prev_ball;
        time_prev_ball = time_now_ball;
        std::cout << "time diff ball " << elapse_ball << ", ball delay " << ball_delay << std::endl;
        printf("ball time %f\n", req.reqArray.extra[0]);
    }
    // map_mutex_.unlock();
    res.res.data = 1;
    return true;
}

void callbackObstacle(const tt_core_msgs::ROIPointArrayConstPtr& msg_obstacle)
{
    obstacle_points = msg_obstacle->Vector3DArray;
    lidar_count = msg_obstacle->id[0];
    lidar_angle_min = msg_obstacle->extra[0];
    lidar_angle_increment = msg_obstacle->extra[1];
}


void callback(const tt_core_msgs::ROIPointArrayConstPtr& msg_ball, const tt_core_msgs::ROIPointArrayConstPtr& odom_pose)
{
    begin = clock();
    // RL map
    map_mutex_.lock();
    // if (test <= 10){
    // ball_points = msg_ball->Vector3DArray;
    odom_init.x = odom_pose->Vector3DArray.at(0).x;
    odom_init.y = odom_pose->Vector3DArray.at(0).y;
    odom_init.theta = odom_pose->Vector3DArray.at(0).z;

    odom_now.x = odom_pose->Vector3DArray.at(0).x - odom_init.x;
    odom_now.y = odom_pose->Vector3DArray.at(0).y - odom_init.y;
    odom_now.theta = odom_pose->Vector3DArray.at(0).z - odom_init.theta;

    obstacle_points = msg_obstacle->Vector3DArray;
    lidar_count = msg_obstacle->id[0];
    lidar_angle_min = msg_obstacle->extra[0];
    lidar_angle_increment = msg_obstacle->extra[1];
    std::vector<geometry_msgs::Vector3> ball_points_temp = msg_ball->Vector3DArray;
    match_ball_points(ball_points_temp);
    // printf("header ball %f, obs %f, elapse %f\n", elapse_ball, elapse_obs, msg_ball->extra[0]);
    // test++;
    // }
    map_mutex_.unlock();
    end = clock();
}

void callbackTF(const tt_core_msgs::ROIPointArrayPtr& odom_pose){
    map_mutex_.lock();
    time_now_tf = ros::Time::now();
    elapse_tf = time_now_tf - time_prev_tf;
    time_prev_tf = time_now_tf;
    saveTF(elapse_tf.toSec()*1000, odom_pose->Vector3DArray.at(0).x, odom_pose->Vector3DArray.at(0).y, odom_pose->Vector3DArray.at(0).z);
    printf("flag_odom %d, elapse time %f\n", flag_odom_reset,elapse_tf.toSec()*1000);

    if(flag_odom_reset == 0){
        odom_init.x = odom_pose->Vector3DArray.at(0).x;
        odom_init.y = odom_pose->Vector3DArray.at(0).y;
        odom_init.theta = odom_pose->Vector3DArray.at(0).z;

        odom_now.x = odom_pose->Vector3DArray.at(0).x - odom_init.x;
        odom_now.y = odom_pose->Vector3DArray.at(0).y - odom_init.y;
        odom_now.theta = odom_pose->Vector3DArray.at(0).z - odom_init.theta;

        flag_odom_reset++;
    }else{
        odom_now.x = odom_pose->Vector3DArray.at(0).x - odom_init.x;
        odom_now.y = odom_pose->Vector3DArray.at(0).y - odom_init.y;
        odom_now.theta = odom_pose->Vector3DArray.at(0).z - odom_init.theta;

        flag_odom_reset++;
    }
    map_mutex_.unlock();

    drawMap();
}

void drawMap(){
    int flag_ball = 0;

    cv::Mat map = cv::Mat::zeros(rl_width,rl_height,CV_8UC3);
    cv::Mat map_gray = cv::Mat::zeros(rl_width,rl_height,CV_8UC1);

    cv::Mat map_real = cv::Mat::zeros(map_width,map_height,CV_8UC3);
    cv::Mat map_real_gray = cv::Mat::zeros(map_width,map_height,CV_8UC1);

    draw_obstacle(obstacle_points, map_real, map_real_gray, map, map_gray);
    flag_ball = draw_ball(obstacle_points, map_real, map_real_gray, map, map_gray);

    draw_robot_rl(map, map_gray);
    map_real.at<cv::Vec3b>(cv::Point(map_width/2, map_height-1)) = cv::Vec3b(255, 0, 0);

    cv::Mat map_gray_resized = cv::Mat::zeros(93,93,CV_8UC1);
    cv::resize(map_gray, map_gray_resized, cv::Size(93,93), 0, 0, CV_INTER_NN);

    cv::Mat map_resized_real = cv::Mat::zeros(500,500,CV_8UC3);
    cv::resize(map_real, map_resized_real, cv::Size(500,500), 0, 0, CV_INTER_NN);

    // publish RL map
    msg_rl_map->header.stamp = ros::Time::now();
    msg_rl_map->frame = *(cv_bridge::CvImage(std_msgs::Header(), "mono8", map_gray_resized).toImageMsg());
    msg_rl_map->flag = flag_ball;
    pub_rl_map.publish(msg_rl_map);

    // publish map
    msg_map->header.stamp = ros::Time::now();
    msg_map->frame = *(cv_bridge::CvImage(std_msgs::Header(), "mono8", map_real_gray).toImageMsg());
    msg_map->flag = flag_ball;
    pub_map.publish(msg_map);

    if(flag_imshow)
    {
        cv::Mat map_resized = cv::Mat::zeros(rl_width*rl_debug,rl_height*rl_debug,CV_8UC3);
        cv::resize(map, map_resized, cv::Size(rl_width*rl_debug,rl_height*rl_debug), 0, 0, CV_INTER_NN);
        draw_guide_rl(map_resized);

        cv::imshow("map_real_resized",map_resized_real);
        cv::imshow("map",map_resized);
        cv::waitKey(10);
    }
}

void InterruptHandling(int sig){
    // if(msg_rl_map)
    //     delete msg_rl_map;
    // if(msg_map)
    //     delete msg_map;
    ros::shutdown();
    return;
}

int main(int argc, char** argv)
{
    signal(SIGINT, InterruptHandling);

    if(argc < 2)
    {
        std::cout << "usage: rosrun map_gen map_gen_node flag_imshow" << std::endl;
        return -1;
    }

    if (!strcmp(argv[1], "false"))
    {
        flag_imshow = false;
    }

    map_init();

    ros::init(argc, argv, "tt3_map_gen_node");
    ros::start();

    ros::NodeHandle nh;
    pub_map = nh.advertise<tt_core_msgs::MapFlag>("/map_gen/map", 1);
    pub_rl_map = nh.advertise<tt_core_msgs::MapFlag>("/map_gen/rl_map", 1);
    msg_map.reset(new tt_core_msgs::MapFlag);
    msg_rl_map.reset(new tt_core_msgs::MapFlag);

    // pub_ball = nh.advertise<tt_core_msgs::Vector3DArray>("/map_gen/ball", 1);
    // pub_obstacle = nh.advertise<tt_core_msgs::Vector3DArray>("/map_gen/obstacle", 1);

    message_filters::Subscriber<tt_core_msgs::ROIPointArray> ball_sub(nh, "/ball_detect/map_points", 1);
    message_filters::Subscriber<tt_core_msgs::ROIPointArray> ball_sub_odom(nh, "/tt_laser_scan/pose", 1);
    typedef message_filters::sync_policies::ApproximateTime<tt_core_msgs::ROIPointArray, tt_core_msgs::ROIPointArray> sync_pol;
    message_filters::Synchronizer<sync_pol> sync(sync_pol(100), ball_sub, ball_sub_odom);
    sync.registerCallback(boost::bind(&callback, _1, _2));

    // ros::Subscriber ball_sub = nh.subscribe("/ball_detect/map_points", 1, callbackBall);
    ros::Subscriber obstacle_sub = nh.subscribe("/obstacle_detect/map_points", 1, callbackObstacle);
    ros::Subscriber odom_sub = nh.subscribe("/tt_laser_scan/pose", 1, callbackTF);

    // ros::ServiceServer service = nh.advertiseService("/ball_detect/tt_map_gen", writeBallPoints);

    time_prev_ball = ros::Time::now();
    time_prev_tf = ros::Time::now();

    ros::spin();

    return 0;
}
