FROM ubuntu:trusty

RUN apt-get update -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update -y && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java7-installer && \
    apt-get remove software-properties-common -y && \
    apt-get autoremove -y && \
    apt-get clean
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle