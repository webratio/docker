FROM webratio/gitblit:1.9.1-vanilla

# Update JNA to support arm64 (aka aarch64)
RUN rm /opt/gitblit/ext/jna-*.jar \
 && wget -O /opt/gitblit/ext/jna-4.5.2.jar https://repo1.maven.org/maven2/net/java/dev/jna/jna/4.5.2/jna-4.5.2.jar \
 && wget -O /opt/gitblit/ext/jna-platform-4.5.2.jar https://repo1.maven.org/maven2/net/java/dev/jna/jna-platform/4.5.2/jna-platform-4.5.2.jar

# Disables the HTTPS, use 80 for HTTP, enable RPC interface
RUN echo \
server.httpPort = 80 \\n\
server.httpsPort = 0 \\n\
server.redirectToHttpsPort = false \\n\
web.enableRpcServlet = true \\n\
web.enableRpcManagement = true \\n\
web.enableRpcAdministration = true \\n\
>> /var/opt/gitblit/etc/gitblit.properties

# Expose ports for --link
EXPOSE 80

