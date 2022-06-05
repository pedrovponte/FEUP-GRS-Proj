#!/usr/bin/env bash

LAUNCHERS=/home/theuser/grs/launchers

# Create network for servers
sudo ip l set ens20 up

sudo docker network create -d macvlan \
--subnet=10.0.2.0/24 --gateway=10.0.2.1 -o \
parent=ens20 server_net

$LAUNCHERS/server.sh 1
$LAUNCHERS/server.sh 2

