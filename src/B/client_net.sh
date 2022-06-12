#!/usr/bin/env bash

LAUNCHERS=/home/theuser/grs/launchers

# Create network for clients
sudo ip l set ens19 up

sudo docker network create -d macvlan \
--subnet=10.0.1.0/24 --gateway=10.0.1.1 -o \
parent=ens19 client_net

$LAUNCHERS/proxy.sh
$LAUNCHERS/dnsCache.sh
$LAUNCHERS/dhcp.sh
$LAUNCHERS/client.sh 1
$LAUNCHERS/client.sh 2
$LAUNCHERS/client.sh 3


