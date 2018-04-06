#!/usr/bin/env bash

cd /root/docker/mighty-thymio

git pull
docker-compose down
docker-compose pull
docker system prune -f
source services.env
docker-compose up -d $SERVICES
