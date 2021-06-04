########################################## mysql ###################################################
service mysql start

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'admin'@'localhost' IDENTIFIED BY 'admin';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' IDENTIFIED BY 'admin';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
mysql -u root < /content/localhost.sql

##################################permession and ownership#########################################
chmod 660 /var/www/html/phpmyadmin/config.inc.php
chown -R www-data:www-data /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/phpmyadmin

####################################### ssl configuration##########################################
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/CN=MA'
openssl dhparam -out /etc/nginx/dhparam.pem 64

############################# autoindex ############################
echo "alias index='bash /content/index.sh'" >> /root/.bashrc