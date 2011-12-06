#!/bin/bash
# this script pulls top 5 most popular items for every library.

MONTH=$(date +%B)
mysql_user=reporter
mysql_pass=xxxxxxx
mysql_port=3306
hostname=reports.nexpresslibrary.org
kohadb=koha_nekls
cat libraries | while read TOWN
do
	echo "Top circ for $TOWN" >> "$MONTH"_Reports.csv
	mysql -u$mysql_user -p$mysql_pass -h$hostname -P$mysql_port $kohadb -e "SELECT CONCAT( '<a href=\"/cgi-bin/koha/cataloguing/additem.pl?biblionumber=',biblio.biblionumber,  '\">',items.barcode,'</a>' ) as 'Barcode',items.itemcallnumber,biblio.title,biblio.copyrightdate as'Copyright',items.dateaccessioned as'Accessioned',items.itype,items.issues,items.renewals,(IFNULL(items.issues,0)+IFNULL(items.renewals,0)) asTotal_Circ,items.datelastborrowed,items.itemlost,items.onloan,items.damaged,items.itemnotes FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on(biblioitems.biblionumber=biblio.biblionumber) WHERE items.ccode='NONFICTION' AND items.location='adult' AND items.itype='BOOK' AND items.holdingbranch='$TOWN' AND items.issues > '50' ORDER BY items.itemcallnumber" >> "$TOWN"_Reports.csv

done

