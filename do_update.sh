#!/usr/bin/env bash

cd /root/docker/mighty-thymio

git pull
docker-compose down
docker system prune -f
docker-compose pull
source services.env
docker-compose up -d $SERVICES
