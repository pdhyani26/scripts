#!/bin/bash
#to install the required nagios plugins

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mInstalling pre-requistive plugins...\e[0m"
sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext
sudo apt-get install -y libpqxx3-dev
sudo apt-get install -y libdbi-dev
sudo apt-get install -y libldap2-dev
sudo apt-get install -y libmysqlclient-dev
sudo apt-get install -y smbclient
sudo apt-get install -y qstat
sudo apt-get install -y fping
sudo apt-get install -y qmail-tools

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mChanging directory and downloading nagios plugin...\e[0m"
cd /tmp
echo -e "\e[36mPresent Working directory\e[0m" 
pwd
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxf nagios-plugins.tar.gz

echo -e "\e[31mSwitiching directory after untarring...\e[0m"
cd /tmp/nagios-plugins-release-2.2.1/
echo -e "\e[36mPresent Working directory\e[0m" 
pwd
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install
sudo systemctl restart nagios.service
