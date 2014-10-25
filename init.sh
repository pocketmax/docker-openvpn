#!/bin/bash

#setup tun
[ -d /dev/net ] ||
    mkdir -p /dev/net
[ -c /dev/net/tun ] ||
    mknod /dev/net/tun c 10 200

#server config
if [ -f /keys/server.crt ] && [ ! -f /etc/openvpn/openvpn.conf ]; then
    cp /tmp/openvpn-server.conf /etc/openvpn/openvpn.conf
fi

#client config
if [ ! -f /keys/server.crt ] && [ ! -f /etc/openvpn/openvpn.conf ]; then
    cp /tmp/openvpn-client.conf /etc/openvpn/openvpn.conf
fi

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf