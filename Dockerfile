FROM jeguzzi/ros:armhf-kinetic-ros-dev
MAINTAINER Jerome Guzzi "jerome@idsia.ch"

RUN apt-get update && apt-get install -y \
    libudev-dev \
    libxml2-dev \
    ros-kinetic-tf \
    ros-kinetic-xacro \
    ros-kinetic-robot-state-publisher \
    && rm -rf /var/lib/apt/lists/*


RUN git clone --recursive https://github.com/jeguzzi/ros-aseba.git src/ros-aseba
RUN catkin config --blacklist thymio_navigation ethzasl_aseba
RUN catkin build

RUN apt-get update && apt-get install -y \
    ros-kinetic-image-proc \
    ros-kinetic-usb-cam \
    ros-kinetic-image-transport-plugins \
    python-pip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/hardkernel/wiringPi.git /tmp/wiringPi
RUN cd /tmp/wiringPi && ./build

RUN pip install ipython==5.5 netifaces wiringpi watchdog jupyter

RUN git clone https://github.com/jeguzzi/thymioid.git src/thymioid
RUN catkin build
