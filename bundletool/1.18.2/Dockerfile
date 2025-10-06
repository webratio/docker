FROM webratio/java:openjdk-17

# Version
ENV BUNDLETOOL_VERSION 1.18.2

# Install misc tools
RUN apt-get update -y && \
    apt-get install -y unzip && \
    apt-get install -y wget && \
    apt-get autoremove -y && \
    apt-get clean

# Install bundletool
ENV BUNDLETOOL_FILENAME bundletool-all-${BUNDLETOOL_VERSION}.jar
ENV BUNDLETOOL_URL https://github.com/google/bundletool/releases/download/${BUNDLETOOL_VERSION}/${BUNDLETOOL_FILENAME}
ENV PATH ${PATH}:/opt/bundletool
RUN mkdir -p /opt/bundletool && \
    cd /opt/bundletool && \
    wget -nv ${BUNDLETOOL_URL} && \
    echo '#!/bin/sh' > bundletool && \
    echo 'java -jar /opt/bundletool/${BUNDLETOOL_FILENAME} "$@"' >> bundletool && \
    chmod +x bundletool