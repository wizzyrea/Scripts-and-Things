<?php

// Pulling new changes
chdir('/home/koha-community/public_html/wp-content/uploads/kohadocs/');
exec('git pull origin manual3.2.x');
chdir('en');

//Transforming xml to html (need docbook-utils)
exec('docbook2html manual.xml');


//Copying files to new dirctory from which wp_include will pull the docs
exec('mv /home/koha-community/public_html/wp-content/uploads/kohadocs/en/*.html /home/koha-community/public_html/wp-content/uploads/kohadocs/');
exec('cp -R  images /home/koha-community/public_html/wp-content/uploads/kohadocs');
exec('chown -R koha-community:koha-community /home/koha-community/public_html/wp-content/uploads/kohadocs/*');
exec('chmod -R 750 /home/koha-community/public_html/wp-content/uploads/kohadocs/*');

//Fixing urls
chdir('/home/koha-community/public_html/wp-content/uploads/kohadocs');

$myDirectory = opendir(".");
while($entryName = readdir($myDirectory)) {
        $dirArray[] = $entryName;
        echo $entryName." \n";
}
foreach ($dirArray as $docfile)  {
        if (end(explode(".", $docfile))=='html') {
            echo $docfile." \n";
            $pattern= "/\"(.*)\.html(.*)\"/";
//          $replacement= "?ch=\1\2"    
//          $pattern= "/\"^[acx0-9]+\.html(.*)\"/"; //with advanced url detection
//            echo $pattern." \n";
            $docu=file_get_contents($docfile);
            $docu = str_replace("=\n", '=', $docu);
//This part should be changed to reflect the id of Documentation root page (page_id=3 in my case)
//              $docu = preg_replace($pattern, $replacement, $docu);
                        $docu = preg_replace($pattern, '"\1\2"', $docu);
                        $docu = str_replace("images/", "http://koha-community.org/wp-content/uploads/kohadocs/images/", $docu);
                        $docu = str_replace("../http", "http", $docu);
            $fh = fopen($docfile, 'w') or die("Can't open file");
            fwrite($fh, $docu);
            fclose($fh);
        }
}
?>


