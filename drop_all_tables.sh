#! /bin/bash
#---------------------------------
# Copyright 2010 ByWater Solutions
# Copyright 2015 Catalyst IT
# Copyright 2015 Liz Rea (wizzyrea@gmail.com)
#---------------------------------
#
# This script will drop all tables from a Koha MySQL database. 
# Running this script without --confirm will ask for confirmation from stdin.
#
# USE WITH EXTREME CAUTION!
#


set -e

umask 0077

# include helper functions
if [ -f "/usr/share/koha/bin/koha-functions.sh" ]; then
    . "/usr/share/koha/bin/koha-functions.sh"
else
    echo "Error: /usr/share/koha/bin/koha-functions.sh not present." 1>&2
    exit 1
fi

[ $# -le 2 ]  || die "Usage: $0 instancename --confirm"
name="$1"
confirm="$2"
kohaconfig="/etc/koha/sites/$name/koha-conf.xml"

mysqlhost="$( xmlstarlet sel -t -v 'yazgfs/config/hostname' $kohaconfig )"
mysqldb="$( xmlstarlet sel -t -v 'yazgfs/config/database' $kohaconfig )"
mysqluser="$( xmlstarlet sel -t -v 'yazgfs/config/user' $kohaconfig )"
mysqlpass="$( xmlstarlet sel -t -v 'yazgfs/config/pass' $kohaconfig )"

if [ -t 1 ]; then 
    echo -e "WARNING WARNING WARNING - this script will delete all tables in a Koha database - WARNING WARNING WARNING \nAre you sure you want to continue? Type YES to continue."
    read doit
fi

if test X"$doit" = X"YES" || test X"$confirm" = X"--confirm"; then
# echo -e "we will drop the db now, remove after testing, ctrl c here"
# read go
    echo "Dropping database for $name... \n"
    MYSQL="mysql -u$mysqluser -h$mysqlhost -p$mysqlpass $mysqldb"
    $MYSQL -BNe "show tables" |awk '{print "set foreign_key_checks=0; drop table `" $1 "`;"}' | $MYSQL
    unset MYSQL
else
    echo "Database clear cancelled."
fi

