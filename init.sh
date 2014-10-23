#!/bin/bash

#setup tun
[ -d /dev/net ] ||
    mkdir -p /dev/net
[ -c /dev/net/tun ] ||
    mknod /dev/net/tun c 10 200

client-config-dir ccd
openvpn --config /etc/openvpn/server.conf
