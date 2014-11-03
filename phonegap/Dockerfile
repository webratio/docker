FROM dockerfile/nodejs

# Defines environment variables
ENV PHONEGAP_VERSION 3.5.0-0.21.18
ENV ANDROID_SDK_FILENAME android-sdk_r23.0.2-linux.tgz
ENV ANT_VERSION 1.9.4
ENV ANDROID_API_LEVELS android-15,android-16,android-17,android-18,android-19 
ENV ANDROID_BUILD_TOOLS_VERSION 20.0.0

# Installs Oracle JDK 7
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java7-installer && \
    rm -rf /var/lib/apt/lists/*

# Installs PhoneGap
RUN npm install -g phonegap@${PHONEGAP_VERSION}

# Installs i386 architecture required for running 32 bit Android tools 
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1

# Installs Android SDK
ENV ANDROID_SDK_URL http://dl.google.com/android/${ANDROID_SDK_FILENAME}
RUN cd /opt && \
    wget ${ANDROID_SDK_URL} && \
    tar -xvzf ${ANDROID_SDK_FILENAME} && \
    rm ${ANDROID_SDK_FILENAME}
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
RUN echo y | android update sdk --no-ui -a --filter tools,platform-tools,${ANDROID_API_LEVELS},build-tools-${ANDROID_BUILD_TOOLS_VERSION}

# Installs Ant
RUN cd && \
    wget http://www.us.apache.org/dist//ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xvzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mv apache-ant-${ANT_VERSION} /opt/ant && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz
ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:/opt/ant/bin

# Forces a create and build android in order to preload libraries
RUN cd /tmp && \
    phonegap create fakeapp && \
    cd /tmp/fakeapp && \
    phonegap build android && \
    cd && \
    rm -rf /tmp/fakeapp

VOLUME ["/data"]
WORKDIR /data

EXPOSE 3000
