## Cordova Dockerfile

This repository contains **Dockerfile** of [Apache Cordova](http://cordova.apache.org/) for [Docker](https://www.docker.com/)'s [build](https://registry.hub.docker.com/u/webratio/cordova/) published to the public [Docker Hub](https://hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. `docker pull webratio/cordova`

### Usage

#### Run `cordova serve`

    docker run -d -p <port>:8000 -v <application-dir>:/data webratio/cordova cordova serve 8000