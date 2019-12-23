FROM webratio/nodejs-with-android-sdk:12.13.1

# Installs PhoneGap
# Forces a create and build in order to preload libraries
ENV PHONEGAP_VERSION 9.0.0
ENV ANDROID_PLATFORM_VERSION 8.1.0
ENV GRADLE_HOME /opt/gradle
ENV ANDROID_SDK_ROOT /opt/sdk
ENV PATH ${PATH}:${GRADLE_HOME}/bin
RUN apt-get update -y && \
    apt-get install -y git-core && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean && \
    npm install -g phonegap@${PHONEGAP_VERSION} && \
    npm install -g xmldom && \
    npm install -g xpath && \
    npm install -g fs-extra && \
    npm install -g lodash && \
    npm install -g iconv-lite && \
    npm install -g xml2js && \
    npm install -g xcode && \
    npm install -g xml-writer && \
    wget -P /opt/ https://services.gradle.org/distributions/gradle-4.10.3-all.zip && \
    unzip /opt/gradle-4.10.3-all.zip -d /opt/ && \
    mv /opt/gradle-4.10.3 ${GRADLE_HOME} && \
    cd /tmp && \
    phonegap cordova create fakeapp --no-insight && \
    cd /tmp/fakeapp && \
    phonegap cordova platform add android@${ANDROID_PLATFORM_VERSION} && \
    phonegap cordova plugin add cordova-plugin-battery-status && \
    phonegap cordova plugin add cordova-plugin-camera && \
    phonegap cordova plugin add cordova-plugin-media-capture && \
    phonegap cordova plugin add cordova-plugin-device && \
    phonegap cordova plugin add cordova-plugin-dialogs && \
    phonegap cordova plugin add cordova-plugin-file && \
    phonegap cordova plugin add cordova-plugin-geolocation && \
    phonegap cordova plugin add cordova-plugin-globalization && \
    phonegap cordova plugin add cordova-plugin-inappbrowser && \
    phonegap cordova plugin add cordova-plugin-network-information && \
    phonegap cordova plugin add cordova-plugin-vibration && \
    phonegap build android --verbose && \
    cd && \
    rm -rf /tmp/fakeapp
ENV CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL file:///opt/gradle-4.10.3-all.zip
ADD init.gradle /root/.gradle

VOLUME ["/data"]
WORKDIR /data

EXPOSE 3000