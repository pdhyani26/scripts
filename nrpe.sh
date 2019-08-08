#!/bin/bash

sudo yum update -yum

cd /opt

yum install wget -y
wget http://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
tar zxvf nagios-plugins-2.2.1.tar.gz

wget https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz
tar zxvf nrpe-3.2.1.tar.gz


yum install -y gcc glibc glibc-common make gettext automake autoconf wget openssl-devel  epel-release 

cd nagios-plugins-2.2.1

./configure 
make
make install

useradd nagios
groupadd nagios
usermod -a -G nagios nagios
chown nagios.nagios /usr/local/nagios
chown -R nagios.nagios /usr/local/nagios/libexec

cd /opt
cd nrpe-3.2.1
./configure
make all
make install
make install-config


make install-init 
systemctl enable nrpe


