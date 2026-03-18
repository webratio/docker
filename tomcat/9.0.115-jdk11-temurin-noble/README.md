## Java Dockerfile

This repository contains **Dockerfile** of [Tomcat](https://tomcat.apache.org/) for [Docker](https://www.docker.com/)'s [build](https://registry.hub.docker.com/u/webratio/tomcat/) published to the public [Docker Hub](https://hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. Pull the image 
  * `docker pull webratio/tomcat:9.0.115-jdk11-temurin-noble`

### Image creation

1. Create and push the image
  * `docker buildx build --platform linux/amd64,linux/arm64 -t webratio/tomcat:9.0.115-jdk11-temurin-noble --push .`