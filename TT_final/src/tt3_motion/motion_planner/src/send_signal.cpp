#include "iostream"
#include <ros/ros.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <cmath>
#include <thread>
#include <fstream>
#include <chrono>
#include <ctime>

#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/Image.h>

#include <message_filters/subscriber.h>
#include <message_filters/time_synchronizer.h>
#include <message_filters/sync_policies/approximate_time.h>

#include <std_msgs/Float32MultiArray.h>
#include <tt_core_msgs/XboxFlag.h>

#include "opencv2/opencv.hpp"
#include <boost/thread.hpp>

#define PORT 4000
// const char* IPADDR = "10.42.0.133"; // old
const char* IPADDR = "10.42.0.176"; // net
int c_socket, s_socket;
struct sockaddr_in c_addr;
float data[24];
bool flag_auto = false;
bool flag_comm = true;
int flag_lost = 0;
clock_t begin, end;
boost::mutex data_mutex_;

float data_send[24];
float nozzle_speed = 1.0;

void dataInit()
{
	data[0] = 0; //lx*data[3];
	data[1] = 0; //ly*data[3];
	data[2] = 0; //GamepadStickAngle(_dev, STICK_LEFT);
	data[3] = 0; //GamepadStickLength(_dev, STICK_LEFT);
	data[4] = 0; //rx*data[7];
	data[5] = 0; //ry*data[7];
	data[6] = 0; //GamepadStickAngle(_dev, STICK_RIGHT);
	data[7] = 0; //GamepadStickLength(_dev, STICK_RIGHT);
	data[8] = 0; //GamepadTriggerLength(_dev, TRIGGER_LEFT);
	data[9] = 0; //GamepadTriggerLength(_dev, TRIGGER_RIGHT);
	data[10] = 0; //GamepadButtonDown(_dev, BUTTON_DPAD_UP);
	data[11] = 0; //GamepadButtonDown(_dev, BUTTON_DPAD_DOWN);
	data[12] = 0; //GamepadButtonDown(_dev, BUTTON_DPAD_LEFT);
	data[13] = 0; //GamepadButtonDown(_dev, BUTTON_DPAD_RIGHT);
	data[14] = 0; //GamepadButtonDown(_dev, BUTTON_A); // duct on/off
	data[15] = 0; //GamepadButtonDown(_dev, BUTTON_B);
	data[16] = 0; //GamepadButtonDown(_dev, BUTTON_X);
	data[17] = 0; //GamepadButtonDown(_dev, BUTTON_Y);
	data[18] = 0; //GamepadButtonDown(_dev, BUTTON_BACK);
	data[19] = 0; //GamepadButtonDown(_dev, BUTTON_START);
	data[20] = 0; //GamepadButtonDown(_dev, BUTTON_LEFT_SHOULDER);
	data[21] = 0; //GamepadButtonDown(_dev, BUTTON_RIGHT_SHOULDER);
	data[22] = 0; //GamepadButtonDown(_dev, BUTTON_LEFT_THUMB);
	data[23] = 0; //GamepadButtonDown(_dev, BUTTON_RIGHT_THUMB);
}

void send_signal(){
	while(1)
	{
		data_mutex_.lock();
		std::copy(std::begin(data), std::end(data), std::begin(data_send));
		data_send[5] *= -nozzle_speed;
		write(c_socket, data_send, sizeof(data_send));

		// std::cout << flag_auto << std::endl;
		// std::cout<< "Data[20]: "<< data[20] <<", data[21]: "<<data[21]<<std::endl;
		data_mutex_.unlock();
		ros::Duration(0.05).sleep();
	}
}

int flag_lost_cnt = 15;
void callback_dqn(const tt_core_msgs::XboxFlagConstPtr& msg_dqn){
	 // 0: run dqn, 1: run astar, 2: run astar and send done
	if(flag_auto){
		if(msg_dqn->flag == 2){
			flag_lost = flag_lost_cnt;
		}else{
			if(flag_lost>=0) flag_lost--;
		}

		if(msg_dqn->flag == 0 && flag_lost <= 0){
			data_mutex_.lock();
			std::copy(std::begin(msg_dqn->Float32MultiArray.data), std::end(msg_dqn->Float32MultiArray.data), std::begin(data));
			data[5] = -1;
			data_mutex_.unlock();
			std::cout << "DQN signal, flag_lost " << flag_lost << std::endl;
		}
	}
}
void callback_astar(const tt_core_msgs::XboxFlagConstPtr& msg_astar){
	 // 0: run dqn, 1: run astar, 2: run astar and send done
	if(flag_auto){
		if(msg_astar->flag == 1 || msg_astar->flag == 2 || flag_lost > 0){
			data_mutex_.lock();
			std::copy(std::begin(msg_astar->Float32MultiArray.data), std::end(msg_astar->Float32MultiArray.data), std::begin(data));
			data_mutex_.unlock();
			std::cout<< "Astar Data[20]: " << data[20] << ", data[21]: " << data[21] << std::endl;
		}
	}
	// std::cout << "Astar signal, flag_lost " << flag_lost << std::endl;
}

// void callback(const tt_core_msgs::XboxFlagConstPtr& msg_dqn, const tt_core_msgs::XboxFlagConstPtr& msg_astar){
// 	 // 0: run dqn, 1: run astar, 2: run astar and send done
// 	if(flag_auto){
// 		if(msg_dqn->flag == 2){
// 			flag_lost = 10;
// 		}else{
// 			if(flag_lost>=0) flag_lost--;
// 		}
//
// 		// std::copy(std::begin(msg_astar->Float32MultiArray.data), std::end(msg_astar->Float32MultiArray.data), std::begin(data));
// 		data_mutex_.lock();
// 		if(msg_dqn->flag == 0 && flag_lost == 0){
// 			std::copy(std::begin(msg_dqn->Float32MultiArray.data), std::end(msg_dqn->Float32MultiArray.data), std::begin(data));
// 			printf("send_signal %f\n",double(end-begin)/CLOCKS_PER_SEC);
// 		}else{
// 			std::copy(std::begin(msg_astar->Float32MultiArray.data), std::end(msg_astar->Float32MultiArray.data), std::begin(data));
// 		}
// 		data_mutex_.unlock();
// 	}
// }

void callback_xbox(const std_msgs::Float32MultiArrayConstPtr& msg_xbox){
	if(msg_xbox->data[19] > 0.9)
	{
		flag_auto = 1;
	}
	if(msg_xbox->data[18] > 0.9)
	{
		flag_auto = 0;
	}

	if(flag_auto == 0)
	{
		data_mutex_.lock();
		std::copy(std::begin(msg_xbox->data), std::end(msg_xbox->data), std::begin(data));
		data_mutex_.unlock();
		// std::cout << "suction " << data[14] << std::endl;
	}
}


int main(int argc, char** argv)
{
	begin = clock();
	if(argc < 2)
	{
		std::cout << "usage: rosrun map_gen send_signal_node flag_local" << std::endl;
		return -1;
	}

	if (!strcmp(argv[1], "local"))
    {
        strcpy("127.0.0.1", IPADDR);
    }

	ros::init(argc, argv, "send_signal");
	ros::start();

	ros::NodeHandle nh;

	// message_filters::Subscriber<tt_core_msgs::XboxFlag> dqn_sub(nh, "/dqn_planner/ctrl", 1);
    // message_filters::Subscriber<tt_core_msgs::XboxFlag> astar_sub(nh, "/motion_planner/ctrl", 1);
    // typedef message_filters::sync_policies::ApproximateTime<tt_core_msgs::XboxFlag, tt_core_msgs::XboxFlag> sync_pol;
    // message_filters::Synchronizer<sync_pol> sync(sync_pol(10), dqn_sub, astar_sub);
    // sync.registerCallback(boost::bind(&callback, _1, _2));

	ros::Subscriber dqn_sub = nh.subscribe("/dqn_planner/ctrl", 1, &callback_dqn);
	ros::Subscriber astar_sub = nh.subscribe("/motion_planner/ctrl", 1, &callback_astar);
	ros::Subscriber sub_xbox = nh.subscribe("/xbox_ctrl", 1, &callback_xbox);

	c_socket = socket(PF_INET, SOCK_STREAM, 0);
	printf("socket created\n");
	c_addr.sin_addr.s_addr = inet_addr(IPADDR);
	c_addr.sin_family = AF_INET;
	c_addr.sin_port = htons(PORT);

	if(connect(c_socket, (struct sockaddr*) &c_addr, sizeof(c_addr)) == -1){
		printf("Failed to connect\n");
		close(c_socket);
		return -1;
	}

	std::thread t(&send_signal);

	ros::spin();
	close(c_socket);

	ros::shutdown();

	return 0;
}
