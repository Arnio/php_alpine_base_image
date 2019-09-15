cd /var/www/html/thunder/
composer global require drush/drush:9.*
composer update --dry-run
cp sites/default/default.settings.php sites/default/settings.php
chmod a+w sites/default/settings.php
chmod a+w sites/default
vendor/bin/drush -y si standard --db-url=mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}/${MYSQL_DATABASE} --site-name=Example --account-name=admin --account-pass=admin
