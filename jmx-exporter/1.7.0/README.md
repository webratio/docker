# JMX Exporter 1.7.0 with Log4j 2

This image uses the official Prometheus JMX Exporter 1.7.0 standalone JAR on Eclipse Temurin Java 21, with the four Log4j 2.25.4 JARs. The image runs as numeric UID:GID 1001:1001.

## Build and tag

~~~sh
docker buildx build --platform linux/amd64,linux/arm64 --tag docker.io/webratio/jmx-exporter:1.7.0 --push .
~~~

## Upstream and Java compatibility

The exporter JAR comes from the official prometheus/jmx_exporter 1.7.0 release. Its manifest identifies version 1.7.0, main class io.prometheus.jmx.Standalone, and Java version 8. The release source configures Maven compiler release 8, so the JRE 21 base is compatible.

The base image is docker.io/library/eclipse-temurin:21-jre-noble, pinned to a multi-architecture registry digest. Both its linux/amd64 and linux/arm64 manifests were verified.
