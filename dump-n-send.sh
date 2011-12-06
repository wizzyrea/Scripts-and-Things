#!/bin/bash
DATE=$(date)
DUMPDATE=$(date +%F)
mysql_user=neklsreports
mysql_pass=xxxxxxx
mysql_port=3306
hostname=heh.ec2.liblime.com
kohadb=koha_nekls
savepath=/home/liz/dbdumps/
sftpuser=nekls
sftppass=xxxxxxxx
sftphost=67.23.29.188
recipients=nexpresshelp@nekls.org


echo "Dumping Database started at $DATE" > message.txt
mysqldump  -u$mysql_user -p$mysql_pass -h$hostname -P$mysql_port $kohadb --ignore-table=koha_nekls.sessions --ignore-table=koha_nekls.zebraqueue --ignore-table=koha_nekls.message_queue --ignore-table=koha_nekls.action_logs --skip-lock-tables > harleydb-production-"$DUMPDATE".sql 
DATE=$(date)
echo "Zipping Database started at $DATE" >>message.txt
gzip $savepath/harleydb-production-"$DUMPDATE".sql
DATE=$(date)
echo "FTP commenced at $DATE" >>message.txt
lftp -u nekls,N3KLS sftp://$sftphost <<EOF
put $savepath/harleydb-production-"$DUMPDATE".sql.gz
bye
EOF
DATE=$(date)

echo "DB Dump and upload completed on $DATE. Name of file placed on SFTP server is harleydb-production"$DUMPDATE"" >> message.txt

mutt -s "DB Dump Completed" $recipients < message.txt
mysqldump -u$mysql_user -p$mysql_pass -h$hostname -p$mysql_host $kohadb --table=action_logs > production_actionlogs"$DUMPDATE".sql
