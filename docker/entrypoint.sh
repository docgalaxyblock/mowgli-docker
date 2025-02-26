#!/bin/bash
sudo chown -Rf ubuntu:users /home/ubuntu/.ros
source /opt/ros/noetic/setup.bash
source /home/ubuntu/open_mower_ros/devel/setup.bash
cd /home/ubuntu/open_mower_ros
# ROS_IP is optional, we will use the provided env var instead of setting it
#export ROS_IP=$(/sbin/ip route|awk '/default/ { print $9 }')
if [ -z "${ROS_MASTER_URI}" ];
then
    export ROS_MASTER_URI=http://localhost:11311
fi
export CATKIN_SHELL=bash

exec $*
