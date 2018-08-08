#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/naverlabs/ros/TT_final/src/tt3_motion/tt_rl_motion_planner"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/naverlabs/ros/TT_final/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/naverlabs/ros/TT_final/install/lib/python3/dist-packages:/home/naverlabs/ros/TT_final/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/naverlabs/ros/TT_final/build" \
    "/home/naverlabs/anaconda3/bin/python" \
    "/home/naverlabs/ros/TT_final/src/tt3_motion/tt_rl_motion_planner/setup.py" \
    build --build-base "/home/naverlabs/ros/TT_final/build/tt3_motion/tt_rl_motion_planner" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/naverlabs/ros/TT_final/install" --install-scripts="/home/naverlabs/ros/TT_final/install/bin"
