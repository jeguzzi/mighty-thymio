#!/usr/bin/env bash

while read config;
do
/bin/bash /root/docker/migthy-thymio/do_update.sh
done
