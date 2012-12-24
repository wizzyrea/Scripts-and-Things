#!/bin/bash

echo "commit ID?"
read commitid
git cherry-pick -s $commitid

OUT=$?

if [ "$OUT" -ge 1 ] ; then
    echo "Already applied, or won't apply. Resetting to HEAD"
    git reset --hard HEAD
else
    echo "Woo Hoo! It applies! Running tests"
    prove t xt
fi
