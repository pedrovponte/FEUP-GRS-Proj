#!/usr/bin/env bash

DNS=/home/theuser/grs/dockers/dns

docker run -d --name=dnsCache \
--volume $DNS/named.conf:/etc/bind/named.conf \
--volume $DNS/named.conf.options:/etc/bind/named.conf.options \
--volume /var/cache/bind \
--volume /var/lib/bind \
--rm --net client_net --ip 10.0.1.3 \
--cap-add=NET_ADMIN dns

sudo docker exec dnsCache ip r d default

sudo docker exec dnsCache ip r a \
default via 10.0.1.254

