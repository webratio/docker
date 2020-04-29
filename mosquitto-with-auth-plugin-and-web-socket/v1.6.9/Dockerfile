FROM debian:stable-slim

ENV MOSQUITTO_VERSION=1.6.9
RUN \
        set -x; \
        apt-get update && apt-get install -y libwebsockets8 libwebsockets-dev libc-ares2 libc-ares-dev openssl uuid uuid-dev wget build-essential git cmake libcurl4-openssl-dev curl \ 
        && cd /tmp \
        && wget http://mosquitto.org/files/source/mosquitto-$MOSQUITTO_VERSION.tar.gz -O mosquitto.tar.gz \
        && wget http://mosquitto.org/files/source/mosquitto-$MOSQUITTO_VERSION.tar.gz.asc -O mosquitto.tar.gz.asc \
        && mkdir mosquitto-src && tar xfz mosquitto.tar.gz --strip-components=1 -C mosquitto-src \
        && cd mosquitto-src \
        && make WITH_SRV=yes WITH_MEMORY_TRACKING=no WITH_WEBSOCKETS=yes \
        && make install && ldconfig \
        && git clone https://github.com/semioty/mosquitto-auth-plug.git \
        && cd mosquitto-auth-plug \
        && cp config.mk.in config.mk \
        && sed -i "s/BACKEND_HTTP ?= no/BACKEND_HTTP ?= yes/" config.mk \
        && sed -i "s/BACKEND_MYSQL ?= yes/BACKEND_MYSQL ?= no/" config.mk \
        && sed -i "s/CFG_LDFLAGS =/CFG_LDFLAGS = -lcares/" config.mk \
        && sed -i "s/MOSQUITTO_SRC =/MOSQUITTO_SRC = \/tmp\/mosquitto-src\//" config.mk \
        && make \
        && cp np /usr/bin/np \
        && mkdir /mqtt && cp auth-plug.so /mqtt/ \
        && cp auth-plug.so /usr/local/lib/ \
        && useradd -r mosquitto \
        && apt-get purge -y build-essential git wget ca-certificates \
        && apt-get autoremove -y \
        && apt-get -y autoclean \
        && rm -rf /var/cache/apt/* \
        && rm -rf  /tmp/*

VOLUME ["/var/lib/mosquitto"]

EXPOSE 1883 8883 9883

ADD mosquitto.conf /etc/mosquitto/mosquitto.conf
ADD run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
CMD ["mosquitto"]