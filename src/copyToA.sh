#!/usr/bin/env bash

HOME=/home/theuser

# Copies all the files to the VM A
ssh -i g.rsa theuser@192.168.109.158 -t mkdir -p $HOME/grs
scp -i g.rsa -r * theuser@192.168.109.158:$HOME/grs