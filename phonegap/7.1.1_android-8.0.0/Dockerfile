FROM webratio/nodejs-with-android-sdk:10.14.0

# Installs PhoneGap
# Forces a create and build in order to preload libraries
ENV PHONEGAP_VERSION 7.1.1
ENV ANDROID_PLATFORM_VERSION 8.0.0
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
    phonegap create fakeapp --no-insight && \
    cd /tmp/fakeapp && \
    sed -i 's|name="android-minSdkVersion" value="14"|name="android-minSdkVersion" value="19"|g' /tmp/fakeapp/config.xml && \
    phonegap cordova platform add android@${ANDROID_PLATFORM_VERSION} --force && \
    phonegap build android --verbose && \
    cd && \
    rm -rf /tmp/fakeapp
ENV CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL file:///opt/gradle-4.10.3-all.zip
ADD init.gradle /root/.gradle

VOLUME ["/data"]
WORKDIR /data

EXPOSE 3000