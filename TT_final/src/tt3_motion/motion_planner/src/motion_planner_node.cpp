#include "iostream"
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <cmath>

#include <ros/ros.h>
#include <ros/package.h>

#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/Image.h>
#include <std_msgs/Float32MultiArray.h>
#include <geometry_msgs/Vector3.h>
#include "tt_core_msgs/Vector3DArray.h"

#include "opencv2/opencv.hpp"

/////////////// path finder
#include <iostream>
#include <iomanip>
#include <unordered_map>
#include <unordered_set>
#include <array>
#include <vector>
#include <utility>
#include <queue>
#include <tuple>
#include <algorithm>

using std::unordered_map;
using std::unordered_set;
using std::array;
using std::vector;
using std::queue;
using std::priority_queue;
using std::pair;
using std::tuple;
using std::tie;
using std::string;

float data[24];
bool flag_auto = false;
bool flag_comm = true;
bool flag_imshow = true;

void track_ball(int x, int y, int targetPosX, int targetPosY,bool findBarrier);

void search_ball(bool fb);

ros::Publisher msg_pub;
std_msgs::Float32MultiArrayPtr msg_ctrl_;

ros::Publisher point_pub;
tt_core_msgs::Vector3DArrayPtr msg_map_points_;

/** Please convert this part to yaml controllable constant*/
// These variables are used in ball tracker
float originH;
float originV;
float fullSpeedDist;
float ductOnDist;
float movementThreshold;
int eatThreshold;
float rotationHSConstant;
float rotationLSConstant;
float reverseXVelocity;
float reverseYVelocity;
float reverseZVelocity;
float ductDirectionConstant;

float heuristicGainAbs, heuristicGainDist;

int pathTarget;
int aStarForestsCost;
int aStarWallCost;

int searchCamSwingThreshold;
int searchWaitThreshold;
int searchRotateThreshold;

float searchFindRotateVelocity;
float searchRotateVelocity;
int searchFindCountConstant;
/** Please convert this part to yaml controllable constant*/


int eatCount = 0;
int searchCount = 0;
int searchStatus = 0;
int rotateStatus = 0;


template<typename L>
struct SimpleGraph {
  typedef L Location;
  typedef typename vector<Location>::iterator iterator;
  unordered_map<Location, vector<Location> > edges;

  inline const vector<Location>  neighbors(Location id) {
    return edges[id];
  }
};
//
// SimpleGraph<char> example_graph {{
//     {'A', {'B'}},
//     {'B', {'A', 'C', 'D'}},
//     {'C', {'A'}},
//     {'D', {'E', 'A'}},
//     {'E', {'B'}}
//   }};
//
// Helpers for SquareGrid::Location

// When using std::unordered_map<T>, we need to have std::hash<T> or
// provide a custom hash function in the constructor to unordered_map.
// Since I'm using std::unordered_map<tuple<int,int>> I'm defining the
// hash function here. It would be nice if C++ automatically provided
// the hash function for tuple and pair, like Python does. It would
// also be nice if C++ provided something like boost::hash_combine. In
// any case, here's a simple hash function that combines x and y:
namespace std {
  template <>
  struct hash<tuple<int,int> > {
    inline size_t operator()(const tuple<int,int>& location) const {
      int x, y;
      tie (x, y) = location;
      return x * 1812433253 + y;
    }
  };
}

// For debugging it's useful to have an ostream::operator << so that we can write cout << foo
std::basic_iostream<char>::basic_ostream& operator<<(std::basic_iostream<char>::basic_ostream& out, tuple<int,int> loc) {
  int x, y;
  tie (x, y) = loc;
  out << '(' << x << ',' << y << ')';
  return out;
}

// This outputs a grid. Pass in a distances map if you want to print
// the distances, or pass in a point_to map if you want to print
// arrows that point to the parent location, or pass in a path vector
// if you want to draw the path.
template<class Graph>
void draw_grid(const Graph& graph, int field_width,
               unordered_map<typename Graph::Location, double>* distances=nullptr,
               unordered_map<typename Graph::Location, typename Graph::Location>* point_to=nullptr,
               vector<typename Graph::Location>* path=nullptr) {
  for (int y = 0; y != graph.height; ++y) {
    for (int x = 0; x != graph.width; ++x) {
      typename Graph::Location id {x, y};
      std::cout << std::left << std::setw(field_width);
      if (graph.walls.count(id)) {
        std::cout << string(field_width, '#');
      } else if (point_to != nullptr && point_to->count(id)) {
        int x2, y2;
        tie (x2, y2) = (*point_to)[id];
        // TODO: how do I get setw to work with utf8?
        if (x2 == x + 1) { std::cout << "\u2192 "; }
        else if (x2 == x - 1) { std::cout << "\u2190 "; }
        else if (y2 == y + 1) { std::cout << "\u2193 "; }
        else if (y2 == y - 1) { std::cout << "\u2191 "; }
        else { std::cout << "* "; }
      } else if (distances != nullptr && distances->count(id)) {
        std::cout << (*distances)[id];
      } else if (path != nullptr && find(path->begin(), path->end(), id) != path->end()) {
        std::cout << '@';
      } else {
        std::cout << '.';
      }
  }
    std::cout << std::endl;
  }


}

struct SquareGrid {
  typedef tuple<int,int> Location;
  static array<Location, 4> DIRS;

  int width, height;
  unordered_set<Location> walls;

  SquareGrid(int width_, int height_)
     : width(width_), height(height_) {}

  inline bool in_bounds(Location id) const {
    int x, y;
    tie (x, y) = id;
    return 0 <= x && x < width && 0 <= y && y < height;
  }

  inline bool passable(Location id) const {
    return !walls.count(id);
  }

  vector<Location> neighbors(Location id) const {
    int x, y, dx, dy;
    tie (x, y) = id;
    vector<Location> results;

    for (auto dir : DIRS) {
      tie (dx, dy) = dir;
      Location next(x + dx, y + dy);
      if (in_bounds(next) && passable(next)) {
        results.push_back(next);
      }
    }

    if ((x + y) % 2 == 0) {
      // aesthetic improvement on square grids
      std::reverse(results.begin(), results.end());
    }

    return results;
  }
};

array<SquareGrid::Location, 4> SquareGrid::DIRS {Location{1, 0}, Location{0, -1}, Location{-1, 0}, Location{0, 1}};

void add_rect(SquareGrid& grid, int x1, int y1, int x2, int y2) {
  for (int x = x1; x < x2; ++x) {
    for (int y = y1; y < y2; ++y) {
      grid.walls.insert(SquareGrid::Location { x, y });
    }
  }
}

struct GridWithWeights: SquareGrid {
  unordered_set<Location> forests;
  unordered_set<Location> rivers;
  GridWithWeights(int w, int h): SquareGrid(w, h) {}
  double cost(Location from_node, Location to_node) const  {
        // if(walls.count(to_node))
        //     return aStarWallCost;
        if(forests.count(to_node))
            return aStarForestsCost;
        else if(rivers.count(to_node))
            return aStarWallCost;
        else
            return 1;
        //return forests.count(to_node) ? aStarForestsCost:1;
  }
};

GridWithWeights init_map() {
  GridWithWeights grid(100, 100);

  return grid;
}

void add_barriers(GridWithWeights& grid) {
    int x1 = 20,x2 = 40, y1 = 20, y2= 40;
    int x3 = 10,x4 =15, y3 = 10, y4 = 15;
  for (int x = x1; x < x2; ++x) {
    for (int y = y1; y < y2; ++y) {
      grid.rivers.insert(SquareGrid::Location { x, y });
    }
  }
/*
  for (int x = x3; x < x4; ++x) {
    for (int y = y3; y < y4; ++y) {
      grid.forests.insert(SquareGrid::Location { x, y });
    }
  }
*/
}


void add_walls(GridWithWeights& grid,int x, int y) {
      grid.rivers.insert(SquareGrid::Location { x, y });
}

void add_forests(GridWithWeights& grid,int x, int y) {
     // grid.walls.insert(SquareGrid::Location { x, y });
      grid.forests.insert(SquareGrid::Location { x, y });
}



GridWithWeights make_diagram4() {
  GridWithWeights grid(100, 100);
  //add_rect(grid, 1, 7, 4, 9);
  typedef SquareGrid::Location L;
  return grid;
}

template<typename T, typename priority_t>
struct PriorityQueue {
  typedef pair<priority_t, T> PQElement;
  priority_queue<PQElement, vector<PQElement>,
                 std::greater<PQElement>> elements;

  inline bool empty() const { return elements.empty(); }

  inline void put(T item, priority_t priority) {
    elements.emplace(priority, item);
  }

  inline T get() {
    T best_item = elements.top().second;
    elements.pop();
    return best_item;
  }
};

template<typename Graph>
void dijkstra_search
  (const Graph& graph,
   typename Graph::Location start,
   typename Graph::Location goal,
   unordered_map<typename Graph::Location, typename Graph::Location>& came_from,
   unordered_map<typename Graph::Location, double>& cost_so_far)
{
  typedef typename Graph::Location Location;
  PriorityQueue<Location, double> frontier;
  frontier.put(start, 0);

  came_from[start] = start;
  cost_so_far[start] = 0;

  while (!frontier.empty()) {
    auto current = frontier.get();

    if (current == goal) {
      break;
    }

    for (auto next : graph.neighbors(current)) {
      double new_cost = cost_so_far[current] + graph.cost(current, next);
      if (!cost_so_far.count(next) || new_cost < cost_so_far[next]) {
        cost_so_far[next] = new_cost;
        came_from[next] = current;
        frontier.put(next, new_cost);
      }
    }
  }
}


template<typename Location>
vector<Location> reconstruct_path(
   Location start,
   Location goal,
   unordered_map<Location, Location>& came_from
) {

  vector<Location> path;
  Location current = goal;
  path.push_back(current);
  while (current != start) {
    current = came_from[current];
    path.push_back(current);
  }
  path.push_back(start); // optional
  std::reverse(path.begin(), path.end());

  //std::cout<<std::endl<<"Path at 5 "<<path.at(5)<<std::endl<<std::endl;
  return path;
}

inline double heuristic(SquareGrid::Location a, SquareGrid::Location b) {
  int x1, y1, x2, y2;
  tie (x1, y1) = a;
  tie (x2, y2) = b;
  return sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))*heuristicGainAbs+(abs(x1-x2)+abs(y1-y2))*heuristicGainDist;
  //return abs(x1 - x2) + abs(y1 - y2);
}

template<typename Graph>
void a_star_search
  (const Graph& graph,
   typename Graph::Location start,
   typename Graph::Location goal,
   unordered_map<typename Graph::Location, typename Graph::Location>& came_from,
   unordered_map<typename Graph::Location, double>& cost_so_far)
{
  typedef typename Graph::Location Location;
  PriorityQueue<Location, double> frontier;
  frontier.put(start, 0);

  came_from[start] = start;
  cost_so_far[start] = 0;

  while (!frontier.empty()) {
    auto current = frontier.get();

    if (current == goal) {
      break;
    }

    for (auto next : graph.neighbors(current)) {
      double new_cost = cost_so_far[current] + graph.cost(current, next);
      if (!cost_so_far.count(next) || new_cost < cost_so_far[next]) {
        cost_so_far[next] = new_cost;
        double priority = new_cost + heuristic(next, goal);
        frontier.put(next, priority);
        came_from[next] = current;
      }
    }
  }
}



//////////////////


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

void dataSend()
{
	msg_ctrl_->data.clear();
	msg_ctrl_->data.insert(msg_ctrl_->data.end(), data, data+24);
	msg_pub.publish(msg_ctrl_);
}


void map_display(vector<SquareGrid::Location> &path )
{
    msg_map_points_->Vector3DArray.clear();

    geometry_msgs::Vector3 msg_point_;
    msg_point_.x = 0;
    msg_point_.y = 0;
    msg_point_.z = 1;

    //std::cout<<"Path size is "<<path.size()<<std::endl;
    for(int i=0;i< path.size();i++)
    {
        tie(msg_point_.x,msg_point_.y) = path.at(i);
        //std::cout<<"Path Construction X: "<< msg_point_.x <<" , Y: "<< msg_point_.y << " , size : "<<path.size()<<std::endl;

        msg_map_points_->Vector3DArray.push_back(msg_point_);

    }
//    std::cout<<"Map_Display()"<<std::endl;
    msg_map_points_->header.stamp = ros::Time::now();
    point_pub.publish(msg_map_points_);
}

void callback_xbox(const std_msgs::Float32MultiArrayConstPtr& msg_xbox){
    vector<SquareGrid::Location> null_path;
    if(msg_xbox->data[19] > 0.9)
	{
		flag_auto = 1;
	}
	if(msg_xbox->data[18]>0.9)
	{
		flag_auto = 0;
	}
	if(!flag_auto)
	{
		std::copy(std::begin(msg_xbox->data), std::end(msg_xbox->data), std::begin(data));
        map_display(null_path);
        searchStatus = 0;
		if(flag_comm)
            dataSend();
	}
}



bool isBallExist(cv::Mat &map, int &x, int &y)
{
	int i,j,jLow, jHigh; //i,j represents the
	x = 0;
	y = 0;

	for(i = 99;i>=0;i--)
	{
		jLow = 0;
		jHigh = 100;

		// if(i<50) {
		// 	//set jLow,jHigh
		// }
		// else {
		// 	jLow = 0;
		// 	jHigh =100;
		// }

		for(j=jLow; j<jHigh;j++){
			if (+map.at<uchar>(cv::Point(i,j)) == 1){
				y = i;
				x = j;
				return true;
			}
		}
	}
	return false;
}



bool scanMap(cv::Mat &map, int &ballPosX, int &ballPosY, int &targetPosX, int &targetPosY, bool &find_barrier)
{
	GridWithWeights grid_barrier = init_map();
    GridWithWeights grid_clean = init_map();
	SquareGrid::Location map_start;
	SquareGrid::Location map_goal;
	unordered_map<SquareGrid::Location, SquareGrid::Location> came_from_barrier;
    unordered_map<SquareGrid::Location, SquareGrid::Location> came_from_clean;

	unordered_map<SquareGrid::Location, double> cost_so_far_barrier;

	unordered_map<SquareGrid::Location, double> cost_so_far_clean;
	vector<SquareGrid::Location> path_barrier, path_clean;

	bool find_ball = false;
    //bool  = false;

	int i,j,jLow, jHigh; //i,j represents the
	int px_val;
	ballPosX = 0;
	ballPosY = 0;
    targetPosX = 0;
    targetPosY = 0;
	//grid_barrier = init_map();
	//grid_clean = init_map();
	map_start = SquareGrid::Location {originH, originV};
    std::cout<<"ScanMap"<<std::endl;
	for(i = 0;i<100;++i)
	{
		for(j=0;j<100;++j)
		{
			px_val = +map.at<uchar>(cv::Point(i,j));

			switch(px_val)
			{

				case 1://target ball;
					//x = i;
					//y = j;
					map_goal = SquareGrid::Location{i,j};
					find_ball = true;
					break;
				case 2: //No target ball
					find_ball = true;
					break;
				case 100:
				case 200:
					add_walls(grid_barrier, i,j);
					break;
				case 150:
				case 50:
					add_forests(grid_barrier, i,j);
					break;
				default:
					break;
			}
		}
	}


	if(find_ball)
	{
		a_star_search(grid_barrier, map_start, map_goal, came_from_barrier, cost_so_far_barrier);
		a_star_search(grid_clean, map_start, map_goal, came_from_clean, cost_so_far_clean);

		path_barrier = reconstruct_path(map_start, map_goal, came_from_barrier);
        path_clean = reconstruct_path(map_start, map_goal, came_from_clean);


        int path_size_barrier = path_barrier.size();
        tie(ballPosX,ballPosY) = map_goal;

        int bx,by,cx,cy;
        find_barrier = false;
        for(int i=0;i< path_size_barrier;++i) {
            tie(bx,by) = path_barrier.at(i);
            tie(cx,cy) = path_clean.at(i);
            std::cout<<"Bx: "<<bx<<" , By: "<<by<<" , Cx: "<<cx<<" , Cy: "<<cy<<std::endl;
            if((bx!=cx) ||(by!=cy)){
                find_barrier = true;
                break;
            }
        }

        if(find_barrier)
        {
            std::cout <<"There exists barrier T T "<<std::endl;

            if(path_size_barrier > pathTarget)
    			tie(targetPosX,targetPosY) = path_barrier.at(pathTarget);
    		else
    			tie(targetPosX,targetPosY) = map_goal;


        }
        else//this means there is no barrier
        {
            tie(targetPosX,targetPosY) = map_goal;
            find_barrier = false;
            std::cout <<"There is no barrier between ball and robot!"<<std::endl;
        }



		std::cout<<"Astar Target Position x: "<< targetPosX<<" , y: "<<targetPosY<<std::endl<<std::endl;

	}
    else
        std::cout<<"No ball has been detected in map scanner"<<std::endl;

    //check Path

    //SquareGrid::Location checkPath;
    //checkPath = SquareGrid::Location {x,y};



    map_display(path_barrier);
	return find_ball;
}


int pastXvel, pastYvel, pastZvel,pastDuct;

void callback_map(const sensor_msgs::ImageConstPtr& msg){
    dataInit();
	int ballPosX,ballPosY;
	int targetPosX,targetPosY;
	bool findBall,findBarrier;

	if(flag_auto)
	{
		cv_bridge::CvImageConstPtr cv_ptr;
		try
		{
			cv_ptr = cv_bridge::toCvShare(msg);
		}
		catch (cv_bridge::Exception& e)
		{
			ROS_ERROR("cv_bridge exception: %s", e.what());
			return;
		}

		cv::Mat robotMap = cv_ptr->image.clone();

		findBall = scanMap(robotMap, ballPosX, ballPosY, targetPosX,targetPosY, findBarrier);

		if (findBall && (searchStatus ==0)) // find ball and track that
		{
            track_ball(ballPosX,ballPosY, targetPosX,targetPosY, findBarrier);
            //std::cout << ballPosY <<" "<< ballPosX <<std::endl;
            //std::cout <<"MoveX: " <<data[0] <<" ,MoveY: " <<data[1]<<" ,Rotation: "<< data[8]<<" ,Duct: "<< data[14]<<std::endl<<std::endl;


            searchStatus = 0;
        }
		else
		{
            std::cout<<"No ball has been found"<<std::endl;
			search_ball(findBall);
			std::cout<<"Lost ball"<<std::endl;
		}


		/* Written by Seong Yeon */
		// 8UC1

		/* Written by Seong Yeon */

        if(eatCount> eatThreshold)
            data[14] = 0;
        else
            data[14] = 1;

        pastXvel = data[0]; //x
        pastYvel = data[1]; //y
        pastZvel = data[8]; // z
        pastDuct = data[14]; //duct


		if(flag_comm)
			dataSend();

		if(flag_imshow){
			cv::imshow("motion", robotMap);
			cv::waitKey(30);
		}
	}
}

int findCount = 0;

void search_ball(bool fb)
{

    eatCount++;
    switch(searchStatus)
    {
        case 0:
            searchCount++;
            searchStatus = 0;
            findCount = 0;
            data[0] = pastXvel;
            data[1] = pastYvel;
            data[8] = pastZvel;
            data[14] = pastDuct;

            if(searchCount > 2*searchCamSwingThreshold)
            {
                searchStatus = 1;
                searchCount = 0;
            }
            //searchStatus =1;
            findCount = 0;
            break;
        case 1: //camera left swing
            data[20] = 1;
            findCount = 0;
            searchCount++;
            if(searchCount > searchCamSwingThreshold)
            {
                searchStatus = 2;
                searchCount = 0;
            }
            break;
        case 2: //observe left side
            data[20] = 1;
            if(fb)//ball is found
            {
                findCount++;
                if(findCount> searchFindCountConstant)
                {
                    searchStatus = 8;
                    searchCount = 0;
                    findCount = 0;
                }
            }
            searchCount++;
            if(searchCount > searchWaitThreshold)
            {
                searchStatus = 3;
                searchCount = 0;
            }
            break;

        case 3: //camera right swing
            data[21] = 1;
            searchCount++;
            findCount = 0;
            if(searchCount > 2*searchCamSwingThreshold)
            {
                searchStatus = 4;
                searchCount = 0;
            }
            break;
        case 4: //observe right send_signal_node
            data[21] = 1;
            if(fb)//ball is found
            {
                findCount++;
                if(findCount> searchFindCountConstant)
                {
                    searchStatus = 9;
                    searchCount = 0;
                    findCount = 0;
                }
            }
            searchCount++;
            if(searchCount > searchWaitThreshold)
            {
                searchStatus = 5;
                searchCount = 0;
            }
            break;

        case 5: //retrieve camera

            searchCount++;
            if(searchCount > searchCamSwingThreshold)
            {
                searchStatus = 6;
                searchCount = 0;
            }
            break;
        case 6: // original position

            if(fb)
            {
                findCount++;
                if(findCount> searchFindCountConstant)
                {
                    searchStatus = 0;
                    searchCount = 0;
                    findCount = 0;
                }
            }

            searchCount++;
            if(searchCount > searchWaitThreshold)
            {
                searchStatus = 7;
                searchCount = 0;
            }
            break;

        case 7: //Rotate body and then reobserve
            data[8] = searchRotateVelocity; //rotate ccw
            searchCount++;

            findCount = 0;
            if(searchCount > searchRotateThreshold)
            {
                searchStatus = 0;
                searchCount = 0;
            }
            break;
        case 8: // found ball in leftside retrieve camera and rotate to left
            data[8] = searchFindRotateVelocity;

            searchCount++;
            if( (searchCount>searchRotateThreshold) )
            {
                searchStatus = 10;
                searchCount = 0;
            }
            break;

        case 9: // found ball in leftside retrieve camera and rotate to left
            data[8] = -searchFindRotateVelocity;

            searchCount++;
            if( (searchCount>searchRotateThreshold) )
            {
                searchStatus = 10;
                searchCount = 0;
            }
            break;

        case 10:
            searchCount++;
            findCount = 0;
            if( searchCount>searchCamSwingThreshold)
            {
                searchStatus = 0;
                searchCount = 0;
            }
            break;
        default :
            break;
    }


	return;
}




void track_ball(int ballPosX, int ballPosY, int targetPosX, int targetPosY,bool findBarrier)
{
    // 0: Above, far
    // 1: Close, eat
    // 2: Under the duct
    // 3: barrier
    int trackState;
    float distHorizontal,distVertical,distAbsolute;
    float distBallHorizontal,distBallVertical,distBallAbsolute;
    float distBallAngle, distAngle;
    float speedRatio;

    distBallHorizontal = ballPosX - originH;
    distBallVertical = originV - ballPosY;
    distBallAbsolute = sqrt(distBallHorizontal*distBallHorizontal + distBallVertical*distBallVertical);

    if(distBallVertical!=0)
        distBallAngle = atan(1.0*distBallHorizontal/distBallVertical)*2/M_PI;

    distHorizontal = targetPosX - originH;
    distVertical = originV - targetPosY;
    distAbsolute = sqrt(distHorizontal*distHorizontal + distVertical*distVertical);

    ROS_INFO("Target PosX: %d, TargetPosY: %d, distVertical: %f, distHorizontal: %f", targetPosX, targetPosY, distVertical, distHorizontal);

    if(distVertical!=0){
        distAngle = 1.0*atan(1.0* distHorizontal/distVertical)*2/M_PI; //90deg -> pi/2
        if(distAngle > 1)
            distAngle =1;
        else if(distAngle <-1)
            distAngle = -1;
    }

    else{
        if(distHorizontal>0)
            distAngle = 1;
        else if(distHorizontal <0)
            distAngle = -1;
        else
            distAngle = 0;
    }


    if(distVertical<0)
        trackState=2; // ball is under the duct
    else{
        if(distBallAbsolute >fullSpeedDist)
            trackState = 0;
        else
            trackState = 1;
    }

    ROS_INFO("distAngle %f , trackState: %d", distAngle,trackState);
    switch(trackState){
        case 0: // Above, far, full speed operation
            if(distVertical != 0)
    		      data[8] = -rotationHSConstant*distAngle; //rotate

            if(abs(data[8]>1))
                data[8] = 1.0* data[8]/abs(data[8]);

    		if(abs(distHorizontal) >= abs(distVertical)){
    			if(distHorizontal>0){
    				data[0] = 1;
                    data[1] = 1.0*distVertical/distHorizontal;
    			}
    			else{
    				data[0] = -1;
                    if(distHorizontal!=0)
                        data[1] = 1.0*distVertical/(-distHorizontal);
    			}
    		}

    		else{
    				data[0] = 1.0*distHorizontal/distVertical;
    				data[1] = 1;
    		}

            eatCount++;
            break;

        case 1: // Close, Eat
            if(distVertical!=0){
                data[8] = -rotationLSConstant*distAngle;
                data[4] = ductDirectionConstant*distAngle;
            }

            if(abs(data[8]>1))
                data[8] = 1.0* data[8]/abs(data[8]);

            speedRatio = sin(M_PI/2*1.0*distAbsolute/fullSpeedDist)*(1-movementThreshold);
            // if(speedRatio < movementThreshold)
    		// speedRatio = movementThreshold;

            if(distAbsolute!=0){
    		      data[0] = 1.0*distHorizontal/distAbsolute*(0.0+speedRatio+movementThreshold);
    		      data[1] = 1.0*distVertical/distAbsolute*(0.0+speedRatio+movementThreshold);
            }

    		if (distAbsolute <= ductOnDist) //eat -> Turn On duct
    		{
    			//data[14] = 1;
    			eatCount = 0;
    		}
            else

                eatCount++;

            break;
        case 2: // Under the duct

            data[1] = -reverseYVelocity;
            if(distHorizontal>0){
                data[0] = -reverseXVelocity;
                data[4] = -reverseZVelocity;
            }
            else if(distHorizontal<0){
                data[0] = +reverseXVelocity;
                data[4] = +reverseZVelocity;
            }

            eatCount = 0;
            break;

        default:
            break;
    }


    ROS_INFO("Track State %d , data[0]: %f , data[1]: %f , data[4]: %f , data[8]: %f", trackState, data[0],data[1],data[4],data[8]);
    return;
}

int main(int argc, char** argv)
{
	if(argc < 2)
	{
		std::cout << "usage: rosrun motion_planner motion_planner_node flag_imshow" << std::endl;
		return -1;
	}

	if (!strcmp(argv[1], "false"))
    {
        flag_imshow = false;
    }

	std::string path = ros::package::getPath("motion_planner");
	cv::FileStorage params(path+"/config/planner.yaml", cv::FileStorage::READ);


    originH = params["originH"];
	originV = params["originV"];
	fullSpeedDist = params["fullSpeedDist"];
	ductOnDist = params["ductOnDist"];
	movementThreshold = params["movementThreshold"];
    eatThreshold = params["eatThreshold"];
    rotationHSConstant = params["rotationHSConstant"];
    rotationLSConstant = params["rotationLSConstant"];
    reverseXVelocity = params["reverseXVelocity"];
    reverseYVelocity = params["reverseYVelocity"];
    reverseZVelocity = params["reverseZVelocity"];
    ductDirectionConstant = params["ductDirectionConstant"];
    heuristicGainAbs = params["heuristicGainAbs"];
    heuristicGainDist = params["heuristicGainDist"];




    pathTarget = params["pathTarget"];
    aStarForestsCost = params["aStarForestsCost"];
    aStarWallCost = params["aStarWallCost"];

    searchCamSwingThreshold = params["searchCamSwingThreshold"];
    searchWaitThreshold = params["searchWaitThreshold"];
    searchRotateThreshold = params["searchRotateThreshold"];
    searchFindRotateVelocity = params["searchFindRotateVelocity"];
    searchRotateVelocity = params["searchRotateVelocity"];
    searchFindCountConstant = params["searchFindCountConstant"];

    /*
    movementThreshold: 0.1
    eatThreshold: 2
    rotationHSConstant: 3.0
    rotationLSConstant: 1.0

    # Astar Path Finder Parameters
    pathTarget: 5
    aStarForestsCost: 5

    #ball Search parameters
    searchCamSwingThreshold: 20
    searchWaitThresold: 20
    searchRotateThreshold: 50
    searchFindRotateVelocity: 0.3
    searchRotateVelocity: 0.5
    # 20fps

    */

	ros::init(argc, argv, "Motion_Planner");
	ros::start();

	ros::NodeHandle nh;
	msg_pub = nh.advertise<std_msgs::Float32MultiArray>("/motion_planner/ctrl", 1);
	msg_ctrl_.reset(new std_msgs::Float32MultiArray);

    point_pub = nh.advertise<tt_core_msgs::Vector3DArray>("/motion_planner/path_points", 1);
    msg_map_points_.reset(new tt_core_msgs::Vector3DArray);

	ros::Subscriber sub_xbox = nh.subscribe("/xbox_ctrl", 1, &callback_xbox);
	ros::Subscriber sub_map = nh.subscribe("/map_gen/map", 1, &callback_map);
	dataInit();

	ros::spin();
	ros::shutdown();

	return 0;
}
