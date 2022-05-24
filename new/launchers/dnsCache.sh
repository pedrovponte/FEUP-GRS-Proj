#!/usr/bin/env bash

DNS=/home/theuser/grs/dockers/dns

docker run -d --name=dnsCache \
--volume $DNS/named.conf:/etc/bind/named.conf \
--volume $DNS/named.conf.options:/etc/bind/named.conf.options \
--volume /var/cache/bind \
--volume /var/lib/bind \
--rm --net dmz_net --ip 172.16.123.129 \
--cap-add=NET_ADMIN dns

sudo docker exec dns ip r d default

sudo docker exec dns ip r a \
default via 172.16.123.139
sudo docker exec dns ip r a \
10.0.0.0/8 via 172.16.123.142
