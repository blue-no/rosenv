# source: https://github.com/Tiryoh/docker-ros-desktop-vnc.git
# changes:
# (line 9) focal-lxde -> focal-lxqt
#     LXQT is the new version of LXDE
# (line 17-19, 24) ubuntu -> user
# (line 26-) commands added to set catkin workspace
#     reference: https://lilaboc.work/archives/17311113.html

FROM dorowu/ubuntu-desktop-lxde-vnc:focal-lxqt

ENV DEBIAN_FRONTEND noninteractive
RUN echo "Set disable_coredump false" >> /etc/sudo.conf
RUN apt-get update -q && \
    apt-get upgrade -yq && \
    apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata gosu && \
    rm -rf /var/lib/apt/lists/*
RUN useradd --create-home --home-dir /home/user --shell /bin/bash --user-group --groups adm,sudo user && \
    echo user:ubuntu | chpasswd && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
COPY ./ros-noetic-desktop.sh /ros-noetic-desktop.sh
RUN mkdir -p /tmp/ros_setup_scripts_ubuntu && mv /ros-noetic-desktop.sh /tmp/ros_setup_scripts_ubuntu/ && \
    gosu user /tmp/ros_setup_scripts_ubuntu/ros-noetic-desktop.sh && \
    rm -rf /var/lib/apt/lists/*
ENV USER user

RUN mkdir -p /home/user/catkin_ws/src && \
	cd /home/user/catkin_ws && \
	/bin/bash -c "source /opt/ros/noetic/setup.bash; catkin build" && \
	echo "source /opt/ros/noetic/setup.bash" >> /home/user/.bashrc && \
	echo "source /home/user/catkin_ws/devel/setup.bash" >> /home/user/.bashrc && \
	echo "export ROS_PACKAGE_PATH=/home/user/catkin_ws" >> /home/user/.bashrc && \
	echo "export ROS_WORKSPACE=/home/user/catkin_ws" >> /home/user/.bashrc && \
    /bin/bash -c "source /home/user/.bashrc"
WORKDIR /home/user/catkin_ws