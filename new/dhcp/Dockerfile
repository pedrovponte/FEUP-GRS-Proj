FROM ubuntu:latest
RUN apt update && apt install -y isc-dhcp-server
RUN touch /var/lib/dhcp/dhcpd.leases
CMD ["/usr/sbin/dhcpd", "-4", "-f", "-d", "--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]