FROM tomcat:9.0.115-jdk8-temurin-noble

# Define arguments for drivers and profiler
ARG YOURKIT_URL=https://webratio-public-resources.s3.eu-central-1.amazonaws.com/YourKit
ARG YOURKIT_VERSION=2019.1
ARG YOURKIT_BUILD=b133
ARG MYSQL_JDBC_DRIVER_URL=https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.6.0/mysql-connector-j-9.6.0.jar
ARG POSTGRESQL_JDBC_DRIVER_URL=https://jdbc.postgresql.org/download/postgresql-42.7.9.jar
ARG JAVA_MAIL_VERSION=1.6.2

ENV UMASK="0022"
ENV DEBUG="false"
ENV PROFILING="false"
ENV PORT="8080"
ENV CONNECTION_TIMEOUT="20000"
ENV SECURE="TRUE"
ENV SCHEME="https"
ENV REDIRECT_PORT="8443"
ENV PROXY_PORT="443"
ENV MAX_HTTP_HEADER_SIZE="65536"
ENV MAX_PARAMETER_COUNT="-1"

# 1. Install utilities & Clean webapps
RUN apt-get update -y && \
    apt-get install -y unzip wget tzdata locales dos2unix && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/local/tomcat/webapps/* && \
    mkdir -p /usr/local/tomcat/webapps

# 2. Configure setenv.sh (Memory, YourKit, and Property Source)
# This allows server.xml to read environment variables like ${MAX_THREADS}
RUN echo 'JAVA_OPTS="${MORE_JAVA_OPTS} -Xmx${JAVA_HEAP_SIZE} -Xms${JAVA_HEAP_SIZE} -XX:MaxMetaspaceSize=${JAVA_METASPACE_SIZE} -XX:+IgnoreUnrecognizedVMOptions -XX:+UseCompressedOops -server -Djava.security.egd=file:/dev/./urandom"' > /usr/local/tomcat/bin/setenv.sh && \
    echo 'CATALINA_OPTS="${MORE_CATALINA_OPTS} -Dorg.apache.jasper.runtime.JspFactoryImpl.USE_POOL=false -Dorg.apache.tomcat.util.digester.PROPERTY_SOURCE=org.apache.tomcat.util.digester.EnvironmentPropertySource"' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'if [ "$DEBUG" = "true" ]; then' >> /usr/local/tomcat/bin/setenv.sh && \
    echo '  echo "DEBUG: Remote debugging enabled on port 8000"' >> /usr/local/tomcat/bin/setenv.sh && \
    echo '  export JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=0.0.0.0:8000"' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'fi' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'if [ "$PROFILING" = "true" ]; then' >> /usr/local/tomcat/bin/setenv.sh && \
    echo '  echo "PROFILER: YourKit agent enabled on port 10001"' >> /usr/local/tomcat/bin/setenv.sh && \
    echo '  export JAVA_OPTS="$JAVA_OPTS -agentpath:/opt/yjp/YourKit-JavaProfiler-2019.1/bin/linux-x86-64/libyjpagent.so=disablestacktelemetry,disableexceptiontelemetry,probe_disable=com.yourkit.probes.builtin.*,delay=10000,port=10001,listen=all"' >> /usr/local/tomcat/bin/setenv.sh && \
    echo 'fi' >> /usr/local/tomcat/bin/setenv.sh && \
    chmod +x /usr/local/tomcat/bin/setenv.sh

# 3. Edit server.xml (Connector, Executor, and Error Valve)
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

# 4. JSP Optimizations in web.xml
RUN sed -i '/<servlet-class>org.apache.jasper.servlet.JspServlet<\/servlet-class>/a \
    <init-param><param-name>enablePooling</param-name><param-value>false</param-value></init-param>\n\
    <init-param><param-name>development</param-name><param-value>false</param-value></init-param>\n\
    <init-param><param-name>compilerSourceVM</param-name><param-value>1.7</param-value></init-param>\n\
    <init-param><param-name>compilerTargetVM</param-name><param-value>1.7</param-value></init-param>' /usr/local/tomcat/conf/web.xml

# 5. External Resources (Drivers, YourKit)
RUN wget ${YOURKIT_URL}/${YOURKIT_VERSION}/YourKit-JavaProfiler-${YOURKIT_VERSION}-${YOURKIT_BUILD}.zip && \
    unzip YourKit-JavaProfiler-${YOURKIT_VERSION}-${YOURKIT_BUILD}.zip -d /opt/yjp && \
    rm -f YourKit-JavaProfiler-${YOURKIT_VERSION}-${YOURKIT_BUILD}.zip && \
    wget -P /usr/local/tomcat/lib "${MYSQL_JDBC_DRIVER_URL}" && \
    wget -P /usr/local/tomcat/lib "${POSTGRESQL_JDBC_DRIVER_URL}" --no-check-certificate && \
    wget -P /usr/local/tomcat/lib https://repo1.maven.org/maven2/com/sun/mail/javax.mail/${JAVA_MAIL_VERSION}/javax.mail-${JAVA_MAIL_VERSION}.jar

# 6. Scripts and Certificates (Including Encoding Fix)
COPY import_self_signed_certs.sh set_timezone.sh /usr/local/tomcat/bin/
COPY sectigo-aaa-certificate-services-root.cer /usr/local/tomcat/sectigo-aaa-certificate-services-root.cer
COPY javadump.sh /javadump.sh

# Force LF line endings and strip BOM to prevent "not found" errors
RUN dos2unix /usr/local/tomcat/bin/*.sh /javadump.sh && \
    chmod +x /usr/local/tomcat/bin/*.sh /javadump.sh && \
    keytool -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt -trustcacerts -importcert \
    -alias sectigo-aaa-certificate-services-root -file /usr/local/tomcat/sectigo-aaa-certificate-services-root.cer

ENV LANG=en_US.UTF-8

# Use absolute paths in CMD and ensure 'exec' is used to prevent port-binding ghosts
CMD ["sh", "-c", "umask ${UMASK:-0022} && /usr/local/tomcat/bin/set_timezone.sh && /usr/local/tomcat/bin/import_self_signed_certs.sh && exec /usr/local/tomcat/bin/catalina.sh run"]