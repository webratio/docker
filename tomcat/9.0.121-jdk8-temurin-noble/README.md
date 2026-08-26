# Tomcat 9.0.121 / Temurin JDK 8 / Ubuntu Noble

This context builds `webratio/tomcat:9.0.121-jdk8-temurin-noble` from the official Tomcat multi-architecture tag pinned to OCI index digest `sha256:e24e53508b465f13726bd630278b360108961a9976c8caa89a1ad59f6785dcb8`.

The image runs as UID/GID `1001:1001`. At startup it copies the JDK truststore to `/usr/local/tomcat/temp/cacerts`, then imports any `*.cer` files mounted read-only at `/opt/certs`. For a read-only root filesystem, provide writable mounts for `/usr/local/tomcat/logs`, `/usr/local/tomcat/temp`, `/usr/local/tomcat/work`, `/usr/local/tomcat/upload`, `/usr/local/tomcat/webapps`, and `/home/tomcat`.

`/javadump.sh` writes to Tomcat's writable `temp` directory by default. Pass an explicit mounted path as its first argument for persistent dumps.

The connector limits request parameters to `10000` by default. Override `MAX_PARAMETER_COUNT` only after sizing and abuse-risk review.

### Installation

1. Install [Docker](https://www.docker.com/).

2. Pull the image 
  * `docker pull webratio/tomcat:9.0.121-jdk8-temurin-noble`

### Image creation

1. Create and push the image
  * `docker buildx build --platform linux/amd64,linux/arm64 -t webratio/tomcat:9.0.121-jdk8-temurin-noble --push .`