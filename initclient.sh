#!/bin/bash

#setup key generating env
cd /usr/share/easy-rsa/
. ./vars
./clean-all
export KEY_CN=$1

if [ -z "$1" ]; then
    echo "initclient.sh clientName"
    exit 1
fi

if [ ! -f /keys/ca.crt ]; then
    echo "/keys/ca.crt is required and has to be be copied from the server and not generated on the client"
    exit 1
fi

echo "generate client.crt"
./pkitool client
cp keys/client.csr /keys/
cp keys/client.crt /keys/
