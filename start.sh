#!/bin/bash
if [ -f /var/www/html/thunder-8.x-2.44/sites/default/default.settings.php ]
then
cp /var/www/html/thunder-8.x-2.44/sites/default/default.settings.php /var/www/html/thunder-8.x-2.44/sites/default/settings.php
cat >> /var/www/html/thunder-8.x-2.44/sites/default/settings.php << EOF 
$databases['default']['default'] = array (
'database' => '${MYSQL_DATABASE}',
'username' => '${MYSQL_USER}',
'password' => '${MYSQL_PASSWORD}',
'prefix' => '',
'host' => '${HOSTNAME}',
'port' => '3306',
'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
'driver' => 'mysql',
);
EOF
fi
php-fpm7
nginx -g "daemon off;"

