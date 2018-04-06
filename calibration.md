# Motor calibration

The Thymio robot has no encoders and relies soleny on power consumption to estimate the speed of the wheels.
There are two procedures to calibrate this estimation; perform them in this order:

1) [Official Motor calibration instructions](https://www.thymio.org/en:thymiomotorcalibration)

2) the ROS (automatic) calibration described below.

## ROS calibration

1. Print a [tick black line](https://raw.githubusercontent.com/jeguzzi/mighty-thymio/master/calibration/cal.pdf) on a A4 sheet.

2. Launch the calibration service
```bash
docker-compose -f commands/docker-compose.yaml up calibrate
```
and follow the instructions displayed on the console.

3. Relaunch the robot service
```bash
docker-compose restart robot
```
