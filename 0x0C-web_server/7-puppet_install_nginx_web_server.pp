#!/usr/bin/env bash
# configures nginx server to give error 404 page

sudo apt-get update
sudo apt-get -y install nginx
sudo ufw allow 'Nginx HTTP'
sudo chmod -R 755 /var/www
echo 'Hello World' | sudo tee /var/www/html/index.html > /dev/null

new_config=\
"server {
        listen 80 default_server;
        listen [::]:80 default_server;
               root /var/www/html;
        index index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                try_files \$uri \$uri/ =404;
        }
        error_page 404 /404.html;
        location  /404.html {
            internal;
        }

        if (\$request_filename ~ redirect_me){
            rewrite ^ https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;
        }
}
"
echo "Ceci n'est pas une page" | sudo tee /var/www/html/404.html > /dev/null

echo "$new_config" | sudo tee /etc/nginx/sites-available/default > /dev/null

if [ "$(pgrep nginx)" -le 0 ];
then
    sudo service nginx start
else
    sudo service nginx restart
fi;
