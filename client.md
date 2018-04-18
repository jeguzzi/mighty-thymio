# Interface with the robot as a ROS client

## Installation

Install the following ROS packages in your catkin workspace

```bash
cd <your catkin workspace>/src
git clone https://github.com/jeguzzi/thymioid.git --branch client
git clone https://github.com/jeguzzi/ros-aseba.git --branch client
catkin build
```

## Launch RViz

```bash
roslaunch thymioid rviz.launch name:=<thymioXX>
```

## (Re-) Configure

Use dynamic reconfigure to change:
  - the camera pitch,
  - the motor dead-band,
  - the camera stream compression.

```bash
rosrun rqt_reconfigure rqt_reconfigure
```

## Teleoperate the robot with a joypad

```bash
roslaunch thymioid joy_teleop.launch name:=<thymioXX>
```

## Launch a Gazebo simulation

The simulated model implements:

- the tiltable web-camera with the same distortion as the real camera,
- the wheels (and their odometry),
- the proximity and ground sensors (which are implemented as distance sensors only),
- the IMU,

and uses the _same_ urdf model as the real robot.

```bash
roslaunch thymioid_description test_gazebo_bringup.launch
```

## Robot parameters

The robot model is defined in two packages:

  -[thymio_description](https://github.com/jeguzzi/ros-aseba/thymio_description)
  -[thymioid_description](https://github.com/jeguzzi/thymioid/thymioid_description)
