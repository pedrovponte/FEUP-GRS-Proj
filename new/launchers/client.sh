#!/usr/bin/env bash

# Launch a client
sudo docker run -d --net client_net \
--cap-add=NET_ADMIN --name client$1 \
netubuntu

# Routing for clients
sudo docker exec client$1 /bin/bash -c \
'ip r del default via 10.0.1.1'

sudo docker exec client$1 /bin/bash -c \
'ip r a default via 10.0.1.254'