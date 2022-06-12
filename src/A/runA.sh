#!/usr/bin/env bash

HOME=/home/theuser

# File that is meant to be run on machine A to config everything

# Give execute permission to files that will be executed
chmod 0744 $HOME/grs/A/*

# Files to be executed on A
$HOME/grs/A/configA.sh
$HOME/grs/A/copyToBC.sh
