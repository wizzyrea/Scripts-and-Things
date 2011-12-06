#!/bin/bash
cp -n /var/spool/koha/lecompton/* /home/kohauser/remote-backup/lecompton
find /home/kohauser/remote-backup/lecompton -name "*.gz" -mtime +8 -exec rm -f {} \;
find /home/kohauser/remote-backup/fileserver -name "*.bak" -mtime +5 -exec rm -f {} \;

