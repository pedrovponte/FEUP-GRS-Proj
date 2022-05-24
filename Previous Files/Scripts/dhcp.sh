#!/bin/bash

# create directory for dhcp
cd
mkdir dhcp
cd dhcp

# create Dockerfile
touch Dockerfile
echo 'FROM ubuntu:latest' >> Dockerfile
echo 'RUN apt update && apt install -y isc-dhcp-server' >> Dockerfile 
echo 'RUN touch /var/lib/dhcp/dhcpd.leases' >> Dockerfile 
echo 'CMD ["/usr/sbin/dhcpd", "-4", "-f", "-d","--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]' >> Dockerfile 

# create dhcp.conf
touch dhcp.conf
echo 'default-lease-time 600;
max-lease-time 7200;
authoritative;
option rfc3442-classless-static-routes code 121 = array of integer 8;
subnet 10.0.1.0 netmask 255.255.255.0 {
    range 10.0.1.64 10.0.1.127;
    option routers 10.0.1.254;
    option rfc3442-classless-static-routes 8,10,10,0,1,254;
    option domain-name-servers 10.0.1.1;
}' >> dhcp.conf


# run dhcp connection 
sudo docker run -d --rm --net client_net --ip 10.0.1.2 --cap-add=NET_ADMIN -v /home/theuser/dhcp/dhcp.conf:/etc/dhcp/dhcpd.conf dhcp

# sudo dhclient (requires a NGINX server to be running)
#sudo dhclient