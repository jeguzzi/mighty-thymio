#!/usr/bin/env bash

# Delete garbage folder
rm -rf /var/lib/docker/containers_

# Check that docker is up

if ( ! systemctl -q is-active docker)
  then
  logger -s "Restart the docker service"
  systemctl stop docker && systemctl start docker
fi


if ( ! systemctl -q is-active docker)
  then
  logger -s "Remove /var/lib/docker/runtimes and restart the docker service"
  systemctl stop docker
  rm -rf /var/lib/docker/runtimes
  systemctl start docker
fi

if ( ! systemctl -q is-active docker)
  then
  logger -s "Remove /var/lib/docker/runtimes, /var/lib/docker/containers and restart the docker service"
  systemctl stop docker
  rm -rf /var/lib/docker/runtimes
  rm -rf /var/lib/docker/containers
  rm -rf /var/lib/docker/containerd
  mv /var/lib/docker/containers /var/lib/docker/containers_
  systemctl start docker
fi

if ( ! systemctl -q is-active docker)
  then
  logger -s "Could not launch docker"
  return 1
fi

# Check that the (essential) services are up

cd /root/docker/mighty-thymio
services=$(docker-compose ps | wc -l)
if [ $services == "2" ]
  then
  logger -s "Recreate services"
  source do_update.sh
fi
