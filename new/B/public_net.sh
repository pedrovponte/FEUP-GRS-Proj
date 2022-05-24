#!/usr/bin/env bash

LAUNCHERS=/home/theuser/grs/launchers

# Setup pulic_net
sudo ip l set ens21 up

sudo docker network create public_net \
--subnet=172.31.255.0/24 --gateway=172.31.255.254

$LAUNCHERS/externalhost.sh 1
