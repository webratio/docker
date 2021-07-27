FROM webratio/java:8

# Version
ENV BUNDLETOOL_VERSION 1.7.0

# Install misc tools
RUN apt-get install unzip

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
