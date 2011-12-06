#!/bin/bash 
# this script was used to clean up miscreant KLOW sites. It resets the admin passwords, activates the default theme, sets the upload path, and harvests the email address for user librarian.
mysql_user=xxxxxxx
mysql_pass=xxxxxxx
admin_email=<the admin email addy>
user_email=<the user email addy>
user_pass=<the password, MD5>
admin_pass=<the admin pass, MD5>
user_login=<the non-admin user to update>

echo "Import/update DB, password reset. Enter the town:"
read town
mysql -u$mysql_user -p$mysql_pass $town < /home/cftuser/backup/$town.sql
echo "STOP. Go update the DNS and run the DB update at the site before continuing. Press Enter to continue when ready."
read STOP
mysql -u$mysql_user -p$mysql_pass $town -sN -e "UPDATE wp_users SET user_pass='$admin_pass' WHERE user_email='$admin_email'"
mysql -u$mysql_user -p$mysql_pass $town -sN -e "UPDATE wp_users SET user_pass='$user_pass' WHERE user_login='$user_login'"
mysql -u$mysql_user -p$mysql_pass $town -sN -e "UPDATE wp_options SET option_value='WordPress Default' WHERE option_name='current_theme'"
mysql -u$mysql_user -p$mysql_pass $town -sN -e "UPDATE wp_options SET option_value='' WHERE option_name='uploads_use_yearmonth_folders'"
mysql -u$mysql_user -p$mysql_pass $town -sN -e "UPDATE wp_options SET option_value='wp-content/uploads' WHERE option_name='upload-path'"
result=$(mysql -u$mysql_user -p$mysql_pass $town -sN -e "SELECT user_email FROM wp_users WHERE user_login='librarian'")
echo "$result" >> /home/cftuser/librarian_email_list.txt
echo "Done. Double check everything we've done here."

