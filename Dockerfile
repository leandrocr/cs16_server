FROM debian
MAINTAINER Saruhan Karademir
 
ENV DEFAULTMAP de_dust2
ENV MAXPLAYERS 16
ENV PORT 27015
ENV CLIENTPORT 27005
ENV SERVERNAME servername
ENV RCONPASS rconpass
 
EXPOSE $PORT/udp
EXPOSE $CLIENTPORT/udp
EXPOSE $PORT
EXPOSE $CLIENTPORT
EXPOSE 1200/udp
 
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -qqy install gdb mailutils postfix tmux ca-certificates lib32gcc1 wget
RUN apt-get install -y curl bsdmainutils bzip2 unzip libstdc++6:i386
 
# script refuses to run in root, create user
RUN useradd -m csserver
RUN adduser csserver sudo
USER csserver
WORKDIR /home/csserver
 
# download Counter-Strike 1.6 Linux Server Manager script
RUN wget https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/CounterStrike/csserver
RUN chmod +x csserver
 
# Install the server
RUN ./csserver auto-install
 
# To edit the server.cfg or insert maps
# we will need to some work with files
# this is where it will go
 
# Start the server
WORKDIR /home/csserver/serverfiles
ENTRYPOINT ./hlds_run -game cstrike -strictportbind -ip 0.0.0.0 -port $PORT +clientport $CLIENTPORT  +map $DEFAULTMAP -maxplayers $MAXPLAYERS
