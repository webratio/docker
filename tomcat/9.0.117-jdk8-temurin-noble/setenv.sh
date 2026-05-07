#!/bin/sh

JAVA_OPTS="${MORE_JAVA_OPTS} \
  -Xmx${JAVA_HEAP_SIZE} \
  -Xms${JAVA_HEAP_SIZE} \
  -XX:MaxMetaspaceSize=${JAVA_METASPACE_SIZE} \
  -XX:+IgnoreUnrecognizedVMOptions \
  -XX:+UseCompressedOops \
  -server \
  -Djava.security.egd=file:/dev/./urandom"

CATALINA_OPTS="${MORE_CATALINA_OPTS} \
  -Dorg.apache.jasper.runtime.JspFactoryImpl.USE_POOL=false \
  -Dorg.apache.tomcat.util.digester.PROPERTY_SOURCE=org.apache.tomcat.util.digester.EnvironmentPropertySource"

CLASSPATH="\
/usr/local/tomcat/log4j/log4j-appserver.jar:\
/usr/local/tomcat/log4j/log4j-api.jar:\
/usr/local/tomcat/log4j/log4j-core.jar:\
/usr/local/tomcat/log4j/log4j-layout-template-json.jar:\
/usr/local/tomcat/log4j:\
${CLASSPATH:-}"

if [ "$DEBUG" = "true" ]; then
  echo "DEBUG: Remote debugging enabled on port 8000"
  case "$JAVA_OPTS" in
    *jdwp*) ;;
    *) JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=0.0.0.0:8000" ;;
  esac
fi

if [ "$PROFILING" = "true" ]; then
  echo "PROFILER: YourKit agent enabled on port 10001"
  case "$JAVA_OPTS" in
    *libyjpagent*) ;;
    *) JAVA_OPTS="$JAVA_OPTS -agentpath:/opt/yjp/YourKit-JavaProfiler-2019.1/bin/linux-x86-64/libyjpagent.so=disablestacktelemetry,disableexceptiontelemetry,probe_disable=com.yourkit.probes.builtin.*,delay=10000,port=10001,listen=all" ;;
  esac
fi