## Gitblit Image Build

This repository is a placeholder with instructions for re-building the `gitblit/gitblit` image of [Gitblit](http://gitblit.com/) for [Docker](https://www.docker.com/)'s [build](https://registry.hub.docker.com/u/webratio/phonegap/) published to the public [Docker Hub](https://hub.docker.com/).

Rebuilding is necessary for supporting architectures beyond `amd64`.

### Instructions

    docker buildx build --platform linux/amd64,linux/arm64/v8 --tag webratio/gitblit:1.9.1-vanilla --push https://github.com/gitblit/gitblit-docker.git#v1.9.1-1

