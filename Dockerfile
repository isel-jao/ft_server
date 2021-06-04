FROM debian:buster
WORKDIR /content
RUN apt-get update -y && apt-get upgrade -y 
RUN apt-get install vim wget -y 
RUN apt-get install nginx -y
RUN apt-get install mariadb-server mariadb-client -y
RUN apt-get install -y php-mbstring php-zip php-gd php-xml \
php-pear php-gettext php-cli php-fpm php-cgi php-mysql -y
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-english.tar.gz 
RUN wget https://wordpress.org/latest.tar.gz 
RUN tar xzf phpMyAdmin-4.9.7-english.tar.gz
RUN mv phpMyAdmin-4.9.7-english /var/www/html/phpmyadmin
RUN rm /var/www/html/phpmyadmin/config.sample.inc.php
COPY /srcs/default /etc/nginx/sites-available/default
COPY /srcs/config.inc.php /var/www/html/phpmyadmin
RUN tar xzf latest.tar.gz && mv wordpress /var/www/html/
RUN rm /var/www/html/wordpress/wp-config-sample.php
COPY /srcs/wp-config.php /var/www/html/wordpress
COPY /srcs/self-signed.conf /etc/nginx/snippets/
COPY /srcs/ssl-params.conf /etc/nginx/snippets/
EXPOSE 80 443
COPY /srcs/localhost.sql /content
COPY /srcs/config.sh /content
COPY /srcs/start.sh /content
COPY /srcs/index.sh /content
RUN sh config.sh
CMD sh start.sh