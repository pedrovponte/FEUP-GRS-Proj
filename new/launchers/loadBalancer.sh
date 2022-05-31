#!/usr/bin/env bash 

# Launch a server
sudo docker run -d --net server_net --ip \
10.0.2.100 --cap-add=NET_ADMIN --name loadBalancer \
loadbalancer

# Routing for server
sudo docker exec loadBalancer /bin/bash -c \
'ip r del default via 10.0.2.1'

sudo docker exec loadBalancer /bin/bash -c \
'ip r a default via 10.0.2.254'