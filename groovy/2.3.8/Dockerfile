FROM webratio/gvm

# Defines environment variables
ENV GROOVY_VERSION 2.3.8

# Installs Groovy 
RUN /bin/bash -c "source /root/.gvm/bin/gvm-init.sh && gvm install groovy ${GROOVY_VERSION}"
ENV GROOVY_HOME /root/.gvm/groovy/current
ENV PATH $GROOVY_HOME/bin:$PATH

WORKDIR /source
ENTRYPOINT ["groovy", "-Dgrape.root=/graperoot"]