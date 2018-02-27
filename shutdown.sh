#!/usr/bin/env bash

while read config;
do
docker stop $(docker ps -aq)
shutdown -h now
done
