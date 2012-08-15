#!/bin/bash
MONTH=$(date +%B)
HOMEDIR=/home/user
DBUSER=username
DBPASS=password
HOST=hostname
DBNAME=database
SENDTO='user1@org.com, user2@org.com'

cat libraries | while read TOWN
do
	echo "Statistics for $TOWN"
	echo "Statistics for $TOWN" >> "$HOMEDIR"/"$MONTH"_Reports.csv
	echo "Circs by Item Type" >> "$HOMEDIR"/"$MONTH"_Reports.csv
	echo "Includes checkouts, renews, and local use circulations" >> "$HOMEDIR"/"$MONTH"_Reports.csv
	mysql -u$DBUSER -p$DBPASS -h$HOST -P3306 $DBNAME -e "SELECT items.itype, items.location, count(*) FROM statistics LEFT JOIN items on (items.itemnumber = statistics.itemnumber) LEFT JOIN biblioitems on (biblioitems.biblioitemnumber = items.biblioitemnumber) WHERE statistics.type IN ('issue', 'renew', 'localuse') AND  datetime >= concat(date_format(LAST_DAY(now() - interval 1 month),'%Y-%m-'),'01') AND datetime <= LAST_DAY(now() - interval 1 month) AND statistics.branch = '$TOWN' group by items.itype, items.location ORDER BY items.itype, items.location" >> "$HOMEDIR"/"$MONTH"_Reports.csv	
	echo "-------" >> "$HOMEDIR"/"$MONTH"_Reports.csv
	echo "-------" >> "$HOMEDIR"/"$MONTH"_Reports.csv
	echo "Circs by Collection Code" >> "$HOMEDIR"/"$MONTH"_Reports.csv
	mysql -u$DBUSER -p$DBPASS -h$HOST -P3306 $DBNAME -e "SELECT items.ccode, items.location, count(*) FROM statistics LEFT JOIN items on (items.itemnumber = statistics.itemnumber) LEFT JOIN biblioitems on (biblioitems.biblioitemnumber = items.biblioitemnumber) WHERE statistics.type IN ('issue', 'renew', 'localuse') AND  datetime >= concat(date_format(LAST_DAY(now() - interval 1 month),'%Y-%m-'),'01') AND datetime <= LAST_DAY(now() - interval 1 month) AND statistics.branch = '$TOWN' group by items.ccode, items.location ORDER BY items.ccode, items.location" >> "$HOMEDIR"/"$MONTH"_Reports.csv
	echo "-------" >> "$HOMEDIR"/"$MONTH"_Reports.csv
	echo "-------" >> "$HOMEDIR"/"$MONTH"_Reports.csv
	echo "-------" >> "$HOMEDIR"/"$MONTH"_Reports.csv
done
mutt -s "Koha Reports" "$SENDTO" -a "$HOMEDIR"/"$MONTH"_Reports.csv < "$HOMEDIR"/email_template.txt
rm "$HOMEDIR"/"$MONTH"_Reports.csv
echo "Emailed and removed."
