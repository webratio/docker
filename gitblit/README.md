## Gitblit Dockerfile

This repository contains **Dockerfile** of [Gitblit](http://gitblit.com/) for [Docker](https://www.docker.com/)'s [build](https://registry.hub.docker.com/u/webratio/phonegap/) published to the public [Docker Hub](https://hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. `docker pull webratio/gitblit`

### Usage

    docker run -d -p 80:80 -p 9418:9418 -p 29418:29418 webratio/gitblit
