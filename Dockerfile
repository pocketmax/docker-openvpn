FROM ubuntu:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y easy-rsa openvpn

ADD openvpn-client.conf /tmp/
ADD openvpn-server.conf /tmp/

RUN cp /tmp/openvpn-client.conf /etc/openvpn/openvpn.conf

RUN mkdir /keys

ADD init.sh /
RUN chmod 700 /init.sh

ADD initclient.sh /
RUN chmod 700 /initclient.sh

ADD initserver.sh /
RUN chmod 700 /initserver.sh

RUN /init.sh

EXPOSE 1194
