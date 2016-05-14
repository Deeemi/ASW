#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PROJECTFOLDER='asw'

# create project folder
sudo mkdir "/var/www/html/${PROJECTFOLDER}"

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# install apache 2.5 and php 5.5
sudo apt-get install -y apache2
sudo apt-get install -y php5
sudo apt-get install -y libapache2-mod-php5
sudo apt-get install -y php5-pgsql

# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
sudo service apache2 restart

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
