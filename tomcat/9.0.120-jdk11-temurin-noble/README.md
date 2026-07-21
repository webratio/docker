# Tomcat 9.0.120 / Temurin JDK 11 / Ubuntu Noble

This context builds `webratio/tomcat:9.0.120-jdk11-temurin-noble` from the official Tomcat multi-architecture tag pinned to OCI index digest `sha256:14d4d540b19ac2221af48b483f11bd222bbd2032c4b736e9eaad5db713903cb6`.

The image runs as UID/GID `1001:1001`. At startup it copies the JDK truststore to `/usr/local/tomcat/temp/cacerts`, then imports any `*.cer` files mounted read-only at `/opt/certs`. For a read-only root filesystem, provide writable mounts for `/usr/local/tomcat/logs`, `/usr/local/tomcat/temp`, `/usr/local/tomcat/work`, `/usr/local/tomcat/upload`, `/usr/local/tomcat/webapps`, and `/home/tomcat`.

`/javadump.sh` writes to Tomcat's writable `temp` directory by default. Pass an explicit mounted path as its first argument for persistent dumps.

The connector limits request parameters to `10000` by default. Override `MAX_PARAMETER_COUNT` only after sizing and abuse-risk review.

### Installation

1. Install [Docker](https://www.docker.com/).

2. Pull the image 
  * `docker pull webratio/tomcat:9.0.120-jdk11-temurin-noble`

### Image creation

1. Create and push the image
  * `docker buildx build --platform linux/amd64,linux/arm64 -t webratio/tomcat:9.0.120-jdk11-temurin-noble --push .`