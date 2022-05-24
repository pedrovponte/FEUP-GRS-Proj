FROM jasonrivers/nagios
RUN apt update && apt install -y vim \
    iproute2 iputils-ping tcpdump \
    iptables dnsutils curl net-tools
RUN curl https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-4.0.3/nrpe-4.0.3.tar.gz \
    --output /tmp/nrpe.tar.gz
EXPOSE 80