# syntax=docker/dockerfile:1.6
FROM docker.io/library/eclipse-temurin:21-jre-noble@sha256:0eda5830ed7b669abc246a8dc520ea8a23cab06f9a8d4b6964109e2f2394e46f

RUN mkdir -p -m 0755 /opt/jmx-exporter /opt/log4j

ADD --checksum=sha256:f62f518d3a396320e4604d6981b6c4f4bd8a4fa46e6200791cf501cb3c6ddd44 --chmod=0444 https://github.com/prometheus/jmx_exporter/releases/download/1.7.0/jmx_prometheus_standalone-1.7.0.jar /opt/jmx-exporter/jmx_prometheus_standalone.jar
ADD --checksum=sha256:c4b642a7f047275215de117e0e3847eb2c7711d84a0aa7433e7b3c096daf341d --chmod=0444 https://repo.maven.apache.org/maven2/org/apache/logging/log4j/log4j-api/2.25.4/log4j-api-2.25.4.jar /opt/log4j/
ADD --checksum=sha256:10fee2c0485d54fa44ee75d314f6295508f7b932281873db61a91b88073200e6 --chmod=0444 https://repo.maven.apache.org/maven2/org/apache/logging/log4j/log4j-core/2.25.4/log4j-core-2.25.4.jar /opt/log4j/
ADD --checksum=sha256:a2f8d03f39ff62de75d4524c9ee085f167e201da91652141097a60643ce22e85 --chmod=0444 https://repo.maven.apache.org/maven2/org/apache/logging/log4j/log4j-layout-template-json/2.25.4/log4j-layout-template-json-2.25.4.jar /opt/log4j/
ADD --checksum=sha256:6eecb5a7db1e9600e110c93bc014296871ddcdcf0a732a71b16f1f652ae21d41 --chmod=0444 https://repo.maven.apache.org/maven2/org/apache/logging/log4j/log4j-jul/2.25.4/log4j-jul-2.25.4.jar /opt/log4j/

WORKDIR /opt/jmx-exporter
USER 1001:1001
ENTRYPOINT ["java", "-jar", "/opt/jmx-exporter/jmx_prometheus_standalone.jar"]
