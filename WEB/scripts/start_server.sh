#! /bin/bash
cd /var/www/html
curl -sS https://getcomposer.org/installer | php
php composer.phar require aws/aws-sdk-php

chown ubuntu:ubuntu /var/www/html

sed -i 's/;date.timezone =/date.timezone = Asia\/Seoul/g' /etc/php/7.2/apache2/php.ini
sed -i 's/;date.timezone =/date.timezone = Asia\/Seoul/g' /etc/php/7.2/cli/php.ini
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/7.2/apache2/php.ini
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/7.2/cli/php.ini

sed -i -e "173 i\\\tDirectoryIndex index.php" /etc/apache2/apache2.conf

sudo service apache2 restart
