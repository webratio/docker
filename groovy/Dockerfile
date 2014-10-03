FROM webratio/java:7

# Defines environment variables
ENV GROOVY_VERSION 2.3.7
ENV HOME /root

# Installs curl
RUN apt-get update && \
    apt-get install -y curl unzip 

# Installs Groovy
USER root
USER root
RUN curl -s get.gvmtool.net | bash
RUN /bin/bash -c "source /root/.gvm/bin/gvm-init.sh && gvm install groovy ${VERSION}"
#RUN source "/root/.gvm/bin/gvm-init.sh"
#RUN chmod +x /root/.gvm/bin/gvm-init.sh 
#RUN /root/.gvm/bin/gvm-init.sh
#RUN echo $PATH
#RUN gvm install groovy ${GROOVY_VERSION}

#VOLUME ["/data"]
#WORKDIR /data
