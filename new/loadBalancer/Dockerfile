FROM nginx
RUN apt update && apt install -y vim \
    iproute2 iputils-ping tcpdump \
    iptables dnsutils curl net-tools
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
# COPY sleep.sh /root/sleep.sh
# CMD /root/sleep.sh