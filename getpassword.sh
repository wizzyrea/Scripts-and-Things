ls /etc/koha/sites
echo "Which site?"
read site

sudo xmlstarlet sel -t -v 'yazgfs/config/pass' /etc/koha/sites/$site/koha-conf.xml

