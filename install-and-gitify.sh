#!/bin/bash
echo "install dependencies, koha-common, and gitify a koha for lib2dev in 90 mins. Please make sure you are connected to the internet. Enter to continue."
read dooeet
echo "install dependencies and configure modules"
echo "set up repo and install koha-common"
echo deb http://debian.koha-community.org/koha squeeze main | sudo tee /etc/apt/sources.list.d/koha.list
wget -O- http://debian.koha-community.org/koha/gpg.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y git mysql-server apache2 libcrypt-eksblowfish-perl
sudo a2enmod rewrite
sudo apache2ctl restart
cd /home/train/
echo "install gitify"
git clone git://github.com/mkfifo/koha-gitify.git
sudo chmod +x ~/koha-gitify/koha-gitify
wget http://segfault.net.nz/koha-academy/koha-sites.conf
sudo apt-get install -y koha-common
sudo mv koha-sites.conf /etc/koha/
sudo a2dissite 000-default
sudo koha-create --create-db library
echo 127.0.0.1 library.localhost library-intra.localhost | sudo tee -a /etc/hosts
echo "password to ~/kohapassword.txt"
echo "username is koha_library" >> kohapassword.txt
sudo xmlstarlet sel -t -v 'yazgfs/config/pass' /etc/koha/sites/library/koha-conf.xml >> kohapassword.txt
cat kohapassword.txt
sudo chgrp -R library-koha ~/koha
sudo chmod -R 755 ~/koha
echo "can you see the web installer? ctrl-c if not, and fix that. Enter to gitify this Koha with a repo located in ~/koha"
read dooeet
echo "gitifying this koha"
sudo koha-gitify/koha-gitify library ~/koha 
sudo apache2ctl restart
echo "installing the database"
zcat ~/library-2013-10-14.sql.gz | sudo koha-mysql library
sudo koha-rebuild-zebra --full -v -v library
cd ~/koha
git config --global core.filemode false
git reset --hard HEAD && git fetch && git rebase origin/master
