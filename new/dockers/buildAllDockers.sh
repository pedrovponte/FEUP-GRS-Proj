#!/usr/bin/env bash

DOCKERS=/home/theuser/grs/dockers

# Executes all the build.sh in this folder
find $DOCKERS -iname "build.sh" | bash
