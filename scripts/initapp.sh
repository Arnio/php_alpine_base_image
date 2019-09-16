apk add -y mqsql-client
for i in $(ls -d /var/www/html/thunder/sites/ ); do
	FileName=$(find $i -type f)
	if [ ! -z $FileName ]; then
      		echo -e "Folder" "$i" "has some file(s) failed to be processed" "\n"
	else
        	echo -e "Folder" "$i" "is empty" "\n"
            mv /tmp/sites /var/www/html/thunder/sites
            chmod a+w /var/www/html/thunder/sites/
            cd /var/www/html/thunder/ && composer require drush/drush:master && vendor/bin/drush -y si standard --db-url=mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}/${MYSQL_DATABASE} --site-name=SiteName --account-name=admin --account-pass=admin
            chown -R nginx:nginx /var/www/html/thunder/sites/            
	fi
done

