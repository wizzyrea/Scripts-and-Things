#!/bin/bash
# this script is the master KLOW install script. 
mysql_user=xxxxxxx
mysql_pass=xxxxxxx
admin_name="Liz Rea" #admin never changes
admin_email=lrea@nekls.org #neither does their email addy, hopefully.

echo "KLOW Wordpress Installer 3.1... Let's get going!"
echo "Enter the name of the town, please."
read town
echo "creating wordpress site for $town. This takes a minute..."
adduser --system --group --force-badname $town
cp -a /home/skeleton/public_html /home/$town/
chown -R $town:$town /home/$town/public_html
chmod -R 750 /home/$town/public_html
echo "Creating the database..."
mysqladmin -u$mysql_user -p$mysql_pass create $town
echo "Creating passwords and keys..."
dbpassword=$(uuidgen |cut -c -64)
key1=$(uuidgen |cut -c -64)
key2=$(uuidgen |cut -c -64)
key3=$(uuidgen |cut -c -64)
key4=$(uuidgen |cut -c -64)
echo "Generating wp-config.php..."
echo "<?php
define('DB_NAME', '$town');
define('DB_USER', '$town');
define('DB_PASSWORD', '$dbpassword');
define('DB_HOST', 'localhost');
define('FS_METHOD', 'direct');
define('WP_TEMP_DIR', ABSPATH.'wp-content/uploads');
define('AUTH_KEY', '$key1');
define('SECURE_AUTH_KEY', '$key2');
define('LOGGED_IN_KEY', '$key3');
define('NONCE_KEY', '$key4');
\$table_prefix  = 'wp_';
define ('WPLANG', '');
if ( !defined('ABSPATH') )
        define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');" > /home/$town/wp-config.php
chown $town:www-data /home/$town/wp-config.php
chmod 550 /home/$town/wp-config.php
echo "Done writing config!"
echo "GRANT ALL PRIVILEGES ON $town.* TO '$town'@'localhost' IDENTIFIED BY '$dbpassword';" > installdbuser
mysql -u$mysql_user -p$mysql_pass < installdbuser
echo "Make VirtualHost file..."
echo "Enter any custom domain entries, start with www.domain.com. enter 1 for no custom domains:"
read wwwdomain
if test X"$wwwdomain" = X"1"; then
        echo "<VirtualHost *:80>
        ServerAdmin lrea@nekls.org
        DocumentRoot /home/$town/public_html
        ServerName $town.mykansaslibrary.org
        ErrorLog /var/log/apache2/$town.mykansaslibrary.org_error
        CustomLog /var/log/apache2/$town.mykansaslibrary.org_access common
        AssignUserID $town $town
<Directory /home/$town/public_html>
        DirectoryIndex index.php
        <IfModule mod_rewrite.c>
                RewriteEngine On
                RewriteBase /
                RewriteCond %{REQUEST_FILENAME} !-f
               RewriteCond %{REQUEST_FILENAME} !-d
                RewriteRule . /index.php [L]   
        </IfModule>
</Directory>
</VirtualHost>" > /etc/apache2/sites-available/$town
else
echo "Enter domain.com entry:"
read domain
echo "<VirtualHost *:80>
        ServerAdmin lrea@nekls.org
        DocumentRoot /home/$town/public_html
        ServerName $town.mykansaslibrary.org
        ServerAlias $wwwdomain
        ServerAlias $domain
        ErrorLog /var/log/apache2/$town.mykansaslibrary.org_error
        CustomLog /var/log/apache2/$town.mykansaslibrary.org_access common
        AssignUserID $town $town
<Directory /home/$town/public_html>  
        DirectoryIndex index.php
        <IfModule mod_rewrite.c>
                RewriteEngine On
                RewriteBase /
                RewriteCond %{REQUEST_FILENAME} !-f
                RewriteCond %{REQUEST_FILENAME} !-d
                RewriteRule . /index.php [L]
        </IfModule>
</Directory>
</VirtualHost>" > /etc/apache2/sites-available/$town
fi
echo "Done creating config, now to activate it..."
a2ensite $town
/etc/init.d/apache2 reload
echo "STOP. Go and do the DNS."
read go
if test X"$wwwdomain" = X"1"; then
	lynx $town.mykansaslibrary.org
	echo "Generating and Installing DB options for new site..."
	echo "update wp_options set option_value='http://$town.mykansaslibrary.org' where option_name='siteurl';update wp_options set option_value='http://$town.mykansaslibrary.org' where option_name='home';update wp_options set option_value='My Library Site' where option_name='blogname';update wp_options set option_value='Information to Change the World' where option_name='blogdescription';update wp_options set option_value='0' where option_name='uploads_use_yearmonth_folders';update wp_options set option_value='4' where option_name='default_category';INSERT INTO wp_options VALUES (200,0,'wordpress_api_key','f9a25142ef64','yes');INSERT into wp_options VALUES (201,0,'akismet_discard_month','true','yes');update wp_options set option_value='/%postname%/' where option_name='permalink_structure';" >sethome.dat
	echo "This account has been created at http://$town.mykansaslibrary.org.

You can log in at http://$town.mykansaslibrary.org/wp-admin with the following credentials :

username: librarian
password: xxxxxxx

For the latest KLOW developments please visit http://www.mykansaslibrary.org or add http://www.mykansaslibrary.org/feed/  to your RSS reader.

Have fun with your new site!

$admin_name
KLOW Administrator" > /home/cftuser/scripts/email_template.txt
else
	lynx $wwwdomain
	echo "Generating and installing DB Options for new site..."
	echo "update wp_options set option_value='http://$wwwdomain' where option_name='siteurl';update wp_options set option_value='$wwwdomain' where option_name='home';update wp_options set option_value='My Library Site' where option_name='blogname';update wp_options set option_value='Information to Change the World' where option_name='blogdescription';update wp_options set option_value='0' where option_name='uploads_use_yearmonth_folders';update wp_options set option_value='4' where option_name='default_category';INSERT INTO wp_options VALUES (200,0,'wordpress_api_key','f9a25142ef64','yes');INSERT into wp_options VALUES (201,0,'akismet_discard_month','true','yes');update wp_options set option_value='/%postname%/' where option_name='permalink_structure';" >sethome.dat
	echo "This account has been created at http://$wwwdomain.

You can log in at http://$wwwdomain/wp-admin with the following credentials :

username: librarian
password: xxxxxxx

For the latest KLOW developments please visit http://www.mykansaslibrary.org or add http://www.mykansaslibrary.org/feed/  to your RSS reader.

Have fun with your new site!

$admin_name
KLOW Administrator" > /home/cftuser/scripts/email_template.txt
fi
mysql -u$mysql_user -p$mysql_pass $town <users.sql
mysql -u$mysql_user -p$mysql_pass $town <usermeta.sql
mysql -u$mysql_user -p$mysql_pass $town <terms.sql
mysql -u$mysql_user -p$mysql_pass $town <termtaxonomy.sql
mysql -u$mysql_user -p$mysql_pass $town <links.sql
mysql -u$mysql_user -p$mysql_pass $town <sethome.dat
echo "All Done installing values."
echo "Sending email... Please enter director's email address:"
read directoremail
echo "Please enter trainer email"
read traineremail
mutt -s "New KLOW Site for $town" $directoremail, $traineremail, $admin_email < /home/cftuser/scripts/email_template.txt
echo "Mail sent! Please double check the site, log in, and activate the plugins."

