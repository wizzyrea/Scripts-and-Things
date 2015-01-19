#!/bin/bash
sudo koha-list --enabled
read instance

DUMPDATE=$(date +%F)
sudo koha-dump $instance
sudo cp /var/spool/koha/$instance/$instance-$DUMPDATE.sql.gz /home/liz/
sudo chown liz:liz /home/liz/$instance-$DUMPDATE.sql.gz

