#!/bin/sh

docker rmi flash-cards-flutter -f
docker rmi flash-cards-java -f

# start the container stack
# (assumes the caller has permission to do this)
docker-compose up
