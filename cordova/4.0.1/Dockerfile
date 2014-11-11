FROM webratio/nodejs-with-android-sdk

# Installs Cordova
# Forces a platform add in order to preload libraries
ENV CORDOVA_VERSION 4.0.1
RUN npm install -g npm && \
    npm install -g cordova@${CORDOVA_VERSION} && \
    cd /tmp && \
    cordova create fakeapp && \
    cd /tmp/fakeapp && \
    cordova platform add android && \
    cd && \
    rm -rf /tmp/fakeapp

VOLUME ["/data"]
WORKDIR /data

EXPOSE 8000