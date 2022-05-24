#!/bin/bash

# Test 1
sudo docker exec -it client /usr/bin/curl http://10.0.2.101/
sudo docker exec -it client /usr/bin/curl -x 10.0.1.253:3128 http://10.0.2.101/
sudo docker exec -it client /usr/bin/curl https://10.0.2.101/
sudo docker exec -it client /usr/bin/curl -x 10.0.1.253:3128 https://10.0.2.101/ 

# Run again with the iptables rule from the other script
