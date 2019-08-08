###############Jenkins###################
#!/bin/bash

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mUpdating the RHEL server...\e[0m"

sudo yum update -y

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mInstalling JAVA...\e[0m"

sudo yum install java-1.8.0-openjdk.x86_64 -y

echo -e "\e[36m**********************************Installed JAVA***************************************************\e[0m"
echo -e "\e[31mPrinting the version of the JAVA...\e[0m"
java -version 

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mSetting JAVA Home and JRE HOME...\e[0m"
sudo cp /etc/profile /etc/profile_backup 

echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile 
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile 
source /etc/profile 

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mJAVA Home is...\e[0m"
echo $JAVA_HOME 
echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mJRE Home is...\e[0m"
echo $JRE_HOME 
echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mChanging Home Directory...\e[0m"
cd ~
echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mInstalling wget...\e[0m"
sudo yum install wget -y

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mPulling JENKINS from the internet...\e[0m"
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo 

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key 

echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mInstalling JENKINS...\e[0m"
yum install jenkins -y
echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mStarting JENKINS service...\e[0m"
sudo systemctl start jenkins.service

sudo systemctl enable jenkins.service 
echo -e "\e[36m***************************************************************************************************\e[0m"
echo -e "\e[31mInstalling and starting firewall service...\e[0m"
sudo yum install firewalld -y

sudo systemctl start firewalld

sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --reload 

echo -e "\e[36m***************************************************************************************************\e[0m"

printf "\e[32mYour ip address for Jenkins Home Page is - http://`curl ifconfig.me`:8080\e[0m \n"

printf "\e[32mPassword for home page :  `cat /var/lib/jenkins/secrets/initialAdminPassword`\e[0m\n"
