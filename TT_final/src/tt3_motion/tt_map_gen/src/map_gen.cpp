#include "map_gen.h"

using namespace std;

void map_init(){
    std::string path_camera = ros::package::getPath("tt3_description");
    cv::FileStorage parmas_camera(path_camera+"/config/camera-genius-640x360.yaml", cv::FileStorage::READ);

    std::string path = ros::package::getPath("tt_map_gen");
    cv::FileStorage params(path+"/config/map_gen.yaml", cv::FileStorage::READ);

    camera_fx = parmas_camera["Camera.fx"];
    camera_fy = parmas_camera["Camera.fy"];
    camera_cx = parmas_camera["Camera.cx"];
    camera_cy = parmas_camera["Camera.cy"];

    map_cx = params["Map.originH"];
    map_cy = params["Map.originV"];

    map_width = params["Map.width"];
    map_height = params["Map.height"];
    map_resol = params["Map.resolution"];
    map_monitor_resol = params["Map.monitor.resolution"];
    padding_obstacle = params["Map.obstacle.padding"];
    obstacle_connect_max = params["Map.obstacle.connect_max"];
    params_data = {params["Map.data.ball_track"],
                params["Map.data.ball"],
                params["Map.data.obstacle"],
                params["Map.data.obstacle.padding"]};

    rl_width = params["RL.Map.width"];
    rl_height = params["RL.Map.height"];
    rl_center = params["RL.Map.center"];
    rl_resol = params["RL.Map.resolution"];
    params_data_rl = {params["RL.Map.data.ball"],
                params["RL.Map.data.obstacle"],
                params["RL.Map.data.robot"],
                params["RL.Map.data.robot.padding"]};

    params["Camera.H.inv"] >> H_inv;
}

void saveTF(float time_slice, float x, float y, float theta){
    odom_queue.push_back({time_slice, x, y, theta});
    if(odom_queue.size() > 20)
        odom_queue.pop_front();
    return;
}

int match_ball_points(std::vector<geometry_msgs::Vector3>& _ball_points_new, std::vector<sensor_msgs::CompressedImage>& img_crops_new, float time_delay)
{
    float ball_x, ball_y, ball_range, ball_theta;
    int ball_index, ball_index_tmp;
    float tf_x, tf_y, tf_theta;
    float delay_sum = 0;
    cv::Mat frame = cv::Mat::zeros(360,640,CV_8UC3);

    for(int i=odom_queue.size()-1; i>=0; i--){
        if(delay_sum >= time_delay){
            tf_x = odom_queue.back().x - odom_queue.at(i).x;
            tf_y = odom_queue.back().y - odom_queue.at(i).y;
            tf_theta = odom_queue.back().theta - odom_queue.at(i).theta;
            // printf("rotation back %f, i %f, back %d, index %d\n", odom_queue.back().theta, odom_queue.at(i).theta, odom_queue.size()-1, i);
            break;
        }
        delay_sum += odom_queue.at(i).time;
        // printf("odom_queue %d, delay_sum %f\n", i, delay_sum);
    }
    // printf("rotation %f, tf_x %f, tf_y %f\n", tf_theta, tf_x, tf_y);
    float tf_max = 0.002;
    // if(tf_theta >= 0.02 || tf_theta <= -0.02 || tf_x >= tf_max || tf_x <= -tf_max || tf_y >= tf_max || tf_y <= -tf_max) return 0;

    std::vector<BallPoints> ball_points_temp_new;
    for(int i=0; i<_ball_points_new.size(); i++)
    {
        ball_range = sqrt(_ball_points_new.at(i).x*_ball_points_new.at(i).x + _ball_points_new.at(i).y*_ball_points_new.at(i).y);
        ball_theta = atan2(_ball_points_new.at(i).y,_ball_points_new.at(i).x);
        if (ball_theta < 0) ball_theta += 2*M_PI;
        ball_index = (int)(ball_theta/lidar_angle_increment);
        for(int j=-2; j<=2; j++){
            ball_index_tmp = ((ball_index+j+obstacle_points.size())%obstacle_points.size());
            ball_range = min(ball_range, obstacle_points.at(ball_index_tmp).x-0.12);
        }

        // ball_x = ball_range*cos(ball_theta);
        // ball_y = ball_range*sin(ball_theta);
        ball_x = ball_range*cos(ball_theta - tf_theta) + tf_y;
        ball_y = ball_range*sin(ball_theta - tf_theta) + tf_x;

        BallPoints ball = BallPoints(ball_x, ball_y, _ball_points_new.at(i).z, img_crops_new.at(i));
        ball.setBallPos(ball_x, ball_y, H_inv);
        ball_points_temp_new.push_back(ball);
        // ball_points.push_back(ball);
    }


    float tf_old_x, tf_old_y, tf_old_theta = 0;

    tf_old_x = odom_queue.back().x - odom_init.x;
    tf_old_y = odom_queue.back().y - odom_init.y;
    tf_old_theta = odom_queue.back().theta - odom_init.theta;

    for(int i=0; i<ball_points.size(); i++)
    {
        ball_range = sqrt(ball_points.at(i).x*ball_points.at(i).x + ball_points.at(i).y*ball_points.at(i).y);
        ball_theta = atan2(ball_points.at(i).y,ball_points.at(i).x);

        ball_x = ball_range*cos(ball_theta-tf_old_theta) + tf_old_y;
        ball_y = ball_range*sin(ball_theta-tf_old_theta) + tf_old_x;
        ball_points[i].setBallPos(ball_x, ball_y, H_inv);
    }

    // DEBUG ////////////////////////////////////////////////////
    // for(int i=0; i<ball_points_temp_new.size(); i++)
    // {
    //     cv::rectangle(frame,cv::Point(int(ball_points_temp_new.at(i).cx-ball_points_temp_new.at(i).size), int(ball_points_temp_new.at(i).cy-ball_points_temp_new.at(i).size)),\
    //                     cv::Point(int(ball_points_temp_new.at(i).cx+ball_points_temp_new.at(i).size), int(ball_points_temp_new.at(i).cy+ball_points_temp_new.at(i).size)),\
    //                     cv::Scalar(0,128,128), 2);
    // }
    // for(int j=0; j<ball_points.size(); j++)
    // {
    //     cv::rectangle(frame, cv::Point(int(ball_points.at(j).cx-ball_points.at(j).size), int(ball_points.at(j).cy-ball_points.at(j).size)),\
    //                     cv::Point(int(ball_points.at(j).cx+ball_points.at(j).size), int(ball_points.at(j).cy+ball_points.at(j).size)), cv::Scalar(128,128,0), 2);
    // }
    //
    // cv::imshow("test", frame);
    // cv::waitKey(1);
    /////////////////////////////////////////////////////////////
    std::vector<int> matched_index;
    matched_index.assign(ball_points.size(),0);

    float cx1, cy1, cx2, cy2, overlap;
    float overlap_threshold = 0.4;
    float overlap_range = 2;
    if(tf_x >= tf_max || tf_x <= -tf_max || tf_y >= tf_max || tf_y <= -tf_max){
        overlap_range = 3;
        overlap_threshold = 0.2;
    }
    if(tf_theta >= 0.02 || tf_theta <= -0.02){
        overlap_range = 4;
        overlap_threshold = 0.01;
    }

    for(int i=0; i<ball_points_temp_new.size(); i++)
    {
        float max_overlap = 0;
        int ball_index_min = -1;

        overlap = 0;
        for(int j=0; j<matched_index.size(); j++)
        {
            cx1 = max(ball_points_temp_new.at(i).cx-overlap_range*ball_points_temp_new.at(i).size, ball_points.at(j).cx-overlap_range*ball_points.at(j).size);
            cy1 = max(ball_points_temp_new.at(i).cy-overlap_range*ball_points_temp_new.at(i).size, ball_points.at(j).cy-overlap_range*ball_points.at(j).size);
            cx2 = min(ball_points_temp_new.at(i).cx+overlap_range*ball_points_temp_new.at(i).size, ball_points.at(j).cx+overlap_range*ball_points.at(j).size);
            cy2 = min(ball_points_temp_new.at(i).cy+overlap_range*ball_points_temp_new.at(i).size, ball_points.at(j).cy+overlap_range*ball_points.at(j).size);

            if(cx2>=cx1 && cy2>=cy1) overlap = (cx2-cx1)*(cy2-cy1)/ball_points_temp_new.at(i).size/ball_points.at(j).size/4/overlap_range/overlap_range;
            else overlap = 0;

            if(overlap >= max_overlap){
                ball_index_min = j;
                max_overlap = overlap;
            }
        }
        // printf("overlap %f\n",max_overlap);

        if(ball_points_temp_new.at(i).cy <= 60) overlap_threshold = 0.001;

        if(max_overlap >= overlap_threshold && ball_index_min != -1){
            ball_points[ball_index_min].setBallPosRaw(ball_points_temp_new.at(i).ball_x, ball_points_temp_new.at(i).ball_y, ball_points_temp_new.at(i).size);
            ball_points[ball_index_min].setBallPos(ball_points_temp_new.at(i).ball_x, ball_points_temp_new.at(i).ball_y, H_inv);
            if(check_vgg_input(ball_points_temp_new.at(i).cx, ball_points_temp_new.at(i).cy, false)) ball_points[ball_index_min].setCrop(ball_points_temp_new.at(i).getCrop());
            matched_index.at(ball_index_min) = 1;
            // printf("matched!\n");
        }else{
            ball_points.push_back(ball_points_temp_new.at(i));
        }
    }

    // for(int i=0; i<ball_points_temp_new.size(); i++)
    // {
    //     float ball_length_min = 10.0;
    //     int ball_index_min = -1;
    //
    //     for(int j=0; j<matched_index.size(); j++){
    //         float ball_length_temp = sqrt(pow(ball_points.at(j).ball_x-ball_points_temp_new.at(i).ball_x,2)+pow(ball_points.at(j).ball_y-ball_points_temp_new.at(i).ball_y,2));
    //         if(ball_length_min > ball_length_temp){
    //             ball_length_min = ball_length_temp;
    //             ball_index_min = j;
    //         }
    //     }
    //     printf("ball length min %f\n", ball_length_min);
    //     if(ball_length_min < 0.1+ball_points_temp_new.at(i).ball_y/2 && ball_index_min != -1){
    //         ball_points[ball_index_min].setBallPosRaw(ball_points_temp_new.at(i).ball_x, ball_points_temp_new.at(i).ball_y, ball_points_temp_new.at(i).size);
    //         ball_points[ball_index_min].setBallPos(ball_points_temp_new.at(i).ball_x, ball_points_temp_new.at(i).ball_y, H_inv);
    //
    //         matched_index.at(ball_index_min) = 1;
    //         printf("matched!\n");
    //     }else{
    //         ball_points.push_back(ball_points_temp_new.at(i));
    //     }
    // }

    for(int i=0; i<matched_index.size(); i++)
        if(matched_index.at(i) == 0)
            ball_points.at(i).ballLost();

    // // Remove Losted Ball
    // std::vector<BallPoints> ball_points_temp;
    // for(int i=0; i<ball_points.size(); i++)
    //     if(ball_points.at(i).lost <= 5 && ball_points.at(i).tag >= 0)
    //         ball_points_temp.push_back(ball_points.at(i));
    //
    // ball_points.clear();
    // ball_points.assign(ball_points_temp.begin(), ball_points_temp.end());

    return ball_points.size();
}

int draw_ball(std::vector<geometry_msgs::Vector3>& _obstacle_points, cv::Mat& map, cv::Mat& map_gray, cv::Mat& map_rl, cv::Mat& map_gray_rl)
{
    int cx, cy, cx_rl, cy_rl;
    float ball_x, ball_y, ball_range, ball_theta, ball_dist_temp;
    int ball_index, ball_index_tmp;
    int cx_track = -1;
    int cy_track = -1;
    float ball_dist = 100;

    int flag_astar = 0; // 0: run dqn, 1: run astar, 2: run astar and send done, 3: dqn slow
    int pick_track = 0;

    // std::cout << "ball_size " << ball_points.size() << std::endl;
    if(ball_points.size()==0){
        // done_score ++;
        // if (done_score >= 10){
        //     flag_astar = 2;
        //     done_score = 0;
        // }
        flag_astar = 2;
        return flag_astar;
    }

    for(int i=0; i<ball_points.size(); i++)
    {
        // printf("draw ball %d",i);
        ball_range = sqrt(ball_points.at(i).x*ball_points.at(i).x + ball_points.at(i).y*ball_points.at(i).y);
        ball_theta = atan2(ball_points.at(i).y,ball_points.at(i).x);
        if (ball_theta < 0) ball_theta += 2*M_PI;
        ball_index = (int)(ball_theta/lidar_angle_increment);
        for(int j=-2; j<=2; j++){
            ball_index_tmp = ((ball_index+j+_obstacle_points.size())%_obstacle_points.size());
            // printf("%d\n",ball_index_tmp);
            ball_range = min(ball_range, _obstacle_points.at(ball_index_tmp).x-0.12);
        }
        // printf("ball_size %d, count %d, obstacle_size %d, ball_theta %f, ball_index %d\n", ball_points.size(), lidar_count, _obstacle_points.size(), ball_theta, ball_index);
        ball_x = ball_range*cos(ball_theta - odom_now.theta) + odom_now.y;
        ball_y = ball_range*sin(ball_theta - odom_now.theta) + odom_now.x;
        ball_points[i].setBallPos(ball_x, ball_y, H_inv);

        // HD Map
        cx = point_window_x((int)(map_width/2 - ball_y/map_resol));
        cy = point_window_y(map_height-1 - (int)(ball_x/map_resol));

        if((cx<map_width-1)&&(cy<=map_height-1)&&(cx>0)&&(cy>10)){
            ball_dist_temp = sqrt(pow(cx-map_cx,2) + pow(cy-map_cy,2));

            if((cx <= map_width*3/4)&&(cx >= map_width/4)&&(ball_dist_temp + 3*map_resol <= ball_dist)&&ball_points.at(i).tag>=0){
                cx_track = cx;
                cy_track = cy;
                ball_dist = ball_dist_temp;
                pick_track = 1;
                tracker_state = ball_points.at(i).tag;
            }

            // if(ball_points.at(i).lost >= 1){
            //     map.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(128,128,128);
            // }else{
            //     map.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(0,255,0);
            // }
            if(ball_points.at(i).tag == 1){
                map.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(0,255,0);
            }else if(ball_points.at(i).tag == 2){
                map.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(255,0,255);
            }else if(ball_points.at(i).tag == 0){
                map.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(128,128,128);
            }else if(ball_points.at(i).tag == -1){
                map.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(0,0,255);
            }

            map_gray.at<uint8_t>(cv::Point(cx,cy)) = params_data.ball;
        }

        // RL Map
        cx_rl = point_window_rl_x(rl_center - (int)(ball_y/rl_resol));
        cy_rl = point_window_rl_y(rl_height-1 - (int)(ball_x/rl_resol));

        if(cy_rl >= rl_height-2 && cx_rl <= rl_center+2 && cx_rl >= rl_center-2){
            flag_astar = 1;
            // printf("ball in the box\n");
        }else if(cy_rl >= rl_height-4 && cx_rl <= rl_center+4 && cx_rl >= rl_center-4 && flag_astar!=1){
            flag_astar = 3;
        }

        if((cx_rl<rl_width-1)&&(cy_rl<rl_height-2)&&(cx_rl>=0)&&(cy_rl>=0)&&ball_points.at(i).tag>=0){
            map_rl.at<cv::Vec3b>(cv::Point(cx_rl,cy_rl)) = cv::Vec3b(0,255,0);
            map_gray_rl.at<uint8_t>(cv::Point(cx_rl,cy_rl)) = params_data_rl.ball;
        }
    }
    if(cx_track>=0 && cy_track>=0){
        map_gray.at<uint8_t>(cv::Point(cx_track,cy_track)) = params_data.ball_track;
        cv::rectangle(map,cv::Point(cx_track-1, cy_track-1),cv::Point(cx_track+1, cy_track+1), cv::Scalar(0,128,128), 1);
        if(tracker_state == 1){
            map.at<cv::Vec3b>(cv::Point(cx_track,cy_track)) = cv::Vec3b(0,255,0);
        }else if(tracker_state == 2){
            map.at<cv::Vec3b>(cv::Point(cx_track,cy_track)) = cv::Vec3b(255,0,255);
        }else if(tracker_state == 0){
            map.at<cv::Vec3b>(cv::Point(cx_track,cy_track)) = cv::Vec3b(128,128,128);
        }else if(tracker_state == -1){
            map.at<cv::Vec3b>(cv::Point(cx_track,cy_track)) = cv::Vec3b(0,0,255);
        }
        // map.at<cv::Vec3b>(cv::Point(cx_track,cy_track)) = cv::Vec3b(0,255,0);
        // printf("tracked! cx %d ,cy %d\n",cx_track,cy_track);
    }

    return flag_astar;
}

void draw_obstacle(std::vector<geometry_msgs::Vector3>& _obstacle_points, cv::Mat& map, cv::Mat& map_gray, cv::Mat& map_rl, cv::Mat& map_gray_rl)
{
    float obstacle_x, obstacle_y;
    int cx, cy;
    int cx1, cx2, cy1, cy2;

    for(int i=_obstacle_points.size()-1; i>=0; i--)
    {
        // obstacle_x = _obstacle_points.at(i).x*cos(_obstacle_points.at(i).y - odom_now.theta) + odom_now.x;
        // obstacle_y = _obstacle_points.at(i).x*sin(_obstacle_points.at(i).y - odom_now.theta) + odom_now.y;
        obstacle_x = _obstacle_points.at(i).x*cos(_obstacle_points.at(i).y);
        obstacle_y = _obstacle_points.at(i).x*sin(_obstacle_points.at(i).y);

        cx = map_width/2 - (int)(obstacle_y/map_resol);
        cy = map_height - (int)(obstacle_x/map_resol);
        cx1 = cx-padding_obstacle;
        cy1 = cy-padding_obstacle;
        cx2 = cx+padding_obstacle;
        cy2 = cy+padding_obstacle;

        if(check_out(cx,cy) && check_out_rect(cx1,cy1,cx2,cy2))
        {
            // cv::rectangle(map,cv::Point(cx1, cy1),cv::Point(cx2, cy2), cv::Scalar(63,63,0), -1);
            cv::rectangle(map_gray,cv::Point(cx1, cy1), cv::Point(cx2, cy2), params_data.obstacle_padding, -1);
        }
    }

    int cx_prev = -1;
    int cy_prev = -1;

    int cx_rl, cy_rl;
    int cx_prev_rl = -1;
    int cy_prev_rl = -1;

    for(int i=_obstacle_points.size()-1; i>=0; i--)
    {
        // obstacle_x = _obstacle_points.at(i).x*cos(_obstacle_points.at(i).y - odom_now.theta) + odom_now.x;
        // obstacle_y = _obstacle_points.at(i).x*sin(_obstacle_points.at(i).y - odom_now.theta) + odom_now.y;
        obstacle_x = _obstacle_points.at(i).x*cos(_obstacle_points.at(i).y);
        obstacle_y = _obstacle_points.at(i).x*sin(_obstacle_points.at(i).y);

        // HD Map
        cx = map_width/2 - (int)(obstacle_y/map_resol);
        cy = map_height - (int)(obstacle_x/map_resol);

        if (cx_prev == -1 || cy_prev == -1){
            cx_prev = cx;
            cy_prev = cy;
        }

        if(check_out(cx,cy))
        {
            map.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(255,255,0);
            map_gray.at<uint8_t>(cv::Point(cx,cy)) = params_data.obstacle;
        }

        if(check_out(cx,cy) && check_out(cx_prev,cy_prev) && (abs(cx-cx_prev)+abs(cy-cy_prev)) < obstacle_connect_max)
        {
            cv::line(map, cv::Point(cx_prev,cy_prev), cv::Point(cx,cy), cv::Scalar(255,255,0), 2);
            cv::line(map_gray, cv::Point(cx_prev,cy_prev), cv::Point(cx,cy), params_data.obstacle, 2);
        }

        cx_prev = cx;
        cy_prev = cy;

        // RL Map
        cx_rl = rl_center - (int)(obstacle_y/rl_resol);
        cy_rl = rl_height - (int)(obstacle_x/rl_resol);

        if (cx_prev_rl == -1 || cy_prev_rl == -1){
            cx_prev_rl = cx_rl;
            cy_prev_rl = cy_rl;
        }

        if(check_out_rl(cx_rl,cy_rl))
        {
            map_rl.at<cv::Vec3b>(cv::Point(cx_rl,cy_rl)) = cv::Vec3b(255,255,0);
            map_gray_rl.at<uint8_t>(cv::Point(cx_rl,cy_rl)) = params_data_rl.obstacle;
        }

        if(check_out_rl(cx_rl,cy_rl) && check_out_rl(cx_prev_rl,cy_prev_rl) && (abs(cx_rl-cx_prev_rl)+abs(cy_rl-cy_prev_rl)) < obstacle_connect_max/3)
        {
            cv::line(map_rl, cv::Point(cx_prev_rl,cy_prev_rl), cv::Point(cx_rl,cy_rl), cv::Scalar(255,255,0), 1);
            cv::line(map_gray_rl, cv::Point(cx_prev_rl,cy_prev_rl), cv::Point(cx_rl,cy_rl), params_data_rl.obstacle, 1);
        }

        cx_prev_rl = cx_rl;
        cy_prev_rl = cy_rl;
    }
}

void draw_robot_rl(cv::Mat& map, cv::Mat& map_gray)
{
    map.at<cv::Vec3b>(cv::Point(rl_center,rl_height-1)) = cv::Vec3b(255,0,0);

    cv::rectangle(map_gray, cv::Point(rl_center-2,rl_height-2), cv::Point(rl_center+2,rl_height-1), params_data_rl.robot_padding, -1);
    map_gray.at<uint8_t>(cv::Point(rl_center,rl_height-1)) = params_data_rl.robot;
}

void draw_guide_rl(cv::Mat& map)
{
    for(int i=0; i<rl_width; i++){
        cv::line(map, cv::Point(i*rl_debug,0), cv::Point(i*rl_debug,rl_height*rl_debug-1), cv::Scalar(128,128,128), 1);
        cv::line(map, cv::Point(0,i*rl_debug), cv::Point(rl_height*rl_debug-1,i*rl_debug), cv::Scalar(128,128,128), 1);
    }
    cv::line(map, cv::Point((rl_center+5)*rl_debug,rl_height*rl_debug-1), \
                cv::Point(rl_width*rl_debug-1,(rl_height*rl_debug-int(rl_guide*(rl_center-1-5))*rl_debug)), cv::Scalar(128,128,128), 1);
    cv::line(map, cv::Point((rl_center-5+1)*rl_debug,rl_height*rl_debug-1), \
                cv::Point(0,(rl_height*rl_debug-int(rl_guide*(rl_center-1-5))*rl_debug)), cv::Scalar(128,128,128), 1);

    cv::rectangle(map, cv::Point((rl_center-2)*rl_debug-1,(rl_height-2)*rl_debug+1), \
                    cv::Point((rl_center+3)*rl_debug,rl_height*rl_debug-1), cv::Scalar(0,0,255), 2);
}

void draw_path(std::vector<geometry_msgs::Vector3>& path_points, cv::Mat& map, cv::Mat& map_gray)
{
    int path_size = min((int)path_points.size(),30);
    for(int i=0; i<path_size; i++)
    {
        int cx = path_points.at(i).x;
        int cy = path_points.at(i).y;

        map.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(128,128,128);
    }
}

void draw_robot(cv::Mat& map)
{
    cv::line(map, cv::Point(map_width/2,map_height-3), cv::Point(map_width/2,map_height-1), cv::Scalar(255,255,255), 1);
    cv::rectangle(map, cv::Point(map_width/2-1,map_height-2), cv::Point(map_width/2+1,map_height-1), cv::Scalar(255,255,255), -1);
}

int monitor_draw_obstacle(cv::Mat& map_monitor_raw, cv::Mat& map_monitor, geometry_msgs::Pose2D global_odom_now)
{
    float robot_x = global_odom_now.x;
    float robot_y = global_odom_now.y;
    int robot_cx, robot_cy;

    // HD Map
    robot_cx = (int)(map_width/2 - robot_y/map_monitor_resol) + map_width/2;
    robot_cy = map_height-1 - (int)(robot_x/map_monitor_resol);

    float obstacle_x, obstacle_y;
    int cx, cy;

    int cx_prev = -1;
    int cy_prev = -1;

    for(int i=obstacle_points.size()-1; i>=0; i--)
    {
        if(obstacle_points.at(i).x >= 3.5 or obstacle_points.at(i).x <= -3.5) continue;
        obstacle_x = obstacle_points.at(i).x*cos(obstacle_points.at(i).y);
        obstacle_y = obstacle_points.at(i).x*sin(obstacle_points.at(i).y);

        // std::cout << "obs x : " << obstacle_x << ", y : " << obstacle_y <<std::endl;
        // std::cout << "obs_point x : " << obstacle_points.at(i).x << ", y : " << obstacle_points.at(i).y <<std::endl;

        // HD Map
        cx = (int)(map_width - obstacle_y/map_monitor_resol);
        cy = (int)(map_height - obstacle_x/map_monitor_resol);

        if (cx_prev == -1 || cy_prev == -1){
            cx_prev = cx;
            cy_prev = cy;
        }

        map_monitor_raw.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(255,255,0);
        map_monitor.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(255,255,0);

        if(check_out_monitor(cx,cy) && check_out_monitor(cx_prev,cy_prev) && (abs(cx-cx_prev)+abs(cy-cy_prev)) < obstacle_connect_max)
        {
            cv::line(map_monitor_raw, cv::Point(cx_prev,cy_prev), cv::Point(cx,cy), cv::Scalar(255,255,0), 2);
            cv::line(map_monitor, cv::Point(cx_prev,cy_prev), cv::Point(cx,cy), cv::Scalar(255,255,0), 2);
        }

        cx_prev = cx;
        cy_prev = cy;
    }

    // cv::rectangle(map_monitor_raw, cv::Point(robot_cx-6, robot_cy-6), cv::Point(robot_cx+6, robot_cy+6), cv::Scalar(0,0,0), -1);
    // cv::rectangle(map_monitor, cv::Point(robot_cx-6, robot_cy-6), cv::Point(robot_cx+6, robot_cy+6), cv::Scalar(0,0,0), -1);

    return obstacle_points.size();
}

void monitor_draw_ball(cv::Mat& map_monitor_raw, cv::Mat& map_monitor, geometry_msgs::Pose2D global_odom_now)
{
    float robot_x = global_odom_now.x;
    float robot_y = global_odom_now.y;
    float robot_theta = global_odom_now.theta;

    int cx, cy, cx_rl, cy_rl;
    float ball_x, ball_y, ball_range, ball_theta, ball_x_tmp, ball_y_tmp;
    int draw_flag = 0;

    for(int i=0; i<ball_points.size(); i++)
    {
        ball_x = ball_points.at(i).x;
        ball_y = ball_points.at(i).y;

        // RL Map
        cx_rl = point_window_rl_x(rl_center - (int)(ball_y/rl_resol));
        cy_rl = point_window_rl_y(rl_height-1 - (int)(ball_x/rl_resol));

        if(cy_rl >= rl_height-1 && cx_rl == rl_center && monitor_ball_draw_flag == 0){
            draw_flag++;
            monitor_ball_draw_flag++;

            ball_x += 0.1;
            ball_range = sqrt(ball_x*ball_x + ball_y*ball_y);
            ball_theta = atan2(ball_y, ball_x);
            ball_x_tmp = ball_range*cos(ball_theta + robot_theta) - robot_x;
            ball_y_tmp = ball_range*sin(ball_theta + robot_theta) - robot_y;
            std::cout << "ball_theta : " << ball_theta << std::endl;

            // HD Map
            cx = map_width - (int)(ball_y_tmp/map_resol);
            cy = map_height-1 - (int)(ball_x_tmp/map_resol);

            // cx = (int)(map_width/2 + robot_y/map_monitor_resol) + map_width/2;
            // cy = map_height-1 + (int)(robot_x/map_monitor_resol);

            if(ball_points.at(i).tag == 1){
                // cv::rectangle(map_monitor_raw,cv::Point(cx-1, cy-1),cv::Point(cx+1, cy+1), cv::Scalar(0,255,0), -1);
                // cv::rectangle(map_monitor,cv::Point(cx-1, cy-1),cv::Point(cx+1, cy+1), cv::Scalar(0,255,0), -1);
                // map_monitor_raw.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(0,255,0);
                map_monitor.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(0,255,0);
                monitor_ball_array.push_back(std::make_pair(cx,cy));
            }else if(ball_points.at(i).tag == 2){
                // cv::rectangle(map_monitor_raw,cv::Point(cx-1, cy-1),cv::Point(cx+1, cy+1), cv::Scalar(255,0,255), -1);
                // cv::rectangle(map_monitor,cv::Point(cx-1, cy-1),cv::Point(cx+1, cy+1), cv::Scalar(255,0,255), -1);
                // map_monitor_raw.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(255,0,255);
                map_monitor.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(255,0,255);
                monitor_ball_array.push_back(std::make_pair(cx,cy));
            }else if(ball_points.at(i).tag == 0){
                // cv::rectangle(map_monitor_raw,cv::Point(cx-1, cy-1),cv::Point(cx+1, cy+1), cv::Scalar(128,128,128), -1);
                // cv::rectangle(map_monitor,cv::Point(cx-1, cy-1),cv::Point(cx+1, cy+1), cv::Scalar(128,128,128), -1);
                // map_monitor_raw.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(128,128,128);
                map_monitor.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(128,128,128);
                monitor_ball_draw_flag--;
                draw_flag--;
            }else if(ball_points.at(i).tag == -1){
                // cv::rectangle(map_monitor_raw,cv::Point(cx-1, cy-1),cv::Point(cx+1, cy+1), cv::Scalar(0,0,255), -1);
                // cv::rectangle(map_monitor,cv::Point(cx-1, cy-1),cv::Point(cx+1, cy+1), cv::Scalar(0,0,255), -1);
                // map_monitor_raw.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(0,0,255);
                map_monitor.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(0,0,255);
                monitor_ball_draw_flag--;
                draw_flag--;
            }
        }
    }
    if(draw_flag == 0) monitor_ball_draw_flag = 0;
}

void monitor_draw_path(cv::Mat& map_monitor, geometry_msgs::Pose2D global_odom_now)
{
    float robot_x = global_odom_now.x;
    float robot_y = global_odom_now.y;
    int cx, cy;

    // HD Map
    cx = map_width + (int)(robot_y/map_monitor_resol);
    cy = map_height-1 + (int)(robot_x/map_monitor_resol);

    monitor_path_array.push_back(std::make_pair(cx,cy));
    map_monitor.at<cv::Vec3b>(cv::Point(cx,cy)) = cv::Vec3b(0,255,255);
}

void monitor_draw_ball_final(cv::Mat& map_monitor_resized, cv::Mat& map_monitor_raw_resized)
{
    int cx, cy;
    int cx_prev, cy_prev;
    int dist_min = 50;
    int dist;

    cx_prev = -1;
    cy_prev = -1;

    for(int i=0; i<monitor_ball_array.size(); i++){
        cx = monitor_ball_array.at(i).first*4;
        cy = monitor_ball_array.at(i).second*4;
        if(i==0){
            cx_prev = cx;
            cy_prev = cy;
            if(ball_points.at(i).tag == 1){
                cv::circle(map_monitor_raw_resized, cv::Point(cx, cy), 3, cv::Scalar(0,255,0), -1);
                cv::circle(map_monitor_resized, cv::Point(cx, cy), 3, cv::Scalar(0,255,0), -1);
            }else if(ball_points.at(i).tag == 2){
                cv::circle(map_monitor_raw_resized, cv::Point(cx, cy), 3, cv::Scalar(255,0,255), -1);
                cv::circle(map_monitor_resized, cv::Point(cx, cy), 3, cv::Scalar(255,0,255), -1);
            }
        }else{
            dist = abs(cx-cx_prev) + abs(cy-cy_prev);
            if(dist>dist_min){
                cx_prev = cx;
                cy_prev = cy;

                if(ball_points.at(i).tag == 1){
                    cv::circle(map_monitor_raw_resized, cv::Point(cx, cy), 3, cv::Scalar(0,255,0), -1);
                    cv::circle(map_monitor_resized, cv::Point(cx, cy), 3, cv::Scalar(0,255,0), -1);
                }else if(ball_points.at(i).tag == 2){
                    cv::circle(map_monitor_raw_resized, cv::Point(cx, cy), 3, cv::Scalar(255,0,255), -1);
                    cv::circle(map_monitor_resized, cv::Point(cx, cy), 3, cv::Scalar(255,0,255), -1);
                }
            }
        }
    }
}

void monitor_draw_path_final(cv::Mat& map_monitor_resized)
{
    int cx, cy;
    int cx_prev, cy_prev;
    int cx_prev_line, cy_prev_line;
    int dist_min = 50;
    int dist_min_line = 10;
    int dist, dist_line;

    cx_prev = -1;
    cy_prev = -1;

    std::vector<std::pair<int,int>> draw_array;

    for(int i=0; i<monitor_path_array.size(); i++){
        cx = monitor_path_array.at(i).first*4;
        cy = monitor_path_array.at(i).second*4;
        if(i==0){
            cx_prev = cx;
            cy_prev = cy;
            cx_prev_line = cx;
            cy_prev_line = cy;
            draw_array.push_back(std::make_pair(cx,cy));
        }else{
            dist = abs(cx-cx_prev) + abs(cy-cy_prev);
            if(dist>dist_min){
                draw_array.push_back(std::make_pair(cx,cy));
                cx_prev = cx;
                cy_prev = cy;
            }
            dist_line = abs(cx-cx_prev_line) + abs(cy-cy_prev_line);
            if(dist_line>dist_min_line){
                cv::line(map_monitor_resized, cv::Point(cx_prev_line,cy_prev_line), cv::Point(cx,cy), cv::Scalar(0,255,255), 1);
                cx_prev_line = cx;
                cy_prev_line = cy;
            }
        }
    }

    for(int i=0; i<draw_array.size(); i++){
        cx = draw_array.at(i).first;
        cy = draw_array.at(i).second;
        cv::rectangle(map_monitor_resized, cv::Point(cx-2, cy-2), cv::Point(cx+2, cy+2), cv::Scalar(0,255,255), -1);
        cv::rectangle(map_monitor_resized, cv::Point(cx-2, cy-2), cv::Point(cx+2, cy+2), cv::Scalar(0,64,255), 2);
    }
}
