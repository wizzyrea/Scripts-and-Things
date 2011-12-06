echo "This script installs the DB values necessary for a new KLOW install of 2.9"
mysql_user=xxxxxxx
mysql_pass=xxxxxxx
echo "Which site?"
read town

mysql -u$mysql_user -p$mysql_pass $town $town <users.sql
mysql -u$mysql_user -p$mysql_pass $town $town <usermeta.sql
mysql -u$mysql_user -p$mysql_pass $town $town <options.sql
mysql -u$mysql_user -p$mysql_pass $town $town <terms.sql
mysql -u$mysql_user -p$mysql_pass $town $town <termtaxonomy.sql
mysql -u$mysql_user -p$mysql_pass $town $town <links.sql
mysql -u$mysql_user -p$mysql_pass $town$town <sethome.dat
