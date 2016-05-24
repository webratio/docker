## http-server Dockerfile

This repository contains **Dockerfile** of [http-server](https://github.com/indexzero/http-server/) published to the public [Docker Hub](https://hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. Pull the image
  * `docker pull webratio/nodejs-http-server:0.9.0`

### Usage

    docker run -v <resource-dir>:/opt/www -p <port>:8080 
  