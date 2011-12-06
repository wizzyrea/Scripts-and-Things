#!/bin/bash
#this script takes in a town name and sends a message saying "site's done, have fun". 

admin_name="Liz Rea" #admin never changes
admin_email=lrea@nekls.org #neither does their email addy, hopefully.

echo "enter town name"
read town
echo "Sending email... Please enter director's email address:"
read directoremail
echo "Please enter trainer email"
read traineremail

echo "This account has been created at http://$town.mykansaslibrary.org.

You can log in at http://$town.mykansaslibrary.org/wp-admin with the following credentials :

username: librarian
password: iluvklow

For the latest KLOW developments please visit http://www.mykansaslibrary.org or add http://www.mykansaslibrary.org/feed/  to your RSS reader.

Have fun with your new site!

$admin_name
KLOW Administrator" > /home/cftuser/scripts/email_template.txt
mutt -s "New KLOW Site for $town" $directoremail, $traineremail, $admin_email < /home/cftuser/scripts/email_template.txt
echo "Mail sent!"



