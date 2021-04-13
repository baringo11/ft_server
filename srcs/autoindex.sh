#! /bin/bash

if [ "$1" == "on" ];
then
{
    sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-available/web-conf
    sed -i ' 19 s/index.nginx-debian.html;/;#index.nginx-debian.html/' /etc/nginx/sites-available/web-conf
}
elif [ "$1" == "off" ];
then
{
    sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-available/web-conf
    sed -i ' 19 s/;#index.nginx-debian.html/index.nginx-debian.html;/' /etc/nginx/sites-available/web-conf
}
fi

service nginx restart

#bash