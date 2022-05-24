#!/usr/bin/env bash

./grs/nagios/buildNagios.sh

sudo docker run -d \
    --name nagios -p 0.0.0.0:8080:80 nagios

sudo docker network connect server_net \
    nagios --ip 10.0.2.253

# sudo docker run -d --net server_net --ip \
#     10.0.2.253 --cap-add=NET_ADMIN \
#     --name nagios -p 0.0.0.0:8080:80 jasonrivers/nagios:latest