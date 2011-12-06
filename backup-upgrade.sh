#!/bin/bash
# this script makes a backup and updates a wordpress site.

mysql_user=xxxxxxx
mysql_pass=xxxxxxx

# some logic to procure which site we are working on to create the $town variable, for now it's entered by hand (for testing)

echo "Enter town name:"
read town

#get the date
date=$(date +%D)

#create infrastructure for backup storage
mkdir /home/$town/2.9backup
chown $town:$town /home/$town/2.9backup

# backup database
mysqldump -u$mysql_user -p$mysql_pass $town > /home/$town/2.9backup/$town-$date.sql

# backup files
mkdir /home/$town/2.9backup/files-$town-$date
cp -ar /home/$town/public_html /home/town/2.9backup/files-$town-$date

# install new files, or run internal upgrade script
lynx /home/$town/public_html/wp-admin/update-core.php

# Install updated plugins
cp -r /home/skeleton/public_html/wp-content/plugins/* /home/$town/public_html/wp-content/plugins/

# update owners
chown -R /home/$town/public_html

