## Phonegap Dockerfile

This repository contains **Dockerfile** of [PhoneGap](http://phonegap.com/) for [Docker](https://www.docker.com/)'s [build](https://registry.hub.docker.com/u/webratio/phonegap/) published to the public [Docker Hub](https://hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. `docker pull webratio/phonegap`

### Usage

#### Run `phonegap serve`

    docker run -d -p <port>:3000 -v <application-dir>:/data webratio/phonegap phonegap serve