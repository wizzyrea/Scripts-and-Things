#!/bin/bash 
confpath=/home/koha/koha-dev/etc
kohapath=/home/koha/kohaclone
export KOHA_CONF=$confpath/koha-conf.xml
export PERL5LIB=$kohapath

echo $confpath

vflag=off

while getopts vm: opt
do
    case "$opt" in
      v)  vflag=on;;
      m)  mode="$OPTARG";;
      \?)		# unknown flag
      	  echo >&2 \
	  "usage: $0 [-v] [-m o || t] 36 is 3.6, 38 is 3.8."
	  exit 1;;
    esac
done
shift `expr $OPTIND - 1`

if [ $mode = 36 ]
then
	echo "copying in 3.6 config"
	cp -f $confpath/koha-conf.36 $confpath/koha-conf.xml
	git checkout 3.6.x
elif [ $mode = 38 ]
then
	echo "copying in 3.8 config" 
	cp -f $confpath/koha-conf.38 $confpath/koha-conf.xml
	git checkout 3.8.x
else
	echo "please specify -m 36 for 3.6 configuration or -m 38 for 3.8 configuration"
fi
echo "reindexing on the new DB..."

perl $kohapath/misc/migration_tools/rebuild_zebra.pl -b -r -v
echo "System configured for version $mode"
