#!/bin/bash

# Remove dmz_net network if it already exists
docker network disconnect dmz_net edgerouter
docker network disconnect dmz_net router
docker network rm dmz_net

# Remove route from iptables if it exist 
sudo ip route del 172.16.123.128/28


# Setup external interface and macvlan DMZ on docker host
sudo ip l set ens21 up
sudo docker network create -d macvlan --subnet=172.16.123.128/28 --gateway=172.16.123.140 -o parent=ens21 dmz_net


# Let docker know about the DMZ network, and NAT it
sudo ip route add 172.16.123.128/28 via 172.31.255.253
sudo iptables -t nat -A POSTROUTING -s 172.16.123.128/28 -o eth4 -j MASQUERADE

# Router
sudo docker network disconnect public_net router
sudo docker network connect dmz_net router --ip 172.16.123.142
sudo docker exec router /bin/bash -c 'ip r a default via 172.16.123.139'

# Edge router
sudo docker run -d --rm --net dmz_net --ip 172.16.123.139 --cap-add=NET_ADMIN --name edgerouter netubuntu
sudo docker network connect public_net edgerouter --ip 172.31.255.253
sudo docker exec edgerouter /bin/bash -c 'ip r d default via 172.16.123.140'
sudo docker exec edgerouter /bin/bash -c 'ip r a default via 172.31.255.254'
sudo docker exec edgerouter /bin/bash -c 'ip r a 10.0.0.0/8 via 172.16.123.142'

# Don't forward internal networks, NAT them
sudo docker exec edgerouter /bin/bash -c

sudo docker exec edgerouter /bin/bash -c iptables -t nat -F; iptables -t filter -F iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -o eth1 -j MASQUERADE

sudo docker exec edgerouter /bin/bash -c 'iptables -t nat -F'
sudo docker exec edgerouter /bin/bash -c 'iptables -t filter -F'
sudo docker exec edgerouter /bin/bash -c 'iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -o eth1 -j MASQUERADE'
sudo docker exec edgerouter /bin/bash -c 'iptables -P FORWARD DROP'
sudo docker exec edgerouter /bin/bash -c 'iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT'
sudo docker exec edgerouter /bin/bash -c 'iptables -A FORWARD -m state --state NEW -i eth0 -j ACCEPT'
sudo docker exec edgerouter /bin/bash -c 'iptables -A FORWARD -m state --state NEW -i eth1 -d 172.16.123.128/28 -j ACCEPT'
   
# External host
sudo docker exec external_host /bin/bash -c 'ip r a 172.16.123.128/28 via 172.31.255.253'
