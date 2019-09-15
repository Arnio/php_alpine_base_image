cp /var/www/html/thunder/sites/default/default.settings.php /var/www/html/thunder/sites/default/settings.php
chmod 755 /var/www/html/thunder/sites
chmod 755 /var/www/html/thunder/sites/default
chmod 755 /var/www/html/thunder/sites/default/files
chmod a+w /var/www/html/thunder/sites/default/settings.php
cd /var/www/html/thunder/ && vendor/bin/drush -y si standard --db-url=mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}/${MYSQL_DATABASE} --site-name=SiteName --account-name=admin --account-pass=admin
chmod 444 /var/www/html/thunder/sites/default/settings.php