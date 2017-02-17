FROM leandrorepolho/cstrike16

USER root
RUN echo 'mysql-server mysql-server/root_password password root' | debconf-set-selections \
	&& echo 'mysql-server mysql-server/root_password_again password root' | debconf-set-selections

RUN apt-get install -y mysql-server libapache2-mod-php5 php5-mysql

USER root

ENTRYPOINT service apache2 start && service mysql start \
	&& su - csserver -c "cd /home/csserver/serverfiles && ./hlds_run -game cstrike -strictportbind -ip 0.0.0.0 -port $PORT +clientport $CLIENTPORT +map $DEFAULTMAP -maxplayers $MAXPLAYERS"

# mysql -uhlxuser -phlxpassword hlstatsx < install.sql
# chmod +x hlstats-awards.pl hlstats.pl hlstats-resolve.pl run_hlstats
# ./run_hlstats start
# ./hlstats-awards.pl --db-name=cstrike --db-password=root
# install php gd


# ./hlstats-awards.pl && ./run_hlstats start