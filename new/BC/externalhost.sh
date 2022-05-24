#!/usr/bin/env bash

sudo docker run -d --net public_net --ip 172.31.255.100 \
--cap-add=NET_ADMIN --name external_host netubuntu

sudo docker exec external_host /bin/bash -c 'ip r a 172.16.123.128/28 via 172.31.255.253'