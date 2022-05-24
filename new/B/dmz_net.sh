#!/usr/bin/env bash

LAUNCHERS=/home/theuser/grs/launchers

# Create network for dmz
sudo ip l set ens21 up

sudo docker network create -d macvlan \
--subnet=172.16.123.128/28 --gateway=172.16.123.140 -o \
parent=ens21 dmz_net

sudo ip route add 172.16.123.128/28 via 172.31.255.253
sudo iptables -t nat -A POSTROUTING -s 172.16.123.128/28 -o \
eth4 -j MASQUERADE

$LAUNCHERS/edgeRouter.sh
$LAUNCHERS/www.sh
$LAUNCHERS/mail.sh
$LAUNCHERS/dns.sh
