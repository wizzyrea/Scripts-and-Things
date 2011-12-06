#!/bin/bash -x
#creates all of the necessary users and sets their permissions, based on home directories.
for f in `ls`
do
adduser --system --group --no-create-home --force-badname $f
read go
chown -R $f:$f /home/$f 
chmod -R 750 /home/$f
done
