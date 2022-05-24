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

# Install, build and cofigure dockers
echo '------INSTALLING DOCKER--------'
$HOME/grs/BC/installDocker.sh
sleep 2
echo '------CLEANING DOCKER----------'
$HOME/grs/B/cleanDocker.sh
echo '------BUILDING DOCKERS---------'
$HOME/grs/dockers/buildAllDockers.sh
echo '------PUBLIC_NET---------------'
$HOME/grs/B/public_net.sh
echo '------DMZ_NET------------------'
$HOME/grs/B/dmz_net.sh
echo '------SERVER_NET---------------'
$HOME/grs/B/server_net.sh
echo '------CLIENT_NET---------------'
$HOME/grs/B/client_net.sh

$HOME/grs/launchers/router.sh
