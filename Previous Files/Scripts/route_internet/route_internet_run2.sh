#!/bin/bash

# Test 2 – external host to client
sudo docker run -d --net public_net --ip 172.31.255.100 --cap-add=NET_ADMIN --name external_host netubuntu
sudo docker exec external_host /bin/bash -c 'ip r a 10.0.0.0/8 via 172.31.255.253'
docker exec -it external_host ping 10.0.1.100