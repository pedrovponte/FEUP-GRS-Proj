#!/usr/bin/env python3

# Instant ssh to any of the 3 machines

import os
from sys import argv

if len(argv) != 2:
    print("Usage: python ssh.py [A|B|C]")
    exit(1)

if argv[1] == "A":
    os.system("ssh -i g.rsa theuser@192.168.109.158")
elif argv[1] == "B":
    os.system("ssh -i g.rsa theuser@192.168.109.158 -t ssh -i .ssh/privBC.rsa theuser@192.168.88.101")
elif argv[1] == "C":
    os.system("ssh -i g.rsa theuser@192.168.109.158 -t ssh -i .ssh/privBC.rsa theuser@192.168.88.102")
