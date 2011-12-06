#!/bin/bash

savepath=~/briefbibs
incoming_files=~/txt
 
for f in `ls $incoming_files` # look at each file in a specific directory
do

cat $f | while read $biblionumber # grab each carriage return separated biblionumber, and fetch the marc record.
	do
		wget -O "$savepath"/"$biblionumber".mrc 'http://catalog.nexpresslibrary.org/cgi-bin/koha/opac-export.pl?format=utf8&op=export&save=Go&bibnumber='$biblionumber
		cat "$savepath"/"$biblionumber".mrc >> $biblionumber'-all.mrc' #appends all of the marc files to one file
	done
done
