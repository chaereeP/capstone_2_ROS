#include "map_gen.h"

bool flag_imshow = true;
bool flag_record = true;
bool flag_debug = true;

cv::VideoWriter outputVideo;
int camera_width = 640;
int camera_height = 360;
int screen_line_mid = 180;
int screen_line_top = 50;

cv::Point screen_window(int cx, int cy)
{
	if(cx < 0) cx = 0;
	else if (cx >= camera_width) cx = camera_width-1;
	if(cy < 0) cy = 0;
	else if (cy >= camera_height) cy = camera_height-1;

	return cv::Point(cx,cy);
}

void callback_balltrack(const tt_core_msgs::CompressedImagePointConstPtr& msg, const tt_core_msgs::CompressedImagePointConstPtr& msg_points)
{
    cv::Mat frame = cv::imdecode(cv::Mat(msg->frame.data), cv::IMREAD_COLOR);

	std::vector<cv::KeyPoint> keypoints_;
	for(int i=0; i<msg->Vector3DArray.size(); i++){
		keypoints_.push_back(cv::KeyPoint(msg->Vector3DArray.at(i).x, msg->Vector3DArray.at(i).y, msg->Vector3DArray.at(i).z));
	}
	cv::drawKeypoints(frame, keypoints_, frame, cv::Scalar(0,0,255), 2);

    for(int i=0; i<msg_points->Vector3DArray.size(); i++){
        int px = msg_points->Vector3DArray[i].x;
        int py = msg_points->Vector3DArray[i].y;
        int size = msg_points->Vector3DArray[i].z;

        cv::rectangle(frame, screen_window(px-size, py-size), screen_window(px+size, py+size), cv::Scalar(0,255,0), 2);
    }

	if(flag_debug){
		cv::line(frame, cv::Point(0, screen_line_mid), cv::Point(camera_width, screen_line_mid), cv::Scalar(255,125,0), 2);
		cv::line(frame, cv::Point(0, screen_line_top), cv::Point(camera_width, screen_line_top), cv::Scalar(255,125,0), 2);
	}

	if(flag_imshow){
		cv::imshow("monitor_ball_track",frame);
		cv::waitKey(1);
	}

	if(flag_record) outputVideo << frame;
}

void callbackTerminate(const std_msgs::Int32Ptr& record){
	printf("shutdown");
	if(flag_record) outputVideo.release();
    ros::shutdown();
    return;
}

int main(int argc, char** argv)
{
	if(argc < 4)
    {
        std::cout << "usage: rosrun tt_map_gen ball_detect_monitor_node flag_imshow flag_record flag_debug" << std::endl;
        return -1;
    }

	if(!strcmp(argv[1], "false")) flag_imshow = false;
    if(!strcmp(argv[2], "false")) flag_record = false;
	if(!strcmp(argv[3], "false")) flag_debug = false;

    map_init();

    ros::init(argc, argv, "map_monitor_ball");
    ros::start();

	std::string path = ros::package::getPath("tt_map_gen");
	path += "/../../../data/test_data/camera_view.mp4";

	if(flag_record) outputVideo.open(path, cv::VideoWriter::fourcc('H', '2', '6', '4'), 50, cv::Size(camera_width, camera_height), true);

    // params["Camera.H.inv"] >> H_inv;

    ros::NodeHandle nh;

    message_filters::Subscriber<tt_core_msgs::CompressedImagePoint> camera_sub(nh, "/monitor/camera", 1);
    message_filters::Subscriber<tt_core_msgs::CompressedImagePoint> ball_points_sub(nh, "/monitor/ball_points", 1);
    typedef message_filters::sync_policies::ApproximateTime<tt_core_msgs::CompressedImagePoint, tt_core_msgs::CompressedImagePoint> sync_pol;
    message_filters::Synchronizer<sync_pol> sync(sync_pol(100), camera_sub, ball_points_sub);
    sync.registerCallback(boost::bind(&callback_balltrack, _1, _2));

	ros::Subscriber end_record_sub = nh.subscribe("/tt_end_system", 1, callbackTerminate);

    ros::spin();

    return 0;
}
