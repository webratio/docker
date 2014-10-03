FROM webratio/java:7

# Defines environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Installs curl
RUN apt-get update && \
    apt-get install -y curl unzip 

# Installs Groovy
USER root
RUN curl -s get.gvmtool.net | bash
