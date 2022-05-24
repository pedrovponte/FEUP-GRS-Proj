#!/usr/bin/env bash


# Clean docker and start eth device
sudo docker network rm client_net server_net public_net dmz_net
sudo ip l set ens19 up
sudo ip l set ens20 up
sudo ip l set ens21 up

# Create network for clients
sudo docker network create -d macvlan \
--subnet=10.0.1.0/24 --gateway=10.0.1.1 -o \
parent=ens19 client_net

# Create network for servers
sudo docker network create -d macvlan \
--subnet=10.0.2.0/24 --gateway=10.0.2.1 -o \
parent=ens20 server_net

sudo docker network create public_net \
--subnet=172.31.255.0/24 --gateway=172.31.255.254

sudo docker network create -d macvlan \
--subnet=172.16.123.128/28 --gateway=172.16.123.140 -o \
parent=ens21 dmz_net

sudo ip route add 172.16.123.128/28 via 172.31.255.253
sudo iptables -t nat -A POSTROUTING -s 172.16.123.128/28 -o \
eth4 -j MASQUERADE