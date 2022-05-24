#!/usr/bin/env bash

# Remove all dockers

docker kill $(docker ps -q)
docker rm $(docker ps -a -q)