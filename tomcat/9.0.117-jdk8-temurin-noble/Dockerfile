FROM tomcat:9.0.117-jdk8-temurin-noble

# Define arguments for drivers and profiler
ARG YOURKIT_URL=https://webratio-public-resources.s3.eu-central-1.amazonaws.com/YourKit
ARG YOURKIT_VERSION=2019.1
ARG YOURKIT_BUILD=b133
ARG MYSQL_JDBC_DRIVER_URL=https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.6.0/mysql-connector-j-9.6.0.jar
ARG POSTGRESQL_JDBC_DRIVER_URL=https://jdbc.postgresql.org/download/postgresql-42.7.9.jar
ARG JAVA_MAIL_VERSION=1.6.2
ARG LOG4J_VERSION=2.25.4

ENV UMASK="0022"
ENV DEBUG="false"
ENV PROFILING="false"
ENV PORT="8080"
ENV CONNECTION_TIMEOUT="20000"
ENV SECURE="true"
ENV SCHEME="https"
ENV REDIRECT_PORT="8443"
ENV PROXY_PORT="443"
ENV MAX_HTTP_HEADER_SIZE="65536"
ENV MAX_PARAMETER_COUNT="-1"
ENV JAVA_HEAP_SIZE="256m"
ENV JAVA_METASPACE_SIZE="128m"
ENV TOMCAT_MAX_THREADS="100"
ENV TOMCAT_MIN_SPARE_THREADS="20"
ENV TOMCAT_ASYNC_TIMEOUT="10000"
ENV TOMCAT_CONNECTOR_COMPRESSION="off"
ENV TZ="Europe/Rome"

ENV LANG=en_US.UTF-8

# Install utilities & Clean webapps
RUN apt-get update -y && \
    apt-get install -y unzip wget tzdata locales dos2unix && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/local/tomcat/webapps/* && \
    mkdir -p /usr/local/tomcat/webapps

# Edit server.xml (Connector, Executor, and Error Valve)
# We delete the default connector (the one that starts with <Connector port="8080") 
# and insert our custom Executor + Connector in its place.
RUN EXEC='<Executor name="sharedThreadPool" namePrefix="catalina-exec-" maxThreads="${TOMCAT_MAX_THREADS}" minSpareThreads="${TOMCAT_MIN_SPARE_THREADS}"/>' && \
    CONN='<Connector URIEncoding="UTF-8" executor="sharedThreadPool" port="${PORT}" protocol="HTTP/1.1" connectionTimeout="${CONNECTION_TIMEOUT}" asyncTimeout="${TOMCAT_ASYNC_TIMEOUT}" secure="${SECURE}" scheme="${SCHEME}" redirectPort="${REDIRECT_PORT}" proxyPort="${PROXY_PORT}" server="-" compression="${TOMCAT_CONNECTOR_COMPRESSION}" maxHttpHeaderSize="${MAX_HTTP_HEADER_SIZE}" maxParameterCount="${MAX_PARAMETER_COUNT}"><UpgradeProtocol className="org.apache.coyote.http2.Http2Protocol"/></Connector>' && \
    # Remove the standard 8080 connector block entirely
    sed -i '/<Connector port="8080"/,/ \/>/d' /usr/local/tomcat/conf/server.xml && \
    # Insert the new components after the Service opening tag
    sed -i "/<Service name=\"Catalina\">/a \    $EXEC\n    $CONN" /usr/local/tomcat/conf/server.xml && \
    # Disable error page details
    sed -i '/<\/Host>/i \  <Valve className="org.apache.catalina.valves.ErrorReportValve" showReport="${DEBUG}" showServerInfo="${DEBUG}" />' /usr/local/tomcat/conf/server.xml

# JSP Optimizations in web.xml
RUN sed -i '/<servlet-class>org.apache.jasper.servlet.JspServlet<\/servlet-class>/a \
    <init-param><param-name>enablePooling</param-name><param-value>false</param-value></init-param>\n\
    <init-param><param-name>development</param-name><param-value>false</param-value></init-param>\n\
    <init-param><param-name>compilerSourceVM</param-name><param-value>1.7</param-value></init-param>\n\
    <init-param><param-name>compilerTargetVM</param-name><param-value>1.7</param-value></init-param>' /usr/local/tomcat/conf/web.xml

# External Resources (Drivers, YourKit)
RUN wget ${YOURKIT_URL}/${YOURKIT_VERSION}/YourKit-JavaProfiler-${YOURKIT_VERSION}-${YOURKIT_BUILD}.zip && \
    unzip YourKit-JavaProfiler-${YOURKIT_VERSION}-${YOURKIT_BUILD}.zip -d /opt/yjp && \
    rm -f YourKit-JavaProfiler-${YOURKIT_VERSION}-${YOURKIT_BUILD}.zip && \
    wget -P /usr/local/tomcat/lib "${MYSQL_JDBC_DRIVER_URL}" && \
    wget -P /usr/local/tomcat/lib "${POSTGRESQL_JDBC_DRIVER_URL}" --no-check-certificate && \
    wget -P /usr/local/tomcat/lib https://repo1.maven.org/maven2/com/sun/mail/javax.mail/${JAVA_MAIL_VERSION}/javax.mail-${JAVA_MAIL_VERSION}.jar

# Scripts and Certificates (Including Encoding Fix)
COPY import_self_signed_certs.sh set_timezone.sh /usr/local/tomcat/bin/
COPY sectigo-aaa-certificate-services-root.cer /usr/local/tomcat/sectigo-aaa-certificate-services-root.cer
COPY javadump.sh /javadump.sh

# Force LF line endings and strip BOM to prevent "not found" errors
RUN dos2unix /usr/local/tomcat/bin/*.sh /javadump.sh && \
    chmod +x /usr/local/tomcat/bin/*.sh /javadump.sh && \
    keytool -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt -trustcacerts -importcert \
    -alias sectigo-aaa-certificate-services-root -file /usr/local/tomcat/sectigo-aaa-certificate-services-root.cer

# Log4j2 Tomcat integration
ENV LOG_FORMAT="json"
RUN mkdir -p /usr/local/tomcat/log4j && \
    wget -O /usr/local/tomcat/log4j/log4j-appserver.jar https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-appserver/${LOG4J_VERSION}/log4j-appserver-${LOG4J_VERSION}.jar && \
    wget -O /usr/local/tomcat/log4j/log4j-api.jar https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/${LOG4J_VERSION}/log4j-api-${LOG4J_VERSION}.jar && \
    wget -O /usr/local/tomcat/log4j/log4j-core.jar https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/${LOG4J_VERSION}/log4j-core-${LOG4J_VERSION}.jar && \
    wget -O /usr/local/tomcat/log4j/log4j-layout-template-json.jar https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-layout-template-json/${LOG4J_VERSION}/log4j-layout-template-json-${LOG4J_VERSION}.jar
COPY log4j2-tomcat.xml /usr/local/tomcat/log4j/log4j2-tomcat.xml
COPY log4j2-tomcat.xml /usr/local/tomcat/log4j/log4j2-tomcat.xml

# Add setenv.sh
COPY setenv.sh /usr/local/tomcat/bin/setenv.sh
RUN dos2unix /usr/local/tomcat/bin/setenv.sh && \
    chmod +x /usr/local/tomcat/bin/setenv.sh

# Use absolute paths in CMD and ensure 'exec' is used to prevent port-binding ghosts
CMD ["sh", "-c", "umask ${UMASK:-0022} && /usr/local/tomcat/bin/set_timezone.sh && /usr/local/tomcat/bin/import_self_signed_certs.sh && exec /usr/local/tomcat/bin/catalina.sh run"]