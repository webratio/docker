## Groovy Dockerfile

This repository contains **Dockerfile** of [Groovy](http://groovy.codehaus.org/) for [Docker](https://www.docker.com/)'s [build](https://registry.hub.docker.com/u/webratio/groovy/) published to the public [Docker Hub](https://hub.docker.com/).

### Installation

1. Install [Docker](https://www.docker.com/).

2. `docker pull webratio/groovy`

### Usage

    docker run -v $(pwd):/source -v <grape-root-dir>:/graperoot webratio/groovy <groovy-file> 
