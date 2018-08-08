#include "map_gen.h"
#include <ctime>
#include <thread>
#include "tt_core_msgs/MobileNetCrop.h"

bool flag_imshow = true;
bool flag_record = true;
bool flag_debug = true;

cv::VideoWriter outputVideo_HD;
cv::VideoWriter outputVideo_RL;
cv::VideoWriter outputVideo_RL_raw;

int test = 0;
clock_t begin, end;
ros::Time time_prev_ball, time_prev_tf;
ros::Time time_now_ball, time_now_tf;
ros::Duration elapse_ball, elapse_tf, ball_delay;

clock_t t0, t1, t2, t3, t4;

// bool getBallPoints(tt_core_msgs::MobileNetCrop::Request& req, tt_core_msgs::MobileNetCrop::Response& res)
// {
//     // map_mutex_.lock();
//     if (match_ball_points(req.reqArray.Vector3DArray, req.reqArray.extra[0]) != 0){
//         flag_odom_reset = 0;
//         time_now_ball = req.reqArray.header.stamp;
//         ball_delay = time_now_ball - ros::Time::now();
//         elapse_ball = time_now_ball - time_prev_ball;
//         time_prev_ball = time_now_ball;
//         std::cout << "time diff ball " << elapse_ball << ", ball delay " << ball_delay << std::endl;
//         printf("ball time %f\n", req.reqArray.extra[0]);
//     }
//     // map_mutex_.unlock();
//     res.res.data = 1;
//
//     return true;
// }
int max_ball_queue = 4;
bool checkBallPoints()
{
    // t0 = clock();
    tt_core_msgs::MobileNetCrop srv;
    map_mutex_.lock();
    std::vector<int> ball_index;
    // Sort Ball_points
    for(int i=0; i<ball_points.size(); i++) ball_index.push_back(i);
    for(int i=0; i<ball_points.size(); i++){
        for(int j=i+1; j<ball_points.size(); j++){
            if(ball_points.at(ball_index.at(i)).ball_y <= ball_points.at(ball_index.at(j)).ball_y) std::swap(ball_index.at(i), ball_index.at(j));
        }
    }
    // Put VGG Net Samples
    for(int i=0; i<ball_points.size(); i++){
        // std::cout << "ball x : " << ball_points.at(i).cx << ", ball y : " << ball_points.at(i).cy << std::endl;
        if(ball_points.at(i).tag == 0 && check_vgg_input(ball_points.at(i).cx, ball_points.at(i).cy, true)){
            if(srv.request.reqArray.FrameArray.size() >= max_ball_queue) break;
            srv.request.reqArray.id.push_back(i);
            srv.request.reqArray.FrameArray.push_back(ball_points.at(i).getCrop());
        }
    }
    for(int i=0; i<ball_points.size(); i++){
        if(ball_points.at(i).tag != 0 && check_vgg_input(ball_points.at(i).cx, ball_points.at(i).cy, true)){
            if(srv.request.reqArray.FrameArray.size() >= max_ball_queue) break;
            srv.request.reqArray.id.push_back(ball_index.at(i));
            srv.request.reqArray.FrameArray.push_back(ball_points.at(ball_index.at(i)).getCrop());
        }
    }
    map_mutex_.unlock();
    // t1 = clock();
    if(mobile_net_client.call(srv)){
        // t2 = clock();
        // ROS_INFO("Successfully call service MobileNet tag size %d", srv.response.resArray.tag.size());
        map_mutex_.lock();
        for(int i=0; i<srv.response.resArray.tag.size(); i++){
            int tag_temp = srv.response.resArray.tag[i];
            // ROS_INFO("tag %d: %d",i, tag_temp);
            // if(tag_temp == 0) ball_points.at(srv.response.resArray.id[i]).tag = -1;
            // else ball_points.at(srv.response.resArray.id[i]).tag = tag_temp;
            ball_points.at(srv.response.resArray.id[i]).tag = tag_temp;
        }
        // t3 = clock();
        // Remove Losted Ball
        std::vector<BallPoints> ball_points_temp;
        for(int i=0; i<ball_points.size(); i++){
            // if(ball_points.at(i).lost <= 20 && ball_points.at(i).tag >= 0)
            //     ball_points_temp.push_back(ball_points.at(i));
            if(ball_points.at(i).lost <= 10)
                ball_points_temp.push_back(ball_points.at(i));
            // ROS_INFO("ball lost %d", ball_points.at(i).lost);
        }
        ball_points.clear();
        ball_points.assign(ball_points_temp.begin(), ball_points_temp.end());

        // t4 = clock();
        // ROS_INFO("time elapse vggnet t10: %lf, t21: %lf, t32: %lf, t43: %lf", (t1-t0)/(double)CLOCKS_PER_SEC, (t2-t1)/(double)CLOCKS_PER_SEC, (t3-t2)/(double)CLOCKS_PER_SEC, (t4-t3)/(double)CLOCKS_PER_SEC);
        map_mutex_.unlock();
    }else{
        ROS_ERROR("Failed to call service MobileNet");
        return false;
    }

    return true;
}

void VGGNetThread(){
    while(1){
        t0 = clock();
        if(!checkBallPoints()) break;
        t4 = clock();
        // ROS_INFO("time elapse vggnet t40: %f", (float)(t4-t0)/CLOCKS_PER_SEC);
    }
}

void callbackObstacle(const tt_core_msgs::ROIPointArrayConstPtr& msg_obstacle)
{
    map_mutex_.lock();
    obstacle_points = msg_obstacle->Vector3DArray;
    lidar_count = msg_obstacle->id[0];
    lidar_angle_min = msg_obstacle->extra[0];
    lidar_angle_increment = msg_obstacle->extra[1];
    map_mutex_.unlock();
}


void callback(const tt_core_msgs::ROIPointArrayConstPtr& msg_ball, const tt_core_msgs::ROIPointArrayConstPtr& odom_pose)
{
    map_mutex_.lock();
    // if (test <= 10){
    // time_now_tf = ros::Time::now();
    // elapse_tf = time_now_tf - time_prev_tf;
    // time_prev_tf = time_now_tf;
    // printf("Detect flag_odom %d, elapse time %f\n", flag_odom_reset, elapse_tf.toSec()*1000);
    saveTF(elapse_tf.toSec()*1000, odom_pose->Vector3DArray.at(0).x, odom_pose->Vector3DArray.at(0).y, odom_pose->Vector3DArray.at(0).z);

    std::vector<geometry_msgs::Vector3> ball_points_temp = msg_ball->Vector3DArray;
    std::vector<sensor_msgs::CompressedImage> img_crops_temp = msg_ball->FrameArray;
    if(match_ball_points(ball_points_temp, img_crops_temp, msg_ball->extra[0])!=0){
        odom_init.x = odom_pose->Vector3DArray.at(0).x;
        odom_init.y = odom_pose->Vector3DArray.at(0).y;
        odom_init.theta = odom_pose->Vector3DArray.at(0).z;

        odom_now.x = odom_pose->Vector3DArray.at(0).x - odom_init.x;
        odom_now.y = odom_pose->Vector3DArray.at(0).y - odom_init.y;
        odom_now.theta = odom_pose->Vector3DArray.at(0).z - odom_init.theta;
    }

    // test++;
    // }
    map_mutex_.unlock();
    draw_map();
}

void callbackTF(const tt_core_msgs::ROIPointArrayPtr& odom_pose){
    map_mutex_.lock();

    time_now_tf = ros::Time::now();
    elapse_tf = time_now_tf - time_prev_tf;
    time_prev_tf = time_now_tf;
    saveTF(elapse_tf.toSec()*1000, odom_pose->Vector3DArray.at(0).x, odom_pose->Vector3DArray.at(0).y, odom_pose->Vector3DArray.at(0).z);

    odom_now.x = odom_pose->Vector3DArray.at(0).x - odom_init.x;
    odom_now.y = odom_pose->Vector3DArray.at(0).y - odom_init.y;
    odom_now.theta = odom_pose->Vector3DArray.at(0).z - odom_init.theta;
    // printf("TF odom now %f\n", odom_now.theta);

    map_mutex_.unlock();

    draw_map();
}

void draw_map(){
    int flag_ball = 0;

    cv::Mat map = cv::Mat::zeros(rl_width,rl_height,CV_8UC3);
    cv::Mat map_gray = cv::Mat::zeros(rl_width,rl_height,CV_8UC1);

    cv::Mat map_real = cv::Mat::zeros(map_width,map_height,CV_8UC3);
    cv::Mat map_real_gray = cv::Mat::zeros(map_width,map_height,CV_8UC1);

    draw_obstacle(obstacle_points, map_real, map_real_gray, map, map_gray);

    map_mutex_.lock();
    // 0: run dqn, 1: run astar, 2: run astar and send done, 3: dqn slow
    flag_ball = draw_ball(obstacle_points, map_real, map_real_gray, map, map_gray);
    map_mutex_.unlock();

    draw_robot_rl(map, map_gray);
    map_real.at<cv::Vec3b>(cv::Point(map_width/2, map_height-1)) = cv::Vec3b(255, 0, 0);

    cv::Mat map_gray_resized = cv::Mat::zeros(93,93,CV_8UC1);
    cv::resize(map_gray, map_gray_resized, cv::Size(93,93), 0, 0, CV_INTER_NN);

    cv::Mat map_resized_real = cv::Mat::zeros(500,500,CV_8UC3);
    cv::resize(map_real, map_resized_real, cv::Size(500,500), 0, 0, CV_INTER_NN);
    //if(flag_ball == 0 || flag_ball == 3) cv::putText(map_resized_real, "Long Range Planning", cv::Point(260,30), cv::FONT_HERSHEY_COMPLEX_SMALL, 0.8, cv::Scalar(0,255,0), 1, CV_AA);
    //else if(flag_ball == 1 || flag_ball == 2) cv::putText(map_resized_real, "Short Range Planning", cv::Point(260,30), cv::FONT_HERSHEY_COMPLEX_SMALL, 0.8, cv::Scalar(255,255,255), 1, CV_AA);

    // publish RL map
    msg_rl_map->header.stamp = ros::Time::now();
    msg_rl_map->frame = *(cv_bridge::CvImage(std_msgs::Header(), "mono8", map_gray_resized).toImageMsg());
    msg_rl_map->flag = flag_ball;
    pub_rl_map.publish(msg_rl_map);

    // publish map
    msg_map->header.stamp = ros::Time::now();
    msg_map->frame = *(cv_bridge::CvImage(std_msgs::Header(), "mono8", map_real_gray).toImageMsg());
    msg_map->flag = flag_ball;
    msg_map->track_state = tracker_state;
    pub_map.publish(msg_map);

    // publish map_monitor
    msg_map_monitor->header.stamp = ros::Time::now();
    msg_map_monitor->frame = *(cv_bridge::CvImage(std_msgs::Header(), "rgb8", map_real).toImageMsg());
    msg_map_monitor->flag = flag_ball;
    pub_map_monitor.publish(msg_map_monitor);

    if(flag_imshow)
    {
        cv::Mat map_resized = cv::Mat::zeros(rl_width*rl_debug,rl_height*rl_debug,CV_8UC3);
        cv::resize(map, map_resized, cv::Size(rl_width*rl_debug,rl_height*rl_debug), 0, 0, CV_INTER_NN);
        draw_guide_rl(map_resized);

        cv::imshow("map_real_resized",map_resized_real);
        cv::imshow("map",map_resized);
        cv::waitKey(10);
    }

    if(flag_record){
        cv::Mat map_resized = cv::Mat::zeros(rl_width*rl_debug,rl_height*rl_debug,CV_8UC3);
        cv::resize(map, map_resized, cv::Size(rl_width*rl_debug,rl_height*rl_debug), 0, 0, CV_INTER_NN);
        draw_guide_rl(map_resized);

        outputVideo_HD << map_resized_real;
        outputVideo_RL << map_resized;
        outputVideo_RL_raw << map_gray_resized;
    }
}
// Map Global Monitoring//////////////////////////////////////////////////////
cv::Mat map_monitor = cv::Mat::zeros(map_width*2,map_height*2,CV_8UC3);
cv::Mat map_monitor_raw = cv::Mat::zeros(map_width*2,map_height*2,CV_8UC3);
int monitor_obstacle_flag = 0;
bool record_monitor_path = false;
//////////////////////////////////////////////////////////////////////////////

// Map Global Monitoring
void callbackLaserTF(const tt_core_msgs::ROIPointArrayConstPtr& odom_pose){

    geometry_msgs::Pose2D global_odom_now;

    if(monitor_obstacle_flag<=10){
        global_odom_init.x = odom_pose->Vector3DArray.at(0).x;
        global_odom_init.y = odom_pose->Vector3DArray.at(0).y;
        global_odom_init.theta = odom_pose->Vector3DArray.at(0).z;
        map_mutex_.lock();
        monitor_obstacle_flag = monitor_draw_obstacle(map_monitor_raw, map_monitor, global_odom_now);
        map_mutex_.unlock();
        monitor_obstacle_flag++;
    }

    global_odom_now.x = odom_pose->Vector3DArray.at(0).x - global_odom_init.x;
    global_odom_now.y = odom_pose->Vector3DArray.at(0).y - global_odom_init.y;
    global_odom_now.theta = odom_pose->Vector3DArray.at(0).z - global_odom_init.theta;
    std::cout << "global odom x " << global_odom_now.x << ", y " << global_odom_now.y << ", theta " << global_odom_now.theta << std::endl;

    if(record_monitor_path){
        monitor_draw_ball(map_monitor_raw, map_monitor, global_odom_now);
        monitor_draw_path(map_monitor, global_odom_now);
    }

    if(flag_imshow)
    {
        cv::Mat map_monitor_resized = cv::Mat::zeros(800,800,CV_8UC3);
        cv::resize(map_monitor, map_monitor_resized, cv::Size(800,800), 0, 0, CV_INTER_NN);
        cv::imshow("map_monitor_resized",map_monitor_resized);
        cv::waitKey(10);
    }
}

void callbackPathRecord(const std_msgs::Int32Ptr& record){
    record_monitor_path = true;
}

void callbackTerminate(const std_msgs::Int32Ptr& record){
	if(flag_record){
        outputVideo_HD.release();
        outputVideo_RL.release();
        outputVideo_RL_raw.release();
    }
    std::string path = ros::package::getPath("tt_map_gen");
    path += "/../../../data/test_data/";
    cv::Mat map_monitor_raw_resized = cv::Mat::zeros(800,800,CV_8UC3);
    cv::Mat map_monitor_resized = cv::Mat::zeros(800,800,CV_8UC3);
    cv::resize(map_monitor_raw, map_monitor_raw_resized, cv::Size(800,800), 0, 0, CV_INTER_NN);
    cv::resize(map_monitor_raw, map_monitor_resized, cv::Size(800,800), 0, 0, CV_INTER_NN);
    monitor_draw_path_final(map_monitor_resized);
    monitor_draw_ball_final(map_monitor_resized, map_monitor_raw_resized);

    cv::imwrite(path+"map_monitor.png",map_monitor_resized);
    cv::imwrite(path+"map_monitor_raw.png",map_monitor_raw_resized);

    ros::shutdown();
    return;
}

int main(int argc, char** argv)
{
    if(argc < 3)
    {
        std::cout << "usage: rosrun map_gen map_gen_node flag_imshow flag_record" << std::endl;
        return -1;
    }

    if (!strcmp(argv[1], "false")) flag_imshow = false;
    if (!strcmp(argv[2], "false")) flag_record = false;

    std::string path1 = ros::package::getPath("tt_map_gen");
    std::string path2 = ros::package::getPath("tt_map_gen");
    std::string path3 = ros::package::getPath("tt_map_gen");
	path1 += "/../../../data/test_data/map_hd.mp4";
	path2 += "/../../../data/test_data/map_rl.mp4";
	path3 += "/../../../data/test_data/map_rl_raw.mp4";

	if(flag_record){
        outputVideo_HD.open(path1, cv::VideoWriter::fourcc('H', '2', '6', '4'), 50, cv::Size(500,500), true);
        outputVideo_RL.open(path2, cv::VideoWriter::fourcc('H', '2', '6', '4'), 50, cv::Size(rl_width*rl_debug,rl_height*rl_debug), true);
        outputVideo_RL_raw.open(path3, cv::VideoWriter::fourcc('H', '2', '6', '4'), 50, cv::Size(93,93), false);
    }

    map_init();

    ros::init(argc, argv, "tt3_map_gen_node");
    ros::start();

    ros::NodeHandle nh;
    pub_map = nh.advertise<tt_core_msgs::MapFlag>("/map_gen/map", 1);
    pub_rl_map = nh.advertise<tt_core_msgs::MapFlag>("/map_gen/rl_map", 1);
    msg_map.reset(new tt_core_msgs::MapFlag);
    msg_rl_map.reset(new tt_core_msgs::MapFlag);

    pub_map_monitor = nh.advertise<tt_core_msgs::MapFlag>("/map_gen/map_monitor", 1);
    msg_map_monitor.reset(new tt_core_msgs::MapFlag);

    message_filters::Subscriber<tt_core_msgs::ROIPointArray> ball_sub(nh, "/ball_detect/map_points", 1);
    message_filters::Subscriber<tt_core_msgs::ROIPointArray> ball_sub_odom(nh, "/tt_imu/pose", 1);
    typedef message_filters::sync_policies::ApproximateTime<tt_core_msgs::ROIPointArray, tt_core_msgs::ROIPointArray> sync_pol;
    message_filters::Synchronizer<sync_pol> sync(sync_pol(100), ball_sub, ball_sub_odom);
    sync.registerCallback(boost::bind(&callback, _1, _2));

    // ros::Subscriber ball_sub = nh.subscribe("/ball_detect/map_points", 1, callbackBall);
    ros::Subscriber obstacle_sub = nh.subscribe("/obstacle_detect/map_points", 1, callbackObstacle);
    ros::Subscriber odom_sub = nh.subscribe("/tt_imu/pose", 1, callbackTF);
    ros::Subscriber odom_laser_sub = nh.subscribe("/tt_laser_scan/pose", 1, callbackLaserTF);

    // VGGnet service Node
    mobile_net_client = nh.serviceClient<tt_core_msgs::MobileNetCrop>("/ball_detect/mobilenet");
    msg_mobilenet.reset(new tt_core_msgs::ROIPointArray);
    // ros::ServiceServer service = nh.advertiseService("/ball_detect/tt_map_gen", checkBallPoints);

    ros::Subscriber end_record_sub = nh.subscribe("/tt_end_system", 1, callbackTerminate);
    ros::Subscriber path_record_sub = nh.subscribe("/tt_start_path_record", 1, callbackPathRecord);

    // time_prev_ball = ros::Time::now();
    // time_prev_tf = ros::Time::now();

    std::thread(VGGNetThread).detach();
    ros::spin();

    return 0;
}
