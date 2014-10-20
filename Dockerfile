FROM ubuntu:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y easy-rsa openvpn

ADD openvpn-client.conf /tmp/
ADD openvpn-server.conf /tmp/

RUN cp /tmp/openvpn-server.conf /etc/openvpn/openvpn.conf

RUN mkdir /keys
ADD init.sh /tmp/

RUN chmod 700 /tmp/init.sh
RUN /tmp/init.sh
#https://openvpn.net/index.php/open-source/documentation/howto.html