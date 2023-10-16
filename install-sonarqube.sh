#!/bin/bash

echo "------------------------------ installation of SonarQube --------------------------------"

tar zxvf openjdk-11.0.2_linux-x64_bin.tar.gz 


sudo mv jdk-11.0.2/ /usr/lib/jvm/

sudo vi .bash_profile

source .bash_profile

sudo alternatives --set java /usr/lib/jvm/jdk-11.0.2/
sudo alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11.0.2/bin/java 1
sudo alternatives --config java
sudo yum install pgdg-redhat-repo-latest.noarch.rpm -y
cd postgresql/
sudo rpm -ivh postgresql14-*
sudo yum localinstall postgresql14-*

cd /usr/pgsql-14/bin/

sudo postgresql-14-setup initdb

sudo vim /var/lib/pgsql/14/data/pg_hba.conf


sudo systemctl start postgresql-14.service 
sudo systemctl enable postgresql-14.service 
sudo systemctl status postgresql-14.service 
sudo -u postgres /usr/pgsql-14/bin/psql -c "SELECT version();"
sudo passwd postgres
sudo su - postgres

sudo unzip sonarqube-7.9.1.zip 

sudo mv sonarqube-7.9.1 sonarqube
sudo mv sonarqube /opt
sudo vim /opt/sonarqube/conf/sonar.properties

sudo useradd sonar
sudo passwd sonar
sudo chown -R sonar:sonar /opt/sonarqube/

sudo su - sonar
sudo visudo 
sudo su - sonar
sudo ./sonar.sh start
cd /opt/sonarqube/bin/linux-x86-64/
sudo ./sonar.sh stop
sudo ./sonar.sh status




###################
sudo nano /etc/security/limits.conf

sonar  soft  nofile  65535
sonar  hard  nofile  65535

sudo nano /etc/pam.d/common-session
 
session required pam_limits.so

su - sonar





