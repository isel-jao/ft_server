#!/bin/bash

case $1 in
	"on")
		echo -e "\e[32mAutoindex is actived\e[39m"
		sed -i 's/index i/#index i/' /etc/nginx/sites-enabled/default
		sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-enabled/default
		service nginx restart
		echo  ""
		;;
	"off")
		sed -i 's/#index i/index i/' /etc/nginx/sites-enabled/default
		echo -e "\e[31mAutoindex is inactivated\e[39m"
		sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-enabled/default
		service nginx restart
		echo ""
		;;
	*)
		echo -e "\e[31mError this value does not exist in the index"
		echo -n -e "\e[32mautoindex is : "
		echo | grep '\(autoindex on\|autoindex off\)' /etc/nginx/sites-enabled/default | cut -c13-
		echo -e "\e[39m"
		;;
esac