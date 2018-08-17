
### NUC setting python3 in ros and pytorch(Dont commend on jetson )
----------------------------------------------------------------------------------------------------
commend below lines 

```
sudo apt-get -y update
sudo apt-get -y install --no-install-recommends \
                    libncurses5-dev \
                    libudev-dev \
                    libeigen3-dev \
                    git \
                    tmux \
                    curl \
                    wget \
                    htop \
                    python\
                    python-pip \
                    python-tk \
                    python-setuptools \
                    
pip3 install -U numpy \
                    argparse \
                    pyyaml \
                    opencv-python \
                    rospkg \
                    catkin-pkg \
                    scipy \
                    matplotlib \
                    gym \
                    torch
                    torchvision \
```


### Jetson Pytorch Setup
----------------------------------------------------------------------------------------------------

0. Operate fan
```
sudo /home/nvidia/jetson_clocks.sh
```
1. Insstall pytorch(will take 2hour)
```
 git clone --recursive https://github.com/pytorch/pytorch
 cd pytorch
 python3 setup.py install
```
    never mind denied error, it will work on next step

2. build pytorch

```
python3 setup.py build_deps
sudo python3 setup.py develop
```
3. Verify CUDA and pytorch(from python3 interactive terminal)
```
python3
import torch
print(torch.__version__)
print(torch.cuda.is_available())
```
    result :  True

    Reference: https://gist.github.com/dusty-nv/ef2b372301c00c0a9d3203e42fd83426

4. Install opencv(it will take 1.5hour)
```
git clone https://github.com/jetsonhacks/buildOpenCVTX2
cd buildOpenCVTX2/
 ./buildOpenCV.sh -s
 ```
 5. Verify opencv
```
python3
import cv2
cv2.__version__
```
    result :'3.4.1-dev'
 
 
 6. Install ROS
 
    follow webpage : http://wiki.ros.org/kinetic/Installation/Ubuntu
 ```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 
sudo apt-get update
sudo apt-get install ros-kinetic-desktop
sudo rosdep init
rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
```
 7. Verify ROS
```
roscore
```

### Caution when run python source in ROS
```
when you run python source code, code need that line on top.

run in python3:
  #! /usr/bin/env python3
  
run in python2 or python:
   #! /usr/bin/env python
```

# Caution when catkin_make
----------------------------------------------------------------------------------------------------

you should install the xbox controller driver before catkin_make.

please commend that

sudo apt-get install libudev-dev ncurses-dev

# biuld dependency issue
----------------------------------------------------------------------------------------------------
If you downloaded this files and catkin_make, there could be a 'fatal error: core_msgs/ball_position.h: No such file or directory)

If so, just
catkin_make --pkg core_msgs

and then,

catkin_make

again. 




