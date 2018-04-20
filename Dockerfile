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
    swig3.0 \
    && rm -rf /var/lib/apt/lists/*

# COPY install/wiringpi2-1.1.1-py2.7-linux-armv7l.egg /tmp/wiringpi2-1.1.1-py2.7-linux-armv7l.egg
#
# RUN easy_install /tmp/wiringpi2-1.1.1-py2.7-linux-armv7l.egg

RUN git clone https://github.com/hardkernel/WiringPi2-Python.git /tmp/WiringPi2-Python && \
    cd /tmp/WiringPi2-Python && \
    git submodule init && \
    git submodule update && \
    swig3.0 -python -threads wiringpi.i && \
    python2 setup.py build install && \
    cd / && rm -r /tmp/WiringPi2-Python

RUN apt-get update && apt-get install -y \
    gfortran libopenblas-dev liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install ipython==5.5 watchdog jupyter numpy matplotlib docker scipy

RUN apt-get update && apt-get install -y \
    ros-kinetic-ar-track-alvar \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    ros-kinetic-joy-teleop \
    ros-kinetic-joy \
    ros-kinetic-dynamic-reconfigure \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-tools \
    gstreamer1.0-alsa \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-good \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/ros-drivers/audio_common.git src/audio_common
RUN catkin config --blacklist audio_play sound_play thymio_navigation ethzasl_aseba
RUN catkin build


RUN git clone https://github.com/jeguzzi/thymioid.git src/thymioid
RUN catkin build

COPY ./version.txt /version.txt

RUN git -C src/ros-aseba pull
RUN git -C src/thymioid pull

RUN catkin build
