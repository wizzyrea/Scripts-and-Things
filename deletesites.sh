#!/bin/bash
apachedir = /etc/apache2/sites-available
backupdir = /home/cftuser/backups/sckls
dbuser = root
dbpass = 



cat sckls | while read TOWN
do
# back up the site db
	mysqldump -u$dbuser -p$dbpass $TOWN > $backupdir/$TOWN.sql
# back up the site filesystem
	tar -cvf $backupdir/$TOWN.gz /home/$TOWN
# back up the virtualhost
	cp $apachedir/$TOWN $backupdir/$TOWN.apache
# delete the db
	mysqladmin -u$dbuser -p$dbpass drop $TOWN
# delete the mysql user
	mysql -u$dbuser -p$dbpass -e "DROP USER $TOWN"
# delete the Unix user
	userdel -r $TOWN
# delete the virtualhost
	rm $apachedir/$TOWN
done

# restart apache
apache2ctl restart

