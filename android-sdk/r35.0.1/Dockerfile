FROM webratio/java:openjdk-17

# r34.0.0
ENV ANDROID_SDK_VERSION 13114758
ENV ANDROID_BUILD_TOOLS_VERSION 35.0.1

# Installs misc dependencies, then installs i386 architecture required for running 32 bit Android tools
RUN dpkg --add-architecture i386 && \
    apt-get update -y && \
    apt-get install -y wget && \
    apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 unzip && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean

# Installs Android SDK
ENV ANDROID_SDK_FILENAME commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/${ANDROID_SDK_FILENAME}
ENV ANDROID_API_LEVELS "platforms;android-31" "platforms;android-32" "platforms;android-33" "platforms;android-34" "platforms;android-35"
ENV ANDROID_HOME /opt/sdk
ENV PATH ${PATH}:${ANDROID_HOME}/cmdline-tools:${ANDROID_HOME}/cmdline-tools/bin:${ANDROID_HOME}/platform-tools
RUN mkdir -p /opt/sdk && \
    cd /opt && \
    wget -q ${ANDROID_SDK_URL} && \
    unzip ${ANDROID_SDK_FILENAME} -d ${ANDROID_HOME} && \
    rm ${ANDROID_SDK_FILENAME} && \
    yes | sdkmanager "--sdk_root=$ANDROID_HOME" "platform-tools" ${ANDROID_API_LEVELS} "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"
