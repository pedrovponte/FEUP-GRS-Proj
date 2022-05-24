FROM ubuntu
RUN apt update && apt install -y vim \
    iproute2 iputils-ping tcpdump \
    iptables dnsutils curl net-tools
COPY sleep.sh /root/sleep.sh
CMD /root/sleep.sh