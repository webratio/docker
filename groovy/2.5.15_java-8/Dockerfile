FROM webratio/java:openjdk-8

# Defines environment variables for GVM
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Installs curl and GVM
RUN apt-get update && \
    apt-get install -y curl zip && \
    curl -s "https://get.sdkman.io" | bash && \
    apt-get autoremove -y && \
    apt-get clean

# Defines environment variables for Groovy
ENV GROOVY_VERSION 2.5.15

# Installs Groovy 
RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install groovy ${GROOVY_VERSION}"
ENV GROOVY_HOME /root/.sdkman/candidates/groovy/current
ENV PATH $GROOVY_HOME/bin:$PATH

WORKDIR /source
ENTRYPOINT ["groovy", "-Dgrape.root=/graperoot"]
