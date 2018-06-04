#!/usr/bin/env bash

# Check that docker is up

if [[ ! $(systemctl is-active --quiet docker) ]]; then
  systemctl stop docker
  logger -s "Restart the docker service"
  systemctl start docker
fi

if [[ ! $(systemctl is-active --quiet docker) ]]; then
  systemctl stop docker
  rm -r /var/lib/docker/runtimes
  logger -s "Remove /var/lib/docker/runtimes and restart the docker service"
  systemctl start docker
fi

if [[ ! $(systemctl is-active --quiet docker) ]]; then
  systemctl stop docker
  rm -r /var/lib/docker/runtimes
  rm -r /var/lib/docker/containers
  logger -s "Remove /var/lib/docker/runtimes, /var/lib/docker/containers and restart the docker service"
  systemctl start docker
fi

if [[ ! $(systemctl is-active --quiet docker) ]]; then
  logger -s "Could not launch docker"
  return 1
fi

# Check that the (essential) services are up

cd /root/docker/mighty-thymio
services=$(docker-compose ps | wc -l)
if [[ "$services" -eq "2" ]]; then
  logger -s "Recreate services"
  source do_update.sh
fi
