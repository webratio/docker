FROM webratio/ant:1.10.1

# r30.0.3
ENV ANDROID_SDK_VERSION 7583922
ENV ANDROID_BUILD_TOOLS_VERSION 30.0.3

# Installs i386 architecture required for running 32 bit Android tools
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 unzip && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean

# Installs Android SDK
ENV ANDROID_SDK_FILENAME commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/${ANDROID_SDK_FILENAME}
ENV ANDROID_API_LEVELS "platforms;android-19" "platforms;android-20" "platforms;android-21" "platforms;android-22" "platforms;android-23" "platforms;android-24" "platforms;android-25" "platforms;android-26" "platforms;android-27" "platforms;android-28" "platforms;android-29" "platforms;android-30"
ENV ANDROID_HOME /opt/sdk
ENV PATH ${PATH}:${ANDROID_HOME}/cmdline-tools:${ANDROID_HOME}/cmdline-tools/bin:${ANDROID_HOME}/platform-tools
RUN mkdir -p /opt/sdk && \
    cd /opt && \
    wget -q ${ANDROID_SDK_URL} && \
    unzip ${ANDROID_SDK_FILENAME} -d ${ANDROID_HOME} && \
    rm ${ANDROID_SDK_FILENAME} && \
    yes | sdkmanager "--sdk_root=$ANDROID_HOME" "tools" "platform-tools" ${ANDROID_API_LEVELS} "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"
