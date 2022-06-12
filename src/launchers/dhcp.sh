#!/usr/bin/env bash 

sudo docker run -d --name dhcp --rm --net \
client_net --ip 10.0.1.2 --cap-add=NET_ADMIN -v \
$HOME/grs/dhcp/dhcp.conf:/etc/dhcp/dhcpd.conf dhcp

