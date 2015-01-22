#!/bin/bash
sudo koha-list --enabled
echo "Dump styling preferences for which instance?"
read instance
echo "select variable, value from systempreferences where variable in ('intranetuserjs','IntranetUserCss','opaccolorstylesheet','OpacCustomSearch','opaccolorstylesheet','opaccredits','OpacMainUserBlock','opacheader','OpacKohaUrl','OpacNav','OpacNavBottom','OPACNoResultsFound','OpacPublic','OPACUserCSS','opacuserjs','OPACXSLTDetailsDisplay')" | sudo koha-mysql $instance > $instance-style-preferences.sql
echo "select variable, value from systempreferences" | sudo koha-mysql $instance > $instance-all-preferences.sql
