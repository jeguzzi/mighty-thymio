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
and follow the instructions displayed on the console:

  - After the first beep, place the robot with its _left_ wheel at the begin of the black line, oriented along the black line. Then press the center button. After 3 seconds the robot will begin rotating anti-clockwise while keeping the left wheel still. Every two full rotations, the robot will increase the right wheel speed.

- After the first beep, place the robot with its _right_ wheel at the begin of the black line, oriented along the black line. Then press the center button. After 3 seconds the robot will begin rotating clockwise while keeping the right wheel still.  Every two full rotations, the robot will increase the left wheel speed.

- Wait until the robot stop.

3. Edit `ros.env` with
```
CALIBRATED=true
```

4. Relaunch the robot service
```bash
docker-compose restart robot
```
