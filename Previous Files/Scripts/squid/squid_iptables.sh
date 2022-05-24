#!/bin/bash

# Router iptables rule
sudo docker exec router /bin/bash -c 'iptables -t filter -A FORWARD -p tcp -- dport 80 ! -s 10.0.1.253 -j DROP'