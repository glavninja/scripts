#!/bin/bash

sudo cat /dev/null > /etc/hosts
sudo cat > /etc/hosts <<EOF
10.10.10.105 ui.mint-services.net ui
EOF

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install libgmp-dev libidn11 wget \
nano make netcat sudo sysstat libtool libltdl7-dev \
build-essential libc6 perl ntp libperl-dev libidn11-dev \
sysstat sqlite3 wget libaio1 resolvconf unzip pax netcat-openbsd dnsmasq -y

sudo cat > /etc/dnsmasq.d/dns.conf <<EOF
server=8.8.8.8
server=8.8.4.4
address=/localhost/127.0.0.1
address=/proxy1.mint-services.net/10.10.10.100
address=/proxy2.mint-services.net/10.10.10.101
address=/ldapmaster.mint-services.net/10.10.10.102
address=/ldapslave.mint-services.net/10.10.10.103
address=/store1.mint-services.net/10.10.10.104
address=/ui.mint-services.net/10.10.10.105
address=/mx1.mint-services.net/10.10.10.106
address=/mx2.mint-services.net/10.10.10.107
EOF

sudo /etc/init.d/dnsmasq restart

wget https://files.zimbra.com/downloads/8.6.0_GA/zcs-8.6.0_GA_1153.UBUNTU14_64.20141215151116.tgz
sudo tar xvfz zcs-*
