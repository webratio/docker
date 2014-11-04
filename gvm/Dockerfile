FROM webratio/java:7

# Defines environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Installs curl and GVM
RUN apt-get update && \
    apt-get install -y curl unzip && \
    curl -s get.gvmtool.net | bash && \
    apt-get autoremove -y && \
    apt-get clean