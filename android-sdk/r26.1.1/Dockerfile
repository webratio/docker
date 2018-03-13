FROM nmaas87/webratio-ant

ENV ANDROID_SDK_VERSION r26.1.1
ENV ANDROID_SDK_BUILD 4333796
ENV ANDROID_BUILD_TOOLS_VERSION 27.0.3

# everything after build tools 23.0.1 is 64bit only: http://stackoverflow.com/questions/38096225/automatically-accept-all-sdk-licences 
RUN apt-get update -y && \
    apt-get install -y git-core libc6 libncurses5 libstdc++6 lib32z1 unzip && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean

# Installs Android SDK
ENV ANDROID_SDK_FILENAME sdk-tools-linux-${ANDROID_SDK_BUILD}.zip
ENV ANDROID_SDK_URL http://dl.google.com/android/repository/${ANDROID_SDK_FILENAME}
ENV ANDROID_API_LEVELS android-15,android-16,android-17,android-18,android-19,android-20,android-21,android-22,android-23,android-24,android-25,android-26,android-27
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
RUN cd /opt && \
    mkdir android-sdk-linux && \
    cd /opt/android-sdk-linux && \
    wget -q ${ANDROID_SDK_URL} && \
    unzip ${ANDROID_SDK_FILENAME} && \
    rm ${ANDROID_SDK_FILENAME} && \
    echo y | android update sdk --no-ui --all --filter tools,platform-tools,${ANDROID_API_LEVELS},build-tools-${ANDROID_BUILD_TOOLS_VERSION} && \
    echo y | android update sdk --no-ui --all --filter "extra-android-support" && \
    echo y | android update sdk --no-ui --all --filter "extra-android-m2repository" && \
    echo y | android update sdk --no-ui --all --filter "extra-google-m2repository"

# Installs Node.js
ENV NODE_VERSION 9.8.0
RUN cd && \
    wget -q http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz && \
    tar -xzf node-v${NODE_VERSION}-linux-x64.tar.gz && \
    mv node-v${NODE_VERSION}-linux-x64 /opt/node && \
    rm node-v${NODE_VERSION}-linux-x64.tar.gz
ENV PATH ${PATH}:/opt/node/bin