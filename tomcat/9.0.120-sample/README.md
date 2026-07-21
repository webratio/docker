# Tomcat 9.0.120 sample

This context extends the exact custom base tag `webratio/tomcat:9.0.120-jdk11-temurin-noble`. The official Tomcat sample WAR is downloaded and exploded into `webapps/ROOT` during the image build, then the WAR is removed. Tomcat therefore performs no runtime WAR expansion and the sample can run with a read-only root filesystem.

The baked application is root-owned and read-only to UID/GID `1001:1001`. Mount only the runtime paths documented by the base image; do not mount over `/usr/local/tomcat/webapps` for this baked sample.

### Installation

1. Install [Docker](https://www.docker.com/).

2. Pull the image 
  * `docker pull webratio/tomcat:9.0.120-sample`

### Image creation

1. Create and push the image
  * `docker buildx build --platform linux/amd64,linux/arm64 -t webratio/tomcat:9.0.120-sample --push .`