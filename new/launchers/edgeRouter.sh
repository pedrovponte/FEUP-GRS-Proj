#!/usr/bin/env bash

sudo docker run -d --rm --net dmz_net --ip 172.16.123.139 \
--cap-add=NET_ADMIN --name edgerouter netubuntu

sudo docker network connect public_net edgerouter \
--ip 172.31.255.253
sudo docker exec edgerouter /bin/bash -c \
'ip r d default via 172.16.123.140'
sudo docker exec edgerouter /bin/bash -c \
'ip r a default via 172.31.255.254'
sudo docker exec edgerouter /bin/bash -c \
'ip r a 10.0.0.0/8 via 172.16.123.142'


sudo docker exec edgerouter /bin/bash -c \
'iptables -F -t nat
iptables -F -t filter
iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -o eth1 -j MASQUERADE
iptables -P FORWARD DROP
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state NEW -i eth0 -j ACCEPT
iptables -A FORWARD -m state --state NEW -i eth1 -d 172.16.123.128/28 -j ACCEPT'