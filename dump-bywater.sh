#!/bin/bash
DATE=$(date)
DUMPDATE=$(date +%F)
mysql_user=reporter
mysql_pass=xxxxxxx
mysql_port=3306
hostname=reports.nexpresslibrary.org
kohadb=koha_nekls
savepath=/home/liz/dbdumps

echo "Dumping Database started at $DATE" > message.txt
mysqldump -u$mysql_user -p$mysql_pass -h$hostname -P$mysql_port $kohadb --ignore-table="$kohadb".sessions --ignore-table="$kohadb".zebraqueue --ignore-table="$kohadb".message_queue --ignore-table="$kohadb".action_logs --skip-lock-tables > bywater-production-"$DUMPDATE".sql
DATE=$(date)
echo "Zipping Database started at $DATE" >> message.txt
gzip "$savepath"/bywater-production-"$DUMPDATE".sql

