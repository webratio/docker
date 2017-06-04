## PhoneGap Dockerfile

This repository contains **Dockerfile** of [PhoneGap](http://phonegap.com/) for [Docker](https://www.docker.com/)'s [build](https://registry.hub.docker.com/u/nmaas87/webratio-phonegap/) published to the public [Docker Hub](https://hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. Pull the image
  * `docker pull nmaas87/webratio-phonegap`
  * `docker pull nmaas87/webratio-phonegap:3.5.0`
  * `docker pull nmaas87/webratio-phonegap:3.5.0-0.21.18`
  * `docker pull nmaas87/webratio-phonegap:3.6.0`
  * `docker pull nmaas87/webratio-phonegap:3.6.0-0.21.19`
  * `docker pull nmaas87/webratio-phonegap:3.6.3`
  * `docker pull nmaas87/webratio-phonegap:3.6.3-0.22.7`
  * `docker pull nmaas87/webratio-phonegap:4.0.0`
  * `docker pull nmaas87/webratio-phonegap:4.0.0-0.22.7`
  * `docker pull nmaas87/webratio-phonegap:4.1.2`
  * `docker pull nmaas87/webratio-phonegap:4.1.2-0.22.12`
  * `docker pull nmaas87/webratio-phonegap:4.2.0`
  * `docker pull nmaas87/webratio-phonegap:4.2.0-0.24.2`
  * `docker pull nmaas87/webratio-phonegap:6.0.3`
  * `docker pull nmaas87/webratio-phonegap:6.1.0`
  * `docker pull nmaas87/webratio-phonegap:6.2.0`
  * `docker pull nmaas87/webratio-phonegap:6.2.2`
  * `docker pull nmaas87/webratio-phonegap:6.4.2`
  * `docker pull nmaas87/webratio-phonegap:6.5.0`
  
### Usage

#### Run `phonegap create`

    docker run -v <application-parent-dir>:/data nmaas87/webratio-phonegap phonegap create <application-name>

#### Run `phonegap serve`

    docker run -d -p <port>:3000 -v <application-dir>:/data nmaas87/webratio-phonegap phonegap serve -p 3000

#### Run `phonegap build android`

    docker run -v <application-dir>:/data nmaas87/webratio-phonegap phonegap build android
