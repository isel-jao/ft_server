######################################## start services ###########################################
service mysql start
service php7.3-fpm start
service nginx start

var=""
while [ 1 ];
do
	read var
	if [ "$var" = "on" ]; then
		echo -e "\e[32mAutoindex is actived\e[39m"
		sed -i 's/index i/#index i/' /etc/nginx/sites-enabled/default
		sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-enabled/default
		service nginx restart
		echo  ""
	fi
	if [ "$var" = "off" ]; then
		sed -i 's/#index i/index i/' /etc/nginx/sites-enabled/default
		echo -e "\e[31mAutoindex is inactivated\e[39m"
		sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-enabled/default
		service nginx restart
		echo ""
	fi
	if [ "$var" = "exit" ]; then
		break;
	fi
done


