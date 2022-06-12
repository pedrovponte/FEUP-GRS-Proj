#!/usr/bin/env bash

sudo docker run -d --net public_net --ip 172.31.255.100 \
--cap-add=NET_ADMIN --name external_host netubuntu

sudo docker exec external_host /bin/bash -c 'ip r a 172.16.123.128/28 via 172.31.255.253'
sudo docker exec external_host /bin/bash -c \
'echo "search netlab.fe.up.pt
nameserver 172.16.123.129
nameserver 8.8.8.8
options edns0 trust-ad ndots:0" > /etc/resolv.conf ' 
sudo docker exec external_host /bin/bash -c \
'mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun
/etc/init.d/openvpn restart' 
