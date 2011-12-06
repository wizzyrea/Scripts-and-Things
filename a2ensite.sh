#!/bin/bash -x
#activate all virtualhosts in the home directory. 
for f in `ls /home/`
do
a2ensite $f
read
done
/etc/init.d/apache2 reload
