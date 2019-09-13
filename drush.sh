composer global require drush/drush:9.*
export PATH="$HOME/.composer/vendor/bin:$PATH"
composer global update
cd /var/www/html/thunder-8.x-2.44/
cp sites/default/default.settings.php sites/default/settings.php
chmod a+w sites/default/settings.php
chmod a+w sites/default
drush -y site:install standard --db-url=mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}/${MYSQL_DATABASE} --site-name=Example --account-name=admin --account-pass=admin