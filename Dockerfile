FROM ubuntu:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y easy-rsa openvpn supervisor
ADD openvpn /etc/openvpn

CMD ["/usr/sbin/openvpn", "--config", "/etc/openvpn/openvpn.conf"]

EXPOSE 1194
