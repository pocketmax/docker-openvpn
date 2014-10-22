# OpenVPN client/server

This is a basic OpenVPN service

## In server mode with specific keys
```
docker run -d -i \
--privileged=true \

--hostname server \
--name=openvpn-server \
-p 1194:1194 \

-v /ca.crt:/keys/ca.crt \
-v /ca.key:/keys/ca.key \

-v /dn.pem:/keys/dn.pem \

-v /server.crt:/keys/server.crt \
-v /server.key:/keys/server.key \

pocketmax/openvpn
```

You can also override the default openvpn.conf file by adding...
```
-v /localopenvpn.conf:/etc/openvpn/openvpn.conf
```

## In client mode with pre-built keys
```
docker run -d -i \
--privileged=true \

--hostname client \
--name=openvpn-client \

-v /ca.crt:/keys/ca.crt \

-v /client.crt:/keys/client.crt \
-v /client.key:/keys/client.key \

pocketmax/openvpn
```

and any keys that aren't present will be generated and placed in the baremetal directory and can simply be copied out...
```
docker copy /keys/thekey.key /baremetal/bla
```

https://openvpn.net/index.php/open-source/documentation/howto.html