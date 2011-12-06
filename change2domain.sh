#!/bin/bash

mysql_user=reporter
mysql_pass=xxxxxxx

echo "This script will change a *.mykansaslibrary.org site to a www.*.* site in the Wordpress config, and change the Apache config for that site accordingly. Ctrl-C if you mess up at any point."
echo "Enter town/site name. This is usually the bit before .mykansaslibrary.org. If you are unsure, do not use this tool and do the process manually."
read town
echo "Enter new domain (no www. Example: kearnycolibrary.info):"
read $domain
echo "Updating the WP database..."
mysql -u$mysql_user -p$mysql_pass $town -e "update wp_options set option_value='http://www.$domain' where option_name='siteurl'"
mysql -u$mysql_user -p$mysql_pass $town -e "update wp_options set option_value='http://www.$domain' where option_name='home'"
echo "Adding new ServerAliases..."
sed -i '5iServerAlias www.$domain' /etc/apache2/sites-available/$town
sed -i '6iServerAlias $domain' /etc/apache2/sites-available/$town
echo "Restarting Apache..."
apache2ctl restart
echo "Done"
