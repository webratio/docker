FROM webratio/ant:1.10.1

# r28.0.3
ENV ANDROID_SDK_VERSION 4333796
ENV ANDROID_BUILD_TOOLS_VERSION 28.0.3

# Installs i386 architecture required for running 32 bit Android tools
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 unzip && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean

# Installs Android SDK
ENV ANDROID_SDK_FILENAME sdk-tools-linux-${ANDROID_SDK_VERSION}.zip
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/${ANDROID_SDK_FILENAME}
ENV ANDROID_API_LEVELS "platforms;android-15" "platforms;android-16" "platforms;android-17" "platforms;android-18" "platforms;android-19" "platforms;android-20" "platforms;android-21" "platforms;android-22" "platforms;android-23" "platforms;android-24" "platforms;android-25" "platforms;android-26" "platforms;android-27" "platforms;android-28"
ENV ANDROID_HOME /opt/sdk
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools
RUN mkdir -p /opt/sdk && \
    cd /opt && \
    wget -q ${ANDROID_SDK_URL} && \
    unzip ${ANDROID_SDK_FILENAME} -d ${ANDROID_HOME} && \
    rm ${ANDROID_SDK_FILENAME} && \
    yes | sdkmanager "tools" "platform-tools" ${ANDROID_API_LEVELS} "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"