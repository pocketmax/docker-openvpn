FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y easy-rsa openvpn supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]

EXPOSE 1194
