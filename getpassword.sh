sudo koha-list --enabled
echo "Which site?"
read site

sudo xmlstarlet sel -t -v 'yazgfs/config/pass' /etc/koha/sites/$site/koha-conf.xml

echo "\nPress any key to clear the screen..."
read waitforme
clear
