#!/usr/bin/env bash

sudo docker run -d --net client_net --ip \
10.0.1.254 --cap-add=NET_ADMIN --name router \
netubuntu

sudo docker network connect server_net \
router --ip 10.0.2.254

sudo docker network connect dmz_net \
router --ip 172.16.123.142

# sudo docker exec router /bin/bash -c \
# 'iptables -t filter -A FORWARD -p tcp -- dport 80 ! -s 10.0.1.253 -j DROP'

sudo docker exec router /bin/bash -c \
'ip r del default via 10.0.1.1'

sudo docker exec router /bin/bash -c \
'ip r a default via 172.16.123.139'
