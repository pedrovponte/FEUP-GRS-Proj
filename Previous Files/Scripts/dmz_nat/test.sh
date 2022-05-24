# /bin/bash

# Test From the Client
sudo docker exec client /bin/ping -c 3 1.1.1.1
sudo docker exec client /bin/ping -c 3 10.0.2.100
sudo docker exec client /bin/ping -c 3 172.16.123.139
sudo docker exec client /bin/ping -c 3 172.31.255.100


# Test From the Host
sudo docker exec external_host /bin/ping -c 3 172.16.123.142 
sudo docker exec external_host /bin/ping -c 3 10.0.1.100

