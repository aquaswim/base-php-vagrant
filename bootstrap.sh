#!/usr/bin/env bash

apt-get update
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
apt-get install software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository 'deb [arch=amd64,arm64,i386,ppc64el] http://sgp1.mirrors.digitalocean.com/mariadb/repo/10.4/ubuntu xenial main'

# install mariadb
apt update -y
apt install mariadb-server -y

# enable mariadb
systemctl start mariadb.service
systemctl enable mariadb.service

# TODO: secure mariadb automation
