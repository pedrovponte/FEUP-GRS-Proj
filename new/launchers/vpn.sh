#!/usr/bin/env bash

#Create and initialize openvpn
docker run --rm -v $PWD:/etc/openvpn kylemanna/openvpn ovpn_genconfig -u udp://172.16.123.132:1194
#In the below step, you have to provide a password for CA and key 
docker run --rm -v $PWD:/etc/openvpn -it kylemanna/openvpn ovpn_initpki
#Create User Account. Password provided in this step is required at the time of connection from client
docker run --rm -v $PWD:/etc/openvpn -it kylemanna/openvpn easyrsa build-client-full usr1
# Copy client certificate to host from container
docker run --rm -v $PWD:/etc/openvpn kylemanna/openvpn ovpn_getclient usr1 > usr1.ovpn
#Start OpenVPN container 
docker run --name openvpn -v $PWD:/etc/openvpn -d ----net dmz_net --ip 172.16.123.132 --cap-add=NET_ADMIN --restart always kylemanna/openvpn
