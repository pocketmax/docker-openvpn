#!/bin/bash

#setup tun
[ -d /dev/net ] ||
    mkdir -p /dev/net
[ -c /dev/net/tun ] ||
    mknod /dev/net/tun c 10 200

#setup key generating env
cd /usr/share/easy-rsa/
. ./vars
./clean-all
export KEY_CN=$HOSTNAME


#are we in server or client mode?
if grep -q "mode server" /etc/openvpn/openvpn.conf; then
    server=true
fi

# check for / generate server certs
if [ "$server" ]; then


    if [ ! -f /keys/ca.csr -o ! -f /keys/ca.crt ]; then
        echo "generate ca.crt and ca.key"
        ./pkitool --initca
        cp keys/ca.csr /keys/
        cp keys/ca.crt /keys/
    fi


    if [ ! -f /keys/server.csr -o ! -f /keys/server.crt ]; then
        echo "generate server.crt and server.key"
        ./pkitool --server server
        cp keys/server.csr /keys/
        cp keys/server.crt /keys/
    fi

    if [ ! -f /keys/dh.pem ]; then
        echo "generate dh.pem"
        openssl dhparam -out ${KEY_DIR}/dh.pem ${KEY_SIZE}
        cp keys/dh.pem /keys/

    fi



# check for / generate client certs
else

    if [ ! -f /keys/ca.crt ]; then
        echo "/keys/ca.crt is required and has to be be copied from the server and not generated on the client"
        exit 1
    fi

    if [ ! -f /keys/client.csr -o ! -f /keys/client.crt ]; then
        echo "generate client.crt"
        ./pkitool client
        cp keys/client.csr /keys/
        cp keys/client.crt /keys/
    fi


fi

openvpn --config /etc/openvpn/server.conf
