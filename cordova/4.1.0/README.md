## Cordova Dockerfile

This repository contains **Dockerfile** of [Cordova](http://cordova.apache.org/) for [Docker](https://www.docker.com/)'s [build](https://registry.hub.docker.com/u/webratio/cordova/) published to the public [Docker Hub](https://hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. Pull the image
  * `docker pull webratio/cordova`
  * `docker pull webratio/cordova:3.5`
  * `docker pull webratio/cordova:3.5.0-0.2.7`
  * `docker pull webratio/cordova:3.6`
  * `docker pull webratio/cordova:3.6.3-0.2.13`
  * `docker pull webratio/cordova:4.0`
  * `docker pull webratio/cordova:4.0.1`
  * `docker pull webratio/cordova:4.1`
  * `docker pull webratio/cordova:4.1.0`

### Usage

#### Run `cordova create`

    docker run -v <app-parent-dir>:/data webratio/cordova cordova create <app-name>

#### Run `cordova platform add android`

    docker run -v <app-dir>:/data webratio/cordova cordova platform add android

#### Run `cordova build android`

    docker run -v <app-dir>:/data webratio/cordova cordova build android
