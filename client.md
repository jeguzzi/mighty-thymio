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

The robot model (geometrical and physical properties) is defined in two packages

  - [thymio_description](https://github.com/jeguzzi/ros-aseba/tree/master/thymio_description): base with wheels, IMU, proximity, and ground sensors
  - [thymioid_description](https://github.com/jeguzzi/thymioid/tree/master/thymioid_description): chassis, camera, and power-pack

which contains all the robot parameters and the meshes for any robot part as [ COLLADA files](https://en.wikipedia.org/wiki/COLLADA).

The following are the most important parameters for the controlling the (real) robot:

### base:

  - length: 11.0 cm
  - width: 11.18 cm
  - height: 7.7 cm

### wheels

  - radius: 2.2 cm
  - width: 1.5 cm
  - axis (distance between wheels centers): 9.35 cm
  - maximal angular speed: ~7.5 rad/s

### kinematics

  - maximal linear speed: ~ 14 cm/s
  - maximal angular speed: ~ 3 rad/s

### proximity (and ground) sensors

  - maximal range (to detect a white surface): ~ 12 cm
  - field of view: 0.3 rad

### camera

  The camera is mounted on a titable joint (downward pitch is positive) with

  - min pitch: -0.34 rad
  - max pitch: 1.3 rad
