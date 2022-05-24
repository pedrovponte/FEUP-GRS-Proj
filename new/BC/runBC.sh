#!/usr/bin/env bash

HOME=/home/theuser


# Restart clock
sudo hwclock --hctosys 

# Execute this script on both B and C computers

sudo ip r d default via 192.168.88.1
sudo ip r a default via 192.168.88.100
sleep 1

echo "nameserver 193.136.28.10
options edns0 trust-ad
search netlab.fe.up.pt" | sudo tee /etc/resolv.conf

# Give execute permission to all the files that will be executed
chmod -R 0744 $HOME/grs 


# Files to be executed on both computers
$HOME/grs/BC/installDocker.sh
sleep 2
$HOME/grs/netubuntu/buildNetubuntu.sh
$HOME/grs/server/buildServer.sh
$HOME/grs/loadBalancer/buildLoadBalancer.sh
$HOME/grs/dns/buildDNS.sh
$HOME/grs/BC/removeDockers.sh
$HOME/grs/BC/setupNetworks.sh

if [ $1 = "B" ]; then
    # Execute only in B
    $HOME/grs/BC/clientNetwork.sh 1 5
    $HOME/grs/BC/serverNetwork.sh 1 2
    $HOME/grs/BC/loadBalancer.sh
    $HOME/grs/BC/router.sh
    $HOME/grs/BC/edgeRouter.sh
    $HOME/grs/dns/dns.sh
    $HOME/grs/BC/nagios.sh
    $HOME/grs/BC/dhcp.sh
    $HOME/grs/BC/proxy.sh
    $HOME/grs/BC/dmzServices.sh
    $HOME/grs/BC/externalhost.sh
else
    # Execute only in C
    $HOME/grs/BC/clientNetwork.sh 6 10
fi