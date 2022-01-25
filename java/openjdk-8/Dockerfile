FROM ubuntu:trusty

ARG TARGETARCH

RUN apt-get update -y && \
    apt-get install -y dos2unix software-properties-common curl && \
    add-apt-repository ppa:openjdk-r/ppa -y && \
    apt-get update -y && \
    apt-get install -y openjdk-8-jdk && \
    apt-get remove software-properties-common -y && \
    apt-get autoremove -y && \
    apt-get clean
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-$TARGETARCH

# Fix for empty 'cacerts' file (https://bugs.launchpad.net/ubuntu/+source/ca-certificates-java/+bug/983302)
RUN update-ca-certificates -f
