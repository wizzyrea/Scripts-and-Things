#!/bin/bash 
confpath=/home/liz/koha-dev/etc
kohapath=/home/liz/kohaclone
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
	  "usage: $0 [-v] [-m o || t] o is original config, t is testing config."
	  exit 1;;
    esac
done
shift `expr $OPTIND - 1`

if [ $mode = o ]
then
	echo "copying in original config"
	cp -f $confpath/koha-conf.orig $confpath/koha-conf.xml
elif [ $mode = t ]
then
		echo "copying in test config" 
		cp -f $confpath/koha-conf.test $confpath/koha-conf.xml
else
	echo "please specify -m o for original configuration or -m t for testing configuration"
fi
echo "reindexing on the new DB..."

perl $kohapath/misc/migration_tools/rebuild_zebra.pl -b -r -v
