#!/bin/bash

set -e

mysqladmin -uroot -p drop koha_rmaint

mysqladmin -uroot -p create koha_rmaint

zcat /home/liz/rmaint-3.18/rmaint-2015.sql.gz | sudo koha-mysql rmaint 

sudo koha-rebuild-zebra --full -v -v rmaint

