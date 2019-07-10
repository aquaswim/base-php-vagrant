#!/usr/bin/env bash
#
# source https://www.vultr.com/docs/how-to-install-apache-24-mariadb-10-and-php-7x-on-ubuntu-16-04
apt-get update -y
# install apache
apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant_data /var/www
fi
# disable directory listing
sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks/" /etc/apache2/apache2.conf
systemctl restart apache2.service

# mariadb (search mirror in mariadb website)
apt-get install software-properties-common -y
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,arm64,i386,ppc64el] http://sgp1.mirrors.digitalocean.com/mariadb/repo/10.4/ubuntu xenial main'

# install mariadb
apt update -y
apt install mariadb-server -y

# change mariadb listen address to 0.0.0.0
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# enable mariadb
systemctl start mariadb.service
systemctl enable mariadb.service

# secure mariadb with root password
/vagrant_data/tools/mysql_secure.sh "password"

# create database
/vagrant_data/tools/create_db.sh "mydb" "password"

# install php 7.1
apt-get install -y python-software-properties
add-apt-repository -y ppa:ondrej/php
apt-get update -y
apt-get install -y php7.1 libapache2-mod-php7.1 php7.1-cli php7.1-common php7.1-mbstring php7.1-gd php7.1-intl php7.1-xml php7.1-mysql php7.1-mcrypt php7.1-zip php7.1-gettext