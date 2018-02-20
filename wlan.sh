#!/usr/bin/env bash

while read config;
do
ifdown wlan0
ifup wlan0=$config
done
