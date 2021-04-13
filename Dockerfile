FROM debian:buster

RUN apt-get update
RUN apt-get install -y wget && apt-get install -y openssl
RUN apt-get install -y nginx
RUN apt-get install -y vim
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN apt-get install -y mariadb-server

COPY srcs/init.sh ./
COPY srcs/web-conf ./tmp/
COPY srcs/config.inc.php ./tmp/
COPY srcs/wp-config.php ./tmp/
COPY srcs/autoindex.sh ./

CMD bash init.sh