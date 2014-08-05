## Ripple Emulate Dockerfile

This repository contains **Dockerfile** of [Apache Ripple](http://ripple.incubator.apache.org/) for [Docker](https://www.docker.com/)'s [build](https://registry.hub.docker.com/u/webratio/ripple-emulate/) published to the public [Docker Hub](https://hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. `docker pull webratio/ripple-emulator`

### Usage

    docker run -d -p <port>:4400 -v <application-dir>:/data webratio/ripple-emulator