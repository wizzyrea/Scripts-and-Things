#!/bin/bash
#this script harvests the email addresses out of every user on KLOW sites that is not an admin.
mysql_user=xxxxxxx
mysql_pass=xxxxxxx
savepath=/home/cftuser

cd /etc/apache2/sites-available
for f in `ls`
do
result=$(mysql -u$mysql_user -p$mysql_pass $f -sN -e "SELECT user_email, user_login FROM wp_users WHERE user_login!='admin'")
echo "User for site $f = $result"
echo "$result" >> "$savepath"/librarian_email_list.txt
done
