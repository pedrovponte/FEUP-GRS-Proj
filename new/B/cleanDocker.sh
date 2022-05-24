#!/usr/bin/env bash

# Remove all dockers

docker kill $(docker ps -q)
docker rm $(docker ps -a -q)

# Clean docker and start eth device
sudo docker network rm client_net server_net public_net dmz_net
