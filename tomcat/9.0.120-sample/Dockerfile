FROM webratio/tomcat:9.0.120-jdk11-temurin-noble

ARG SAMPLE_WAR_SHA256=89b33caa5bf4cfd235f060c396cb1a5acb2734a1366db325676f48c5f5ed92e5

USER root
RUN wget -q -O /tmp/sample.war \
      https://tomcat.apache.org/tomcat-9.0-doc/appdev/sample/sample.war && \
    echo "${SAMPLE_WAR_SHA256}  /tmp/sample.war" | sha256sum -c - && \
    mkdir -p /usr/local/tomcat/webapps/ROOT && \
    unzip -q /tmp/sample.war -d /usr/local/tomcat/webapps/ROOT && \
    rm -f /tmp/sample.war && \
    chown -R root:root /usr/local/tomcat/webapps && \
    chmod -R go-w /usr/local/tomcat/webapps && \
    chmod -R a+rX /usr/local/tomcat/webapps

USER 1001:1001
