cp /var/www/html/thunder/sites/default/default.settings.php /var/www/html/thunder/sites/default/settings.php
chmod a+w /var/www/html/thunder/sites/default/settings.php
cd /var/www/html/thunder/ && composer require drush/drush:master && vendor/bin/drush -y si standard --db-url=mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}/${MYSQL_DATABASE} --site-name=SiteName --account-name=admin --account-pass=admin
chown -R nginx:nginx /var/www/html/thunder/sites/default