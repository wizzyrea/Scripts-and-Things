#!/bin/bash 
#this script was used to generate unique salts for new KLOW sites. It is integrated into install_wp.sh.
echo "Which town?"
read town
dbpassword=$(uuidgen |cut -c -64)
echo "$dbpassword"
key1=$(uuidgen |cut -c -64)
echo "$key1"
key2=$(uuidgen |cut -c -64)
echo "$key2"
key3=$(uuidgen |cut -c -64)
echo "$key3"
key4=$(uuidgen |cut -c -64)
echo "$key4"
echo "<?php
define('DB_NAME', '$town');
define('DB_USER', '$town');
define('DB_PASSWORD', '$dbpassword');
define('DB_HOST', 'localhost');
define('FS_METHOD', 'direct');
define('WP_TEMP_DIR', ABSPATH.'wp-content/uploads');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
define('AUTH_KEY', '$key1');
define('SECURE_AUTH_KEY', '$key2');
define('LOGGED_IN_KEY', '$key3');
define('NONCE_KEY', '$key4');
\$table_prefix  = 'wp_';
define ('WPLANG', '');
if ( !defined('ABSPATH') )
        define('ABSPATH', dirname(__FILE__) . '/');
require_once(ABSPATH . 'wp-settings.php');" >> /home/$town/wp_config.php
echo "done!"
