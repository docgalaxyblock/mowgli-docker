FROM ubuntu:20.04 as base

# Set timezone

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add ROS repository
RUN apt-get update && apt-get install -y curl git gnupg iproute2 sudo apt-utils sed
RUN echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros-latest.list
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# Install ROS Noetic
RUN apt update && apt install -y ros-noetic-ros-base

# Add ubuntu users and make him sudoer
RUN adduser ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Add ubuntu user to required groups
RUN usermod -aG dialout ubuntu

# Install required ROS packages
RUN apt-get -y install g++ cpp cmake ros-noetic-tf2-eigen ros-noetic-teleop-twist-keyboard ros-noetic-robot-state-publisher ros-noetic-joint-state-publisher ros-noetic-map-server ros-noetic-gps-common picocom   ros-noetic-tf2-geometry-msgs ros-noetic-robot-localization libpigpiod-if-dev wavemon ros-noetic-rosserial-arduino python3-paho-mqtt openocd python3-rosdep ros-noetic-rtcm-msgs libxml2-utils python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
RUN echo CATKIN_SHELL=bash >> /opt/ros/noetic/setup.bash
RUN echo 'source /opt/ros/noetic/setup.sh' >> /opt/ros/noetic/setup.bash
USER ubuntu

# Useful debugging aliases
RUN echo "source /opt/ros/noetic/setup.bash" >> /home/ubuntu/.bashrc
RUN echo "source /home/ubuntu/open_mower_ros/devel/setup.bash" >> /home/ubuntu/.bashrc
RUN echo 'alias depit="rosdep install --from-paths src --ignore-src -r -y"' >> /home/ubuntu/.bashrc
RUN echo 'alias debug="picocom -b 115200 /dev/debug"' >> /home/ubuntu/.bashrc

ENV HOME=/home/ubuntu 

FROM base as deps

RUN mkdir -p /home/ubuntu/rosserial/src && cd /home/ubuntu/rosserial/src && git clone https://github.com/tongtybj/rosserial && cd rosserial && git checkout rosservice_server
USER root
RUN bash -c 'source /opt/ros/noetic/setup.bash && cd /home/ubuntu/rosserial && catkin_make -DCMAKE_INSTALL_PREFIX=/opt/ros/noetic install --only-pkg-with-deps rosserial_server'
USER ubuntu
RUN cd /home/ubuntu && git clone https://github.com/ClemensElflein/open_mower_ros
#Patching OM while waiting for PR https://github.com/ClemensElflein/open_mower_ros/pull/23 to be merged
ADD patch.sh /home/ubuntu/patch.sh
RUN /home/ubuntu/patch.sh

# Checkout mowgli & fix repository commits
RUN bash -c 'cd /home/ubuntu/open_mower_ros/ && git submodule update --init --recursive'

# Install ROS dependencies
USER root
RUN rosdep init

USER ubuntu

RUN bash -c 'source /opt/ros/noetic/setup.bash && cd /home/ubuntu/open_mower_ros/ && rosdep update && echo "#!/bin/bash" > /home/ubuntu/apt-install.sh && rosdep install --from-paths src --ignore-src -r --simulate | sed --expression "1d" --expression "s/sudo -H apt-get install/apt-get install --no-install-recommends --yes/g" | sort >> /home/ubuntu/apt-install.sh'

USER root

RUN chmod +x /home/ubuntu/apt-install.sh && /home/ubuntu/apt-install.sh
RUN ln -s /usr/bin/python3 /usr/bin/python

FROM deps as build

USER ubuntu

RUN bash -c 'source /opt/ros/noetic/setup.bash && cd /home/ubuntu/open_mower_ros && catkin_make'
# Added mowgli configuration & scripts
ADD bridge.conf /home/ubuntu/open_mower_ros/src/mowgli/scripts/bridge.conf
ADD scripts /home/ubuntu/scripts
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD [ "/home/ubuntu/scripts/start_mowgli.sh" ]
