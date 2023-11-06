FROM ubuntu:jammy

ARG TARGETARCH

RUN apt-get update -y && \
    apt-get install -y dos2unix curl && \
    apt-get install -y openjdk-11-jdk && \
    apt-get autoremove -y && \
    apt-get clean
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-$TARGETARCH

# Fix for invalid 'cacerts' file
# - switch default keystore type to 'jks' (https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/1739631)
RUN sed -i 's/keystore.type=pkcs12/keystore.type=jks/' /etc/java-11-openjdk/security/java.security
