#!/bin/bash
# creates a backup of an EC2 volume.
ec2-create-snapshot vol-xxxxxxxxx -d backup_`date +%e-%m-%y`
