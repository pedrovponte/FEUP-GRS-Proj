#!/usr/bin/env bash

#Create and initialize openvpn
docker run --rm -v $PWD:/etc/openvpn kylemanna/openvpn ovpn_genconfig -u udp://172.16.123.132:1194

#Change openvpn configuration
docker run --rm -v $PWD:/etc/openvpn kylemanna/openvpn /bin/bash -c "echo 'server 192.168.255.0 255.255.255.0
verb 3
key /etc/openvpn/pki/private/172.16.123.132.key
ca /etc/openvpn/pki/ca.crt
cert /etc/openvpn/pki/issued/172.16.123.132.crt
dh /etc/openvpn/pki/dh.pem
tls-auth /etc/openvpn/pki/ta.key
key-direction 0
keepalive 10 60
persist-key
persist-tun

proto udp
# Rely on Docker to do port mapping, internally always 1194
port 1194
dev tun0
status /tmp/openvpn-status.log

user nobody
group nogroup
comp-lzo no

### Route Configurations Below
route 10.0.1.0 255.255.255.0

### Push Configurations Below
push \"block-outside-dns\"
push \"dhcp-option DNS 8.8.8.8\"
push \"dhcp-option DNS 8.8.4.4\"
push \"comp-lzo no\"' > /etc/openvpn/openvpn.conf"

#In the below step, you have to provide a password for CA and key 
docker run --rm -v $PWD:/etc/openvpn -it kylemanna/openvpn ovpn_initpki
#Create User Account. Password provided in this step is required at the time of connection from client
docker run --rm -v $PWD:/etc/openvpn -it kylemanna/openvpn easyrsa build-client-full usr1
# Copy client certificate to host from container
docker run --rm -v $PWD:/etc/openvpn kylemanna/openvpn ovpn_getclient usr1 > usr1.ovpn



#Start OpenVPN container 
docker run --name openvpn -v $PWD:/etc/openvpn -d --net dmz_net --ip 172.16.123.132 --cap-add=NET_ADMIN --restart always kylemanna/openvpn



# Routing for vpn
sudo docker exec openvpn /bin/bash -c \
'ip r del default'

sudo docker exec openvpn /bin/bash -c \
'ip r a default via 172.16.123.139'
sudo docker exec openvpn /bin/bash -c \
'ip r a 10.0.0.0/8 via 172.16.123.142'