#!/usr/bin/env bash

for i in range {1..5}
do
    sudo docker build --tag loadbalancer:latest ~/grs/loadBalancer
    if [ $? -eq 0 ] 
    then
        exit 0
    else
        echo "Retriyng docker build"
    fi
done