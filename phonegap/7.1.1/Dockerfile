FROM webratio/nodejs-with-android-sdk:8.9.4

# Installs PhoneGap
# Forces a create and build in order to preload libraries
ENV PHONEGAP_VERSION 7.1.1
ENV GRADLE_HOME /opt/gradle
ENV PATH ${PATH}:${GRADLE_HOME}/bin
RUN apt-get update -y && \
    apt-get install -y git-core && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean && \
    npm install -g phonegap@${PHONEGAP_VERSION} && \
    npm install -g xmldom && \
    npm install -g xpath && \
    wget -P /tmp/ https://services.gradle.org/distributions/gradle-4.5.1-bin.zip && \
    unzip /tmp/gradle-4.5.1-bin.zip -d /opt/ && \
    mv /opt/gradle-4.5.1 ${GRADLE_HOME} && \
    rm -f /tmp/gradle-4.5.1-bin.zip && \
    cd /tmp && \
    phonegap create fakeapp --no-insight && \
    cd /tmp/fakeapp && \
    phonegap build android && \
    cd && \
    rm -rf /tmp/fakeapp

VOLUME ["/data"]
WORKDIR /data

EXPOSE 3000