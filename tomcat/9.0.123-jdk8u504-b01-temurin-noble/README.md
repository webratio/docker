# Tomcat 9.0.123 / Temurin Java 8 / Ubuntu Noble

This context builds `webratio/tomcat:9.0.123-jdk8u504-b01-temurin-noble` from the official `tomcat:9.0.123-jdk8-temurin-noble@sha256:511f4cc095ebf43014892703080ac7b718d8a600d804c9e4525035ec18e02ed5` OCI image index. It uses the Temurin Java 8 runtime supplied by that pinned base image.

The certificate blocklist update adds the 16 impacted certificate SHA-256 fingerprints in `emudhra-blocked-sha256.txt` to the JDK certificate blocklist. The fingerprints come from the [eMudhra impacted-intermediates snapshot](https://emudhra.we-have-a-problem.com/impacted-intermediates.json), captured 2026-10-22.

The image runs as UID/GID `1001:1001`. At startup it copies the JDK truststore to `/usr/local/tomcat/temp/cacerts` and imports any `*.cer` files mounted read-only at `/opt/certs`. For a read-only root filesystem, provide writable mounts for `/usr/local/tomcat/logs`, `/usr/local/tomcat/temp`, `/usr/local/tomcat/work`, `/usr/local/tomcat/upload`, `/usr/local/tomcat/webapps`, and `/home/tomcat`.

`/javadump.sh` writes to Tomcat's writable `temp` directory by default. Pass an explicit mounted path as its first argument for persistent dumps. The connector limits request parameters to `10000` by default.

### Build

```sh
docker buildx build --platform linux/amd64,linux/arm64 --tag webratio/tomcat:9.0.123-jdk8u504-b01-temurin-noble --push .
```
