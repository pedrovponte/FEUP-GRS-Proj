#!/usr/bin/env bash

HOME=/home/theuser

# Copy files to both machines
ssh -i .ssh/privBC.rsa theuser@192.168.88.101 -t mkdir -p $HOME/grs
ssh -i .ssh/privBC.rsa theuser@192.168.88.102 -t mkdir -p $HOME/grs
scp -i .ssh/privBC.rsa -r $HOME/grs/* theuser@192.168.88.101:$HOME/grs
scp -i .ssh/privBC.rsa -r $HOME/grs/*  theuser@192.168.88.102:$HOME/grs

# Give permissions and execute run scripts on both machines
ssh -i .ssh/privBC.rsa theuser@192.168.88.101 -t chmod 0744 $HOME/grs/BC/runBC.sh
ssh -i .ssh/privBC.rsa theuser@192.168.88.101 -t $HOME/grs/BC/runBC.sh B
ssh -i .ssh/privBC.rsa theuser@192.168.88.102 -t chmod 0744 $HOME/grs/BC/runBC.sh
ssh -i .ssh/privBC.rsa theuser@192.168.88.102 -t $HOME/grs/BC/runBC.sh C
