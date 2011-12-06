echo "Adding Plugin"
for f in `ls`
do
cp /home/cftuser/pluginstoadd/* /home/$f/public_html/wp-content/plugins/
chown -R $f:$f /home/$f/public_html/wp-content/plugins
echo "you can cancel now with ctrl-c for testing, or press any key to do one more."
read goahead
done
