#!/usr/bin/env bash

# Run this file and it will do everything
# In order to run you need to run the following commands on a bash shell:
    # chmod 0744 run.sh
    # ./run.sh

chmod 0600 g.rsa
chmod 0744 *.sh *.py
./copyToA.sh

HOME=/home/theuser

ssh -i g.rsa theuser@192.168.109.158 -t chmod 0744 $HOME/grs/A/runA.sh
ssh -i g.rsa theuser@192.168.109.158 -t $HOME/grs/A/runA.sh

