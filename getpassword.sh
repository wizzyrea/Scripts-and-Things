gpg -d ~/password.txt.gpg
ls /etc/koha/sites
echo "Which site?"
read site

sudo xmlstarlet sel -t -v 'yazgfs/config/pass' /etc/koha/sites/$site/koha-conf.xml

echo "Press any key to clear the screen..."
read waitforme
clear
