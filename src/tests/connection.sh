#!/usr/bin/env bash

docker exec $1 ping -c 3 $2 > /dev/null

if [[ $? -eq 0 ]]
then
    echo $1 'can connect to' $2
    exit 0
else
    echo $1' cannot connect to' $2
    exit 1
fi