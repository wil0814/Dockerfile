FROM ubuntu:18.04
MAINTAINER william

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install nginx -y\
#    && apt-get install dialog\
    && apt-get install php7.2-fpm -y\
    && apt-get install vim -y\
    && apt-get install mariadb-server -y\
    && apt-get install phpmyadmin -y



    

COPY info.php /usr/share/nginx/html/

COPY docker.conf /etc/nginx/conf.d/default.conf

#COPY test.sql /root/test.sql

COPY test /usr/share/nginx/html/test
#COPY start.sh /root/start.sh

#COPY data/test /var/lib/mysql/

COPY basckup.sql /basckup.sql
#COPY my.cnf /etc/mysql/my.cnf
#COPY mysqld /var/run/mysqld

EXPOSE 80 3306 8080

#CMD ["bash","-c","/etc/init.d/php7.2-fpm start ; nginx -g 'daemon off;'"]
CMD ["sh","-c","/etc/init.d/php7.2-fpm start; /etc/init.d/nginx start; /etc/init.d/mysql start; ln -s /usr/share/phpmyadmin/ /usr/share/nginx/html/ ;mysql -uroot -proot < basckup.sql;mysql -uroot -prootpw -e GRANT ALL PRIVILEGES ON test.* TO william@localhost IDENTIFIED BY ''; /bin/bash"]
#WORKDIR /root
#CMD /bin/sh -c nignx -g daemon off
#CMD ["nginx","-g","daemon off;"]
#CMD ["./start.sh"]
