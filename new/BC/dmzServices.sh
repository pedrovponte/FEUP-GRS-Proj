#!/usr/bin/env bash

# Launch a server
sudo docker run -d --net dmz_net --ip \
172.16.123.130 --cap-add=NET_ADMIN --name www \
server

# Routing for server
sudo docker exec www /bin/bash -c \
'ip r del default'

sudo docker exec www /bin/bash -c \
'ip r a default via 172.16.123.139'
sudo docker exec www /bin/bash -c \
'ip r a 10.0.0.0/8 via 172.16.123.142'


# Launch a server
sudo docker run -d --net dmz_net --ip \
172.16.123.131 --cap-add=NET_ADMIN --name mail \
server

# Routing for server
sudo docker exec mail /bin/bash -c \
'ip r del default'

sudo docker exec mail /bin/bash -c \
'ip r a default via 172.16.123.139'
sudo docker exec mail /bin/bash -c \
'ip r a 10.0.0.0/8 via 172.16.123.142'