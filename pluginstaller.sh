#!/bin/bash
#this script could be used to update all virtualhosts with plugins

echo "Adding Plugin"
for f in `ls /home`
do
echo "Adding plugin for $f"
cp -r /home/cftuser/plugins/* /home/$f/public_html/wp-content/plugins/
chown -R $f:$f /home/$f/public_html/wp-content/plugins

echo "you can cancel now with ctrl-c for testing, or press any key to do one more."
read goahead
done
