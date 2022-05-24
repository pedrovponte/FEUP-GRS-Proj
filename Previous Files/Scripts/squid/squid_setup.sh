#!/bin/bash

# Create gors directory for squid if it doesnt exists
cd
mkdir -p gors/etcsquid
cd gors/etcsquid

# Create file ectsquid/squid.conf
touch squid.conf
echo 'acl Safe_ports port 80
acl localnet src 10.0.1.0/24
http_access deny !Safe_ports
http_access allow localnet
http_access deny all
http_port 3128' >> squid.conf

# Create Dockerfile
touch Dockerfile
echo 'FROM ubuntu/squid:latest
RUN apt update && apt install -y vim iproute2 iputils-ping' >> Dockerfile


# Setup
docker run -d --name squid -e TZ=UTC -v /home/gors/etcsquid/squid.conf:/etc/squid/squid.conf --rm --net client_net --ip 10.0.1.253 --cap-add=NET_ADMIN mysquid
sudo docker exec squid ip r d default via 10.0.1.1
sudo docker exec squid ip r d default via 10.0.1.254


