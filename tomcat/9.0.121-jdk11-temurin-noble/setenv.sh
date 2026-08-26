#!/bin/sh

JAVA_OPTS="${JAVA_OPTS:-} ${MORE_JAVA_OPTS:-} \
  -Xmx${JAVA_HEAP_SIZE} \
  -Xms${JAVA_HEAP_SIZE} \
  -XX:MaxMetaspaceSize=${JAVA_METASPACE_SIZE} \
  -XX:+IgnoreUnrecognizedVMOptions \
  -XX:+UseCompressedOops \
  -server \
  -Djava.security.egd=file:/dev/./urandom \
  -Djavax.net.ssl.trustStore=/usr/local/tomcat/temp/cacerts \
  -Djavax.net.ssl.trustStorePassword=changeit \
  -Duser.timezone=${TZ:-Europe/Rome}"

CATALINA_OPTS="${CATALINA_OPTS:-} ${MORE_CATALINA_OPTS:-} \
  -Dorg.apache.jasper.runtime.JspFactoryImpl.USE_POOL=false \
  -Dorg.apache.tomcat.util.digester.PROPERTY_SOURCE=org.apache.tomcat.util.digester.EnvironmentPropertySource"

CLASSPATH="/usr/local/tomcat/log4j/log4j-appserver.jar:/usr/local/tomcat/log4j/log4j-api.jar:/usr/local/tomcat/log4j/log4j-core.jar:/usr/local/tomcat/log4j/log4j-layout-template-json.jar:/usr/local/tomcat/log4j:${CLASSPATH:-}"

if [ "${DEBUG:-false}" = "true" ]; then
  case "$JAVA_OPTS" in
    *jdwp*) ;;
    *) JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000" ;;
  esac
fi

if [ "${PROFILING:-false}" = "true" ]; then
  case "$JAVA_OPTS" in
    *libyjpagent*) ;;
    *)
      case "$(uname -m)" in
        x86_64|amd64) profiler_arch=linux-x86-64 ;;
        aarch64|arm64) profiler_arch=linux-arm-64 ;;
        *)
          echo "ERROR: unsupported or unavailable YourKit agent for architecture $(uname -m)" >&2
          exit 1
          ;;
      esac
      profiler_agent="/opt/yjp/YourKit-JavaProfiler-2019.1/bin/${profiler_arch}/libyjpagent.so"
      if ! [ -r "$profiler_agent" ]; then
        echo "ERROR: unsupported or unavailable YourKit agent for architecture $(uname -m)" >&2
        exit 1
      fi
      JAVA_OPTS="$JAVA_OPTS -agentpath:${profiler_agent}=disablestacktelemetry,disableexceptiontelemetry,probe_disable=com.yourkit.probes.builtin.*,delay=10000,port=10001,listen=all"
      ;;
  esac
fi
