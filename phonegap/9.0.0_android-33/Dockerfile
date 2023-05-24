FROM webratio/nodejs-with-android-sdk:16_sdk-33

# Installs PhoneGap
# Forces a create and build in order to preload libraries
ENV PHONEGAP_VERSION 9.0.0
ENV ANDROID_PLATFORM_VERSION 12.0.0
ENV GRADLE_VERSION 7.6
ENV GRADLE_HOME /opt/gradle
ENV ANDROID_SDK_ROOT $ANDROID_HOME
ENV PATH ${PATH}:${GRADLE_HOME}/bin
RUN apt-get update -y && \
    apt-get install -y git-core && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean && \
    npm install -g npm@6 && \
    npm install -g phonegap@${PHONEGAP_VERSION} && \
    npm install -g xmldom xpath fs-extra lodash iconv-lite xml2js xcode xml-writer && \
    wget -P /opt/ https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip && \
    unzip /opt/gradle-${GRADLE_VERSION}-all.zip -d /opt/ && \
    mv /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} && \
    cd /tmp && \
    phonegap cordova create fakeapp --no-insight && \
    cd /tmp/fakeapp && \
    phonegap cordova platform add android@${ANDROID_PLATFORM_VERSION} && \
    phonegap build android --verbose && \
    cd && \
    rm -rf /tmp/fakeapp
ENV CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL file:///opt/gradle-${GRADLE_VERSION}-all.zip
ADD init.gradle /root/.gradle

VOLUME ["/data"]
WORKDIR /data

EXPOSE 3000
