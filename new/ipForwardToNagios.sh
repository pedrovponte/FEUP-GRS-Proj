#!/usr/bin/env bash


if [ $1 = "B" ]; then
ssh -L 8888:192.168.88.101:8080 -i g.rsa theuser@192.168.109.158
else
ssh -L 8888:192.168.88.102:8080 -i g.rsa theuser@192.168.109.158
fi