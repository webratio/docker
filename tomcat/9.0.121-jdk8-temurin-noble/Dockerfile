FROM tomcat:9.0.121-jdk8-temurin-noble@sha256:e24e53508b465f13726bd630278b360108961a9976c8caa89a1ad59f6785dcb8

ARG YOURKIT_URL=https://webratio-public-resources.s3.eu-central-1.amazonaws.com/YourKit
ARG YOURKIT_VERSION=2019.1
ARG YOURKIT_BUILD=b133
ARG YOURKIT_SHA256=eeaa52616b9d35703e5aed1380bae38b6b9db98956c8802a1fed2227897a9aeb
ARG MYSQL_JDBC_DRIVER_URL=https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.6.0/mysql-connector-j-9.6.0.jar
ARG MYSQL_JDBC_DRIVER_SHA256=66df1d453789dc8cb759a7dc17f58646893bf28483f262328650f170472a6ead
ARG POSTGRESQL_JDBC_DRIVER_URL=https://jdbc.postgresql.org/download/postgresql-42.7.9.jar
ARG POSTGRESQL_JDBC_DRIVER_SHA256=88f1fc3992e80ec3b048f798030e9a014aa4783c40afb56d3e7a87ee0adf166f
ARG JAVA_MAIL_VERSION=1.6.2
ARG JAVA_MAIL_SHA256=45b515e7104944c09e45b9c7bb1ce5dff640486374852dd2b2e80cc3752dfa11
ARG LOG4J_VERSION=2.25.4
ARG LOG4J_APPSERVER_SHA256=3957c4c9f31d6671ccce38836452d36a8599b9877ca87cf7d92c0a94541c9fee
ARG LOG4J_API_SHA256=c4b642a7f047275215de117e0e3847eb2c7711d84a0aa7433e7b3c096daf341d
ARG LOG4J_CORE_SHA256=10fee2c0485d54fa44ee75d314f6295508f7b932281873db61a91b88073200e6
ARG LOG4J_LAYOUT_TEMPLATE_JSON_SHA256=a2f8d03f39ff62de75d4524c9ee085f167e201da91652141097a60643ce22e85

ENV UMASK=0022 \
    DEBUG=false \
    PROFILING=false \
    PORT=8080 \
    CONNECTION_TIMEOUT=20000 \
    SECURE=true \
    SCHEME=https \
    REDIRECT_PORT=8443 \
    PROXY_PORT=443 \
    MAX_HTTP_HEADER_SIZE=65536 \
    MAX_PARAMETER_COUNT=10000 \
    JAVA_HEAP_SIZE=256m \
    JAVA_METASPACE_SIZE=128m \
    TOMCAT_MAX_THREADS=100 \
    TOMCAT_MIN_SPARE_THREADS=20 \
    TOMCAT_ASYNC_TIMEOUT=10000 \
    TOMCAT_CONNECTOR_COMPRESSION=off \
    TZ=Europe/Rome \
    LANG=en_US.UTF-8 \
    HOME=/home/tomcat \
    LOG_FORMAT=json

RUN apt-get update && \
    apt-get install -y --no-install-recommends locales tzdata unzip wget && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd --gid 1001 tomcat && \
    useradd --uid 1001 --gid 1001 --home-dir /home/tomcat --shell /usr/sbin/nologin tomcat && \
    rm -rf /usr/local/tomcat/webapps /usr/local/tomcat/webapps.dist && \
    mkdir -p \
      /home/tomcat/.webratio \
      /usr/local/tomcat/conf/Catalina/localhost \
      /usr/local/tomcat/logs \
      /usr/local/tomcat/temp \
      /usr/local/tomcat/work \
      /usr/local/tomcat/upload \
      /usr/local/tomcat/webapps

RUN EXEC='<Executor name="sharedThreadPool" namePrefix="catalina-exec-" maxThreads="${TOMCAT_MAX_THREADS}" minSpareThreads="${TOMCAT_MIN_SPARE_THREADS}"/>' && \
    CONN='<Connector URIEncoding="UTF-8" executor="sharedThreadPool" port="${PORT}" protocol="HTTP/1.1" connectionTimeout="${CONNECTION_TIMEOUT}" asyncTimeout="${TOMCAT_ASYNC_TIMEOUT}" secure="${SECURE}" scheme="${SCHEME}" redirectPort="${REDIRECT_PORT}" proxyPort="${PROXY_PORT}" server="-" compression="${TOMCAT_CONNECTOR_COMPRESSION}" maxHttpHeaderSize="${MAX_HTTP_HEADER_SIZE}" maxParameterCount="${MAX_PARAMETER_COUNT}"><UpgradeProtocol className="org.apache.coyote.http2.Http2Protocol"/></Connector>' && \
    sed -i '/<Connector port="8080"/,/ \/>/d' /usr/local/tomcat/conf/server.xml && \
    sed -i "/<Service name=\"Catalina\">/a \\    $EXEC\n    $CONN" /usr/local/tomcat/conf/server.xml && \
    sed -i '/<\/Host>/i \  <Valve className="org.apache.catalina.valves.ErrorReportValve" showReport="${DEBUG}" showServerInfo="${DEBUG}" />' /usr/local/tomcat/conf/server.xml && \
    sed -i '/<servlet-class>org.apache.jasper.servlet.JspServlet<\/servlet-class>/a \
    <init-param><param-name>enablePooling</param-name><param-value>false</param-value></init-param>\n\
    <init-param><param-name>development</param-name><param-value>false</param-value></init-param>\n\
    <init-param><param-name>compilerSourceVM</param-name><param-value>1.7</param-value></init-param>\n\
    <init-param><param-name>compilerTargetVM</param-name><param-value>1.7</param-value></init-param>' /usr/local/tomcat/conf/web.xml

RUN wget -q -O /tmp/yourkit.zip "${YOURKIT_URL}/${YOURKIT_VERSION}/YourKit-JavaProfiler-${YOURKIT_VERSION}-${YOURKIT_BUILD}.zip" && \
    echo "${YOURKIT_SHA256}  /tmp/yourkit.zip" | sha256sum -c - && \
    unzip -q /tmp/yourkit.zip -d /opt/yjp && \
    rm -f /tmp/yourkit.zip && \
    wget -q -O /usr/local/tomcat/lib/mysql-connector-j-9.6.0.jar "${MYSQL_JDBC_DRIVER_URL}" && \
    echo "${MYSQL_JDBC_DRIVER_SHA256}  /usr/local/tomcat/lib/mysql-connector-j-9.6.0.jar" | sha256sum -c - && \
    wget -q -O /usr/local/tomcat/lib/postgresql-42.7.9.jar "${POSTGRESQL_JDBC_DRIVER_URL}" && \
    echo "${POSTGRESQL_JDBC_DRIVER_SHA256}  /usr/local/tomcat/lib/postgresql-42.7.9.jar" | sha256sum -c - && \
    wget -q -O /usr/local/tomcat/lib/javax.mail-1.6.2.jar "https://repo1.maven.org/maven2/com/sun/mail/javax.mail/${JAVA_MAIL_VERSION}/javax.mail-${JAVA_MAIL_VERSION}.jar" && \
    echo "${JAVA_MAIL_SHA256}  /usr/local/tomcat/lib/javax.mail-1.6.2.jar" | sha256sum -c - && \
    mkdir -p /usr/local/tomcat/log4j && \
    wget -q -O /usr/local/tomcat/log4j/log4j-appserver.jar "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-appserver/${LOG4J_VERSION}/log4j-appserver-${LOG4J_VERSION}.jar" && \
    echo "${LOG4J_APPSERVER_SHA256}  /usr/local/tomcat/log4j/log4j-appserver.jar" | sha256sum -c - && \
    wget -q -O /usr/local/tomcat/log4j/log4j-api.jar "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/${LOG4J_VERSION}/log4j-api-${LOG4J_VERSION}.jar" && \
    echo "${LOG4J_API_SHA256}  /usr/local/tomcat/log4j/log4j-api.jar" | sha256sum -c - && \
    wget -q -O /usr/local/tomcat/log4j/log4j-core.jar "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/${LOG4J_VERSION}/log4j-core-${LOG4J_VERSION}.jar" && \
    echo "${LOG4J_CORE_SHA256}  /usr/local/tomcat/log4j/log4j-core.jar" | sha256sum -c - && \
    wget -q -O /usr/local/tomcat/log4j/log4j-layout-template-json.jar "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-layout-template-json/${LOG4J_VERSION}/log4j-layout-template-json-${LOG4J_VERSION}.jar" && \
    echo "${LOG4J_LAYOUT_TEMPLATE_JSON_SHA256}  /usr/local/tomcat/log4j/log4j-layout-template-json.jar" | sha256sum -c -

COPY import_self_signed_certs.sh set_timezone.sh docker-entrypoint.sh setenv.sh /usr/local/tomcat/bin/
COPY log4j2-tomcat.xml /usr/local/tomcat/log4j/log4j2-tomcat.xml
COPY javadump.sh /javadump.sh

RUN chmod 0755 /usr/local/tomcat/bin/import_self_signed_certs.sh \
      /usr/local/tomcat/bin/set_timezone.sh \
      /usr/local/tomcat/bin/docker-entrypoint.sh \
      /usr/local/tomcat/bin/setenv.sh \
      /javadump.sh && \
    chown -R root:root /usr/local/tomcat /opt/yjp /javadump.sh && \
    chmod -R go-w /usr/local/tomcat /opt/yjp /javadump.sh && \
    chmod -R a+rX /usr/local/tomcat /opt/yjp /javadump.sh && \
    chown -R 1001:1001 /home/tomcat \
      /usr/local/tomcat/logs \
      /usr/local/tomcat/temp \
      /usr/local/tomcat/work \
      /usr/local/tomcat/upload \
      /usr/local/tomcat/webapps && \
    chmod 0750 /home/tomcat /home/tomcat/.webratio \
      /usr/local/tomcat/logs \
      /usr/local/tomcat/temp \
      /usr/local/tomcat/work \
      /usr/local/tomcat/upload && \
    chmod 0770 /usr/local/tomcat/webapps

USER 1001:1001
ENTRYPOINT ["/usr/local/tomcat/bin/docker-entrypoint.sh"]
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
