FROM ubuntu:18.04

RUN mkdir /tmp/scripts

COPY scripts /tmp/scripts

RUN apt-get update && apt-get install -y gnupg2 wget sudo

RUN wget -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5072E1F5

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN echo "deb http://repo.mysql.com/apt/ubuntu/ bionic mysql-5.7" > /etc/apt/sources.list.d/mysql.list

RUN apt-get update 

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-9.3 mysql-server-5.7

RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

RUN find /var/lib/mysql -type f -exec touch {} \; &&\
 service mysql start &&\
 mysql --execute "CREATE USER 'eletron'@'localhost' IDENTIFIED BY '1234';" &&\
 mysql --execute "CREATE USER 'eletron'@'%' IDENTIFIED BY '1234';" &&\
 mysql --execute "GRANT ALL PRIVILEGES ON * . * TO 'eletron'@'localhost' WITH GRANT OPTION;" &&\
 mysql --execute "GRANT ALL PRIVILEGES ON * . * TO 'eletron'@'%' WITH GRANT OPTION;" &&\
 mysql < /tmp/scripts/synchronization.sql &&\
 mysql < /tmp/scripts/eletron.sql
 
RUN sed -i 's/\r//' /tmp/scripts/init.sh

USER postgres

RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER eletron WITH SUPERUSER PASSWORD '1234';" &&\
	psql -f /tmp/scripts/supremo.sql

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

USER root

EXPOSE 5432 3306

ENTRYPOINT "/tmp/scripts/init.sh"