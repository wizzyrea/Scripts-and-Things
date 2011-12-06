#!/bin/bash
cd /home/koha-community/public_html/wp-content/uploads/kohadocs/en/ #set the working directory
docbook2html -u /home/koha-community/public_html/wp-content/uploads/kohadocs/en/manual.xml #convert the docbook to monolith html
tidy manual.html > tidymanual.html # tidy that output
awk 'NR==13{print "<div id=\"footerContent\"> page <pdf:pagenumber> </div>"}1' tidymanual.html >koha3-2manual-en.html # Add the page numbers to the manual for the PDF
xhtml2pdf --css manual.css --encoding utf8 koha3-2manual-en.html # Turn that HTML into PDF
rm /home/koha-community/public_html/wp-content/uploads/kohadocs/en/tidymanual.html # remove all of my working files. I'm sure this could be done with input redirection. Maybe someday.
rm /home/koha-community/public_html/wp-content/uploads/kohadocs/en/manual.html
rm /home/koha-community/public_html/wp-content/uploads/kohadocs/en/koha3-2manual-en.html
chown koha-community:koha-community koha3-2manual-en.pdf # set permissions on the file
chmod 640 koha3-2manual-en.pdf

# This was to be the bits for doing the other languages. Kind of dumb, could just use a function and some variables. Live and learn I guess. 
#cd /home/koha-community/public_html/wp-content/uploads/kohadocs/fr/
#docbook2html -u /home/koha-community/public_html/wp-content/uploads/kohadocs/fr/koha3-2manual.xml
#tidy koha3-2manual.html > tidymanual.html
#awk 'NR==13{print "<div id=\"footerContent\"> page <pdf:pagenumber> </div>"}1' tidymanual.html > koha3-2manual-fr.html
#xhtml2pdf --css manual.css --encoding utf8 koha3-2manual-fr.html
#rm /home/koha-community/public_html/wp-content/uploads/kohadocs/fr/tidymanual.html
#rm /home/koha-community/public_html/wp-content/uploads/kohadocs/fr/koha3-2manual.html
#rm /home/koha-community/public_html/wp-content/uploads/kohadocs/fr/koha3-2manual-fr.html
#chown koha-community:koha-community koha3-2manual-fr.pdf
#chmod 640 koha3-2manual-fr.pdf

#cd /home/koha-community/public_html/wp-content/uploads/kohadocs/es/
#docbook2html -u /home/koha-community/public_html/wp-content/uploads/kohadocs/es/koha3-2manual.xml
#tidy koha3-2manual.html > tidymanual.html
#awk 'NR==13{print "<div id=\"footerContent\"> page <pdf:pagenumber> </div>"}1' tidymanual.html > koha3-2manual-es.html
#xhtml2pdf --css manual.css --encoding utf8 koha3-2manual-es.html
#rm /home/koha-community/public_html/wp-content/uploads/kohadocs/es/tidymanual.html
#rm /home/koha-community/public_html/wp-content/uploads/kohadocs/es/koha3-2manual.html
#rm /home/koha-community/public_html/wp-content/uploads/kohadocs/es/koha3-2manual-es.html
#chown koha-community:koha-community koha3-2manual-es.pdf
#chmod 640 koha3-2manual-es.pdf

