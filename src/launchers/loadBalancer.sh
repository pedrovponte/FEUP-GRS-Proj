#!/usr/bin/env bash 

# Launch a server
sudo docker run -d --net dmz_net --ip \
172.16.123.130 --cap-add=NET_ADMIN --name loadBalancer \
loadbalancer

# Routing for server
sudo docker exec loadBalancer /bin/bash -c \
'ip r del default'

sudo docker exec loadBalancer /bin/bash -c \
'ip r a default via 172.16.123.139'

sudo docker exec loadBalancer /bin/bash -c \
'ip r a 10.0.0.0/8 via 172.16.123.142'