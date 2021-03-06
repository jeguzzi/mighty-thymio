# Installation

<img src="https://raw.githubusercontent.com/jeguzzi/mighty-thymio/master/images/mighty_thymio_2.JPG" width="400"/>


The easiest way to get started with the Mighty Thymio is to use docker.

1. Start with a fresh minimal image with Ubuntu 16.04
  - Download the [lastest image](https://dn.odroid.com/S805/Ubuntu/ubuntu-16.04.3-minimal-odroid-c1-20170914.img.xz) from the [official Odroid repository](http://odroid.com/dokuwiki/doku.php?id=en:c1_release_linux_ubuntu).
  - [Flash the image](http://odroid.com/dokuwiki/doku.php?id=en:odroid_flashing_tools) to the eMMC card.
  - Switch on the Odroid, log in and run the [odroid-utility](https://github.com/mdrjr/odroid-utility) to expand the filesystem.
  - Bring the OS up-to-date
      ```bash
      apt update
      apt install linux-image-c1
      apt upgrade
      ```
  - Install git and curl
      ```bash
      apt install git-core curl
      ```
  - Reboot

2. Clone this repository
    ```bash
    mkdir -p /root/docker
    cd /root/docker
    git clone https://github.com/jeguzzi/mighty-thymio.git
    ```

3. Run the install script
    ```bash
    cd /root/docker/mighty-thymio/install
    source install_local.sh
    ```

4. Bring up the docker containers
    ```bash
    cd /root/docker/mighty-thymio
    docker-compose up -d robot ui ups camera
    ```

## Shutdown and restart

The software will automatically restart on boot. To properly shutdown the robot, either run
```bash
sudo shutdown now
```
or press the up arrow (the button on top of the robot's body that points towards the back) for 6 seconds.

## Demo

We also include the Docker Compose file to launch the demo

<b>
Learning an Image-based Obstacle Detector With Automatic Acquisition of Training Data, <i>Stefano Toniolo, Jérôme Guzzi, Luca Maria Gambardella, Alessandro Giusti</i>, AAAI-18.
</b>

```bash
cd /root/docker/mighty-thymio
docker-compose -f demo/ml/docker-compose.yml up
```

## Software update

Connect the robot to the internet and either run
```bash
cd /root/docker/mighty-thymio
source do_update.sh
```
or hold down the right arrow (the button on top of the robot's body that points towards the right wheel) for 6 seconds.


## Troubleshooting

### After starting, the Thymio is not blinking

  1. check that all cables are connected
  2. login into the odroid
  3. check that docker is up
      ```bash
      systemctl status docker
      ```
      If not, reset docker:
      ```bash
      systemctl stop docker
      rm -r /var/lib/docker/runtimes
      rm -r /var/lib/docker/containers/*
      systemctl start docker
      source /root/docker/mighty-thymio/do_update.sh
      ```
  4. check that the services are up
      ```bash
      cd docker/mighty-thymio
      docker-compose ps
      ```
      If not, recreate them:
      ```bash
      source do_update.sh
      ```
