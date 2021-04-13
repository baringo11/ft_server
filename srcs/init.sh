#!/bin/bash

#chown -R www-data /var/www/*
chmod -R 775 /var/www/*
chmod 775 autoindex.sh

mkdir /var/www/mywebsite

# SSL
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
            -out etc/nginx/ssl/ssl_certificate.crt \
            -keyout etc/nginx/ssl/ssl_certificate_key.key \
            -subj "/C=ES/ST=Madrid/L=Madrid/O=42/CN=mywebsite"

# Conf MySQL
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# Conf NGINX
mv /tmp/web-conf /etc/nginx/sites-available/web-conf
ln -s /etc/nginx/sites-available/web-conf /etc/nginx/sites-enabled/web-conf
ln -s /var/www/html/index.nginx-debian.html /var/www/mywebsite/index.nginx-debian.html
rm /etc/nginx/sites-enabled/default

# Conf PHP
mkdir /var/www/mywebsite/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
tar -xzf phpMyAdmin-5.0.4-all-languages.tar.gz --strip-components=1 -C /var/www/mywebsite/phpmyadmin
mv /tmp/config.inc.php /var/www/mywebsite/phpmyadmin
rm phpMyAdmin-5.0.4-all-languages.tar.gz

# Conf Wordpress
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz -C /var/www/mywebsite
mv /tmp/wp-config.php /var/www/mywebsite/wordpress
rm latest.tar.gz

service php7.3-fpm start
service nginx start
bash