#!/bin/bash
#this script makes virtualhost files for a given site/user.
server_admin=<email address>
echo "which town?"
read town
echo "Make VirtualHost file..."
echo "Enter any custom domain entries, start with www.domain.com. enter 1 for no custom domains:"
read wwwdomain
if test X"$wwwdomain" = X"1"; then
        echo "<VirtualHost *:80>
        ServerAdmin $server_admin
        DocumentRoot /home/$town/public_html
        ServerName $town.mykansaslibrary.org
        ErrorLog /var/log/apache2/$town.mykansaslibrary.org_error
        CustomLog /var/log/apache2/$town.mykansaslibrary.org_access common
</VirtualHost>" > /etc/apache2/sites-available/$town
else
        echo "Enter domain.com entry::"
        read domain
        echo "<VirtualHost *:80>
                ServerAdmin $server_admin
                DocumentRoot /home/$town/public_html
                ServerName $town.mykansaslibrary.org
                ServerAlias $wwwdomain
                ServerAlias $domain
                ErrorLog /var/log/apache2/$town.mykansaslibrary.org_error
                CustomLog /var/log/apache2/$town.mykansaslibrary.org_access common
</VirtualHost>" > /etc/apache2/sites-available/$town
fi
echo "Done creating config, now to activate it..."
a2ensite $town
/etc/init.d/apache2 reload
echo "done."
