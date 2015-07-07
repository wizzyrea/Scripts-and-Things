#!/bin/bash

DUMPDATE=$(date +%F)

sudo koha-list --enabled
echo "Which instance?"
read instance

sudo koha-dump $instance
sudo cp /var/spool/koha/$instance/$instance-$DUMPDATE.sql.gz /usr/share/mykoha/$instance.sql.gz

