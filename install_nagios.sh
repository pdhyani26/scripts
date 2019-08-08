#!/bin/bash
#to install the pre-requisite packages


echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mInstalling pre-requistite packages...\e[0m"
sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.2 libgd-dev


echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mChanging directory and downloading nagios...\e[0m"
cd /tmp
echo -e "\e[36mPresent Working directory\e[0m" 
pwd
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.1.tar.gz 
echo -e "\e[31mUntarring nagios...\e[0m"
tar xzf nagioscore.tar.gz

echo -e "\e[31mSwitiching directory after untarring...\e[0m"
cd /tmp/nagioscore-nagios-4.4.1/ 
echo -e "\e[36mPresent Working directory\e[0m" 
pwd
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
echo -e "\e[31mcompiling and installing many open source utilities...\e[0m"
sudo make all

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mCreating nagios and group and adding 'www-data'user to Nagios group...\e[0m"
sudo make install-groups-users
sudo usermod -a -G nagios www-data

echo -e "\e[31mInstalling binary files, CGIs, Service/deamon files...\e[0m"
sudo make install
sudo make install-daemoninit 
sudo make install-commandmode 
sudo make install-config

echo -e "\e[31mInstalling the Apache web server configuration files and configuring Apache settings...\e[0m"
sudo make install-webconf 
sudo systemctl restart apache2
sudo a2enmod rewrite 
sudo systemctl restart apache2
sudo a2enmod cgi 

echo -e "\e[31mEnabling & Allowing port 80 inbound traffic on the local firewall ...\e[0m"
sudo ufw enable
sudo ufw allow Apache 

echo -e "\e[31mRefreshing firewall...\e[0m"
sudo ufw reload

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mInitial Setup completed...\e[0m"
echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mPlease enter the password you want to set for Nagios user(Nagiosadmin in this scenario)\e[0m"
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

sudo systemctl restart apache2.service


