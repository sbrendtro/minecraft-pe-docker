FROM ubuntu:16.04

MAINTAINER sbrendtro https://github.com/sbrendtro

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y \
        wget \
        perl gcc g++ make automake libtool autoconf m4 \
        gcc-multilib net-tools

RUN adduser --gecos 'PocketMine-MP' --disabled-password --home /pocketmine pocketmine

WORKDIR /pocketmine
RUN mkdir /pocketmine/PocketMine-MP

COPY assets/server.properties /pocketmine/server.properties.original
COPY assets/entrypoint.sh /pocketmine/entrypoint.sh

RUN chmod 755 /pocketmine/entrypoint.sh

ENV GNUPGHOME /pocketmine

ENV PHP_BINARY /pocketmine/PocketMine-MP/bin/php7/bin/php

RUN cd PocketMine-MP && wget -q -O install.sh https://get.pmmp.io \
   && chmod 755 install.sh && ./install.sh -r && rm install.sh

EXPOSE 19132
EXPOSE 19132/udp

ENTRYPOINT ["./entrypoint.sh"]
