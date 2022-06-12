#!/usr/bin/env bash 
 
ip=$((100+$1))
# Launch a server
sudo docker run -d --net server_net --ip \
10.0.2.$ip --cap-add=NET_ADMIN --name server$1 \
server

# Routing for server
sudo docker exec server$1 /bin/bash -c \
'ip r del default via 10.0.2.1'

sudo docker exec server$1 /bin/bash -c \
'ip r a default via 10.0.2.254'
