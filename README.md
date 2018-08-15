# Caution when catkin_make

you should install the xbox controller driver before catkin_make.

please commend that

sudo apt-get install libudev-dev ncurses-dev


----------------------------------------------------------------------------------------------------
If you downloaded this files and catkin_make, there could be a 'fatal error: core_msgs/ball_position.h: No such file or directory)

If so, just
catkin_make --pkg core_msgs

and then,

catkin_make

again. 


# setting python3 in ros and pytorch
----------------------------------------------------------------------------------------------------
1. commend below line insterminal


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
                    python3 \
                    python3-pip \
                    python3-tk \
                    python3-setuptools \

sudo apt install python3-pip

pip3 install -U numpy \
                    argparse \
                    pyyaml \
                    opencv-python \
                    rospkg \
                    catkin-pkg \
                    scipy \
                    ipython \
                    matplotlib \
                    gym \
                    torchvision \




