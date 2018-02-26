#!/usr/bin/env bash

# https://docs.docker.com/install/linux/docker-ce/ubuntu/

export LC_ALL=C

printf "\n****** Installing Docker ****** \n"

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
apt install docker-ce -y || :
yes | apt remove apparmor
yes | apt autoremove

# https://docs.docker.com/compose/install/#install-compose

printf "\n****** Install docker compose ******\n"

apt install python3-pip -y
pip3 install --upgrade pip
pip3 install docker-compose

printf "\n****** Docker installation done ******\n"


#https://wiki.odroid.com/accessory/connectivity/wifi/wlan_ap

printf "\n****** Install hostapd and dnsmasq ****** \n"

apt install --reinstall dnsmasq -y
apt install hostapd iptables wpasupplicant -y

cp /usr/sbin/hostapd /usr/sbin/hostapd.back
cp ./hostapd /usr/sbin/hostapd
chmod +x /usr/sbin/hostapd

ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules

printf "\n****** Create wlan FIFO ****** \n"

mkfifo /root/docker/mighty-thymio/wlan

chmod +x wlan.sh

printf "\n****** Run the config script ******\n"

cd install

source setup.sh
