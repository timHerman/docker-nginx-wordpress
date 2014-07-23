#docker-nginx-wordpress
Docker NGINX + WP + W3 total cache Container 
 
## About

This container is optimized for running Wordpress and W3 total cache using NGINX

This container requires a seperate dedicated mysql container (timherman/mysql) to run.
You can find timherman/mysql either at docker (https://registry.hub.docker.com/u/timherman/mysql/) or github (https://github.com/timHerman/docker-mysql)

## Usage by example

### The mysql container

#### Running the container

```shell
docker run -d --name="be.punk.www.mysql" -e "MYSQL_LOCAL_USER=[username]" -e "MYSQL_LOCAL_DATABASE=[database]" -e "MYSQL_LOCAL_PASSWORD=[password]" -v /location/of/mysqldata/at/host/:/var/lib/mysql/  timherman/mysql
```

#### How it works

* -d : Run daemonized
* --Name : The name of the container
* -e : Environmental parameters
  * MYSQL_ROOT_PASSWORD : When no root password of the database is set there will be one generated for you
  * MYSQL_LOCAL_USER : The mysql username for your application
  * MYSQL_LOCAL_DATABASE : The mysql database name for your application
  * MYSQL_LOCAL_PASSWORD : The mysql database password
* -v : Linking a directory on your host with the mysql data of the container
* timherman/mysql : The name of the repository	


### The wordpress container

#### Running the container

```shell
docker run -d --name="be.punk.www.wordpress" -p 80:80 -e="ROUTER_VIRTUAL_HOST=www.reisplanner.eu" -v /location/of/wordpressdata/at/host/:/var/www/ --link be.punk.www.mysql:db timherman/nginx-wordpress
```

#### How it works

* -d : Run daemonized
* -p : Map the 80 port the container to the 80 port of the host ( Not required when using a reverse proxy )
* -e : Environmental parameters
  * ROUTER_VIRTUAL_HOST : For reverse proxy automatisation (not required)
  * MAILSERVER : External smtp server (smart host)
* -v : Linking a directory on your host with the wordpress data of the container
* --link : linking this container be.punk.www.mysql and set it up with the hostname 'db'
* timherman/nginx-wordpress : The name of the repositor


## Comments

In our example the wordpress container is linked to the mysql container under the alias db.
This means that you'll have to edit your wp-config file in such a way that the mysql host is no longer localhost but db.

```php
/** MySQL hostname */
define('DB_HOST', 'db');
````

For more information leave a message or visit http://www.punk.be

Regards,
Tim


Inspiration from:
https://rtcamp.com/wordpress-nginx/tutorials/single-site/w3-total-cache/
https://github.com/bradleyboy/docker-koken-nginx/blob/master/Dockerfile
