#!/bin/bash

#setup key generating env
cd /usr/share/easy-rsa/
. ./vars
./clean-all

echo "generate ca.crt and ca.key"
./pkitool --initca
cp keys/ca.csr /keys/
cp keys/ca.crt /keys/


echo "generate server.crt and server.key"
./pkitool --server server
cp keys/server.csr /keys/
cp keys/server.crt /keys/

echo "generate dh.pem"
openssl dhparam -out ${KEY_DIR}/dh.pem ${KEY_SIZE}
cp keys/dh.pem /keys/
