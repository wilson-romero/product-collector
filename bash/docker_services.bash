#!/bin/bash

CLEAN="clean"
START="start"
STOP="stop"

if [ "$#" -eq 0 ] || [ $1 = "-h" ] || [ $1 = "--help" ]; then
    echo "Usage: ./docker_services.bash [OPTIONS] COMMAND [arg...]"
    echo "       ./docker_services.bash [ -h | --help ]"
    echo ""
    echo "Options:"
    echo "  -h, --help    Prints usage."
    echo ""
    echo "Commands:"
    echo "  $CLEAN      - Stop and Remove docker_services containers."
    echo "  $START        - Build and Run docker_services."
    echo "  $STOP       - Stop docker_services."
    exit
fi

clean() {
  echo "Cleaning..."
  stop
  remove_stopped_containers
  remove_unused_volumes
}

start() {
  echo "Running docker..."
  docker-compose up --build -d
}

stop() {
  NORMALIZATION="$(docker ps --all --quiet --filter=name=normalization_app)"
  REDIS="$(docker ps --all --quiet --filter=name=normalization_redis)"
  MONGO="$(docker ps --all --quiet --filter=name=normalization_mongo)"

  if [ -n "$NORMALIZATION" ]; then
    docker stop $NORMALIZATION
  fi

  if [ -n "$REDIS" ]; then
    docker stop $REDIS
  fi

  if [ -n "$MONGO" ]; then
    docker stop $MONGO
  fi
}

remove_stopped_containers() {
  CONTAINERS="$(docker ps -a -f status=exited -q)"
	if [ ${#CONTAINERS} -gt 0 ]; then
		echo "Removing all stopped containers."
		docker rm $CONTAINERS
	else
		echo "There are no stopped containers to be removed."
	fi
}

remove_unused_volumes() {
  CONTAINERS="$(docker volume ls -qf dangling=true)"
	if [ ${#CONTAINERS} -gt 0 ]; then
		echo "Removing all unused volumes."
		docker volume rm $CONTAINERS
	else
		echo "There are no unused volumes to be removed."
	fi
}

if [ $1 = $CLEAN ]; then
	clean
	exit
fi

if [ $1 = $START ]; then
	start
	exit
fi

if [ $1 = $STOP ]; then
	stop
	exit
fi