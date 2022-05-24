#!/bin/bash

# Create public network on Docker with default gw
sudo docker network create public_net --subnet=172.31.255.0/24 --gateway=172.31.255.254

# Connect the router to the public network
sudo docker network connect public_net router --ip 172.31.255.253

# Update default gateway on the router
sudo docker exec router /bin/bash -c 'ip r d default via 10.0.1.1'
sudo docker exec router /bin/bash -c 'ip r a default via 172.31.255.254'

# Update default gateway on the client and server
sudo docker exec client /bin/bash -c 'ip r a default via 10.0.1.254'
sudo docker exec server /bin/bash -c 'ip r a default via 10.0.2.254'