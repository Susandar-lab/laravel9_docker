
> Docker Containers for Laravel nine
laravel with docker image                  
mysql:8.0
nginx:alpine
redis:alpine
phpmyadmin

``` bash
#For composer
docker exec -it laravel-app /bin/bash
composer install

#For laravel permission
docker exec -it laravel-app /bin/bash
chown -R www-data:www-data /var/www

#if there is permission issue
chown -R www-data:www-data /var/www/storage
chmod -R 755 /var/www/storage
chmod -R 755 /var/www/bootstrap/cache


#Build and Run docker containers
docker-compose build
docker-compose up -d
docker-compose ps
```
##Finally browse the application
#http://localhost:8088/
