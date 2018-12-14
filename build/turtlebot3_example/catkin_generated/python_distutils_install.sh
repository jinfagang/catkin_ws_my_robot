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

echo_and_run cd "/media/jintain/wd/ros/wps/catkin_ws_my_robot/src/turtlebot3_example"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/media/jintain/wd/ros/wps/catkin_ws_my_robot/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/media/jintain/wd/ros/wps/catkin_ws_my_robot/install/lib/python2.7/dist-packages:/media/jintain/wd/ros/wps/catkin_ws_my_robot/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/media/jintain/wd/ros/wps/catkin_ws_my_robot/build" \
    "/usr/bin/python2" \
    "/media/jintain/wd/ros/wps/catkin_ws_my_robot/src/turtlebot3_example/setup.py" \
    build --build-base "/media/jintain/wd/ros/wps/catkin_ws_my_robot/build/turtlebot3_example" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/media/jintain/wd/ros/wps/catkin_ws_my_robot/install" --install-scripts="/media/jintain/wd/ros/wps/catkin_ws_my_robot/install/bin"
