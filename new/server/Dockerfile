FROM nginx
RUN apt update && apt install -y vim \
    iproute2 iputils-ping tcpdump \
    iptables dnsutils curl net-tools
EXPOSE 443 80
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/nginx.conf
# COPY sleep.sh /root/sleep.sh
# CMD /root/sleep.sh