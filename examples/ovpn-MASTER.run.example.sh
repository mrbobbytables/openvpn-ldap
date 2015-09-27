#!/bin/bash
docker run -d --net=host --cap-add NET_ADMIN \
-e ENVIRONMENT=production \
-e PARENT_HOST=$(hostname) \
-e OVPN_LOCAL=172.16.1.20 \
-e OVPN_PUSH_1="route 10.10.0.0 255.255.255.0" \
-e OVPN_PUSH_2="dhcp-option DNS 10.10.0.111" \
-e OVPN_PUSH_3="dhcp-option DNS 10.10.0.112" \
-e OVPN_NET_1="eth0:10.10.0.0/24" \
-e KEEPALIVED_STATE=MASTER \
-e KEEPALIVED_INTERFACE=eth0 \
-e KEEPALIVED_VIRTUAL_ROUTER_ID=2 \
-e KEEPALIVED_VRRP_UNICAST_BIND=10.10.0.21 \
-e KEEPALIVED_VRRP_UNICAST_PEER=10.10.0.22 \
-e KEEPALIVED_TRACK_INTERFACE_1=eth0 \
-e KEEPALVED_TRACK_INTERFACE_2=eth1 \
-e KEEPALIVED_VIRTUAL_IPADDRESS_1="10.10.0.3 dev eth0" \
-e KEEPALIVED_VIRTUAL_IPADDRESS_EXCLUDED_1="172.16.1.20 dev eth1" \
openvpn-ldap
