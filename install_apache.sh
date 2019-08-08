#!/bin/bash

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mUninstalling existing Apache server and removing its packages...\e[0m"

sudo yum remove httpd -y
sudo yum erase httpd httpd-tools apr apr-util -y

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mInstalling Apache Server...\e[0m"
echo

sudo yum install httpd -y


echo '**********************************************************************************'
echo -e "\e[31mApache installed successfully...\e[0m"

echo -e "\e[36m#################################  Starting server after installation  ############################################\e[0m"

sudo systemctl start httpd
echo -e "\e[31mService started sucessfully...\e[0m"

echo -e "\e[36m############################  Checking status of Apache Server  ############################################\e[0m"

sudo systemctl status httpd

