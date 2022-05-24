#!/usr/bin/env bash 

for ((i=$1; i<=$2; i++))
do 
    ip=$((100+$i))
    # Launch a server
    sudo docker run -d --net server_net --ip \
    10.0.2.$ip --cap-add=NET_ADMIN --name server$i \
    server

    # Routing for server
    sudo docker exec server$i /bin/bash -c \
    'ip r del default via 10.0.2.1'

    sudo docker exec server$i /bin/bash -c \
    'ip r a default via 10.0.2.254'
done