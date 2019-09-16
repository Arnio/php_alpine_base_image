apk add mqsql-client
filecount=$(ls -At1 /var/www/html/thunder/sites/default/* 2>&- | wc -l)
if [ $filecount -gt 3 ]; then
        echo -e "The folder has $filecount some file(s) failed to be processed" "\n"
else
        echo -e "The folder has $filecount some file(s)" "\n"
        mv /tmp/settings/*.* /var/www/html/thunder/sites/default/
        chmod a+w -R /var/www/html/thunder/sites/default
        cd /var/www/html/thunder/ && composer require drush/drush:master && vendor/bin/drush -y si standard --db-url=mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}/${MYSQL_DATABASE} --site-name=SiteName --account-name=admin --account-pass=admin
        chown -R nginx:nginx /var/www/html/thunder/sites/            
fi


