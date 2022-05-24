#!/usr/bin/env bash

./grs/squid/buildSquid.sh

sudo docker run -d --net client_net --ip \
10.0.1.253 --cap-add=NET_ADMIN --name squid \
squid

sudo docker exec squid /bin/bash -c \
'ip r del default via 10.0.1.1'

sudo docker exec squid /bin/bash -c \
'ip r a default via 10.0.1.254'