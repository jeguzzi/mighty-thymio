#!/usr/bin/env bash

git pull
docker-compose down
docker-compose pull robot
docker-compose up -d robot ui ups camera
