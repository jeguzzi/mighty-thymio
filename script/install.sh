#!/usr/bin/env bash

# https://docs.docker.com/install/linux/docker-ce/ubuntu/

export LC_ALL=C

apt-get update
apt-get install  -y \
   apt-transport-https \
   ca-certificates \
   curl \
   git-core \
   software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=armhf] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt update
apt install docker-ce -y
apt remove apparmor

# https://docs.docker.com/compose/install/#install-compose

apt install python3-pip
pip3 install --upgrade pip
pip3 install docker-compose

#https://wiki.odroid.com/accessory/connectivity/wifi/wlan_ap

apt install --reinstall dnsmasq
apt install hostapd iptables wpasupplicant

cp /usr/sbin/hostapd /usr/sbin/hostapd.back
cp ./hostapd /usr/sbin/hostapd

ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules

mkdir -p /root/docker
git clone https://github.com/jeguzzi/mighty-thymio.git /root/docker/mighty-thymio

cd /root/docker/mighty-thymio/script

echo "Installation DONE, now run the setup script"

read -e -p "Enter the robot name: " -i "thymio" name
read -e -p "Enter the wifi password: " password
read -e -p "Enter the wifi channel: " -i "6" channel

aps=""; while true
do
  read -e -p "Enter the access point ssid: " -i "" ssid
  if [ "$ssid" == "" ]
  then
    break
  fi
  read -e -p "Enter the access point password: " ap_password
  if [ "$aps" != "" ]
  then
    aps+=" "
  fi
  aps+=$ssid" "$ap_password
done; echo $aps


python3 setup.py --name $name --password $password --channel $channel --access_points $aps
