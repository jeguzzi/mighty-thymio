#!/usr/bin/env bash

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

chmod +x /etc/rc.local

printf "\n****** Configuration done ******\n"
