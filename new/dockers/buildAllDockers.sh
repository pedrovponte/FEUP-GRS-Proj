#!/usr/bin/env bash

DOCKERS=/home/theuser/grs/dockers

# Builds all the dockers that will be needed
$DOCKERS/dhcp/build.sh
$DOCKERS/dns/build.sh
$DOCKERS/dnloadBalancer/build.sh
$DOCKERS/nagios/build.sh
$DOCKERS/netubuntu/build.sh
$DOCKERS/server/build.sh
$DOCKERS/squid/build.sh
