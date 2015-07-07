#!/bin/bash

if [ $1 ] ; then
    commitid=$1
else
    echo "commit ID?"
    read commitid
fi
git cherry-pick -s $commitid

OUT=$?

if [ "$OUT" -ge 1 ] ; then
    echo "Already applied, or won't apply. Resetting to HEAD"
    git reset --hard HEAD
else
    echo "Woo Hoo! It applies! Running tests"
    sudo koha-shell rmaint --command "prove t xt"
    koha-qa.pl -v 1 -c 2
fi
