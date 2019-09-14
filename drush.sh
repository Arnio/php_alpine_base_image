cd /var/www/html/thunder/
composer require drush/drush:9.*
composer update
cp sites/default/default.settings.php sites/default/settings.php
chmod a+w sites/default/settings.php
chmod a+w sites/default
vendor/bin/drush -y site:install standard --db-url=mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}/${MYSQL_DATABASE} --site-name=Example --account-name=admin --account-pass=admin
