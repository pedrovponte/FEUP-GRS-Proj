#!/usr/bin/env bash

CONNECTION=/home/theuser/grs/tests/connection.sh

assertTrue () {
    if [[ $? -ne 0 ]]
    then
        echo '--------TESTS FAILED--------'
        exit 1
    fi
}

assertFalse () {
    if [[ $? -eq 0 ]]
    then
        echo '--------TESTS FAILED--------'
        exit 1
    fi
}


$CONNECTION client1 10.0.1.254; assertTrue
$CONNECTION client1 10.0.2.101; assertTrue
$CONNECTION client1 172.16.123.129; assertTrue
$CONNECTION client1 172.16.123.130; assertTrue
$CONNECTION client1 172.16.123.131; assertTrue
$CONNECTION client1 172.16.123.132; assertTrue
$CONNECTION client1 172.16.123.139; assertTrue
$CONNECTION client1 mail.myorg.net; assertTrue
$CONNECTION client1 1.1.1.1; assertTrue
$CONNECTION client1 google.com; assertTrue

$CONNECTION loadBalancer 10.0.1.3; assertTrue
$CONNECTION loadBalancer 10.0.2.101; assertTrue

$CONNECTION external_host 10.0.1.3; assertFalse
$CONNECTION external_host 10.0.2.101; assertFalse
$CONNECTION external_host 172.16.123.132; assertTrue
$CONNECTION external_host mail.myorg.net; assertTrue

# Connect external host to VPN
docker cp ~/usr1.ovpn external_host:/etc/openvpn/usr1.ovpn
docker exec external_host /bin/bash -c "openvpn --config /etc/openvpn/usr1.ovpn --askpass <(echo '12345')" &
sleep 2

$CONNECTION external_host 10.0.1.3; assertTrue
$CONNECTION external_host 10.0.2.101; assertTrue
$CONNECTION external_host 172.16.123.132; assertTrue
$CONNECTION external_host mail.myorg.net; assertTrue







echo '-----ALL TESTS SUCCEEDED------'
