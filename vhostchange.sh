#!/bin/bash
# this script updates all virtualhosts to have the indicated additions.

for f in `ls`
do
  echo "Processing vhost $f..."
  # take action on each file. $f store current file name
  # grep finds string, removes it
STR1=$(grep -Ev '</VirtualHost>' $f);
STR2="
	AssignUserID $f $f
<Directory /home/$f/public_html>
	DirectoryIndex index.php
	<IfModule mod_rewrite.c>
		RewriteEngine On
		RewriteBase /
		RewriteCond %{REQUEST_FILENAME} !-f
		RewriteCond %{REQUEST_FILENAME} !-d
		RewriteRule . /index.php [L]
	</IfModule>
</Directory>
</VirtualHost>"

OUT="$STR1$STR2"
mv $f /home/cftuser/vhostbackup/$f.old  
echo "$OUT">$f
done
