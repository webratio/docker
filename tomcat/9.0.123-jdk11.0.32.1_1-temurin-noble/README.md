# Tomcat 9.0.123 / Temurin Java 11 / Ubuntu Noble

This context builds `webratio/tomcat:9.0.123-jdk11.0.32.1_1-temurin-noble` from the official `tomcat:9.0.123-jdk11-temurin-noble@sha256:1ec188cb1cea9e8cebab1db0ec56a8184f191a4864d6539a6e07f952b4616321` OCI image index. It uses the Temurin Java 11 runtime supplied by that pinned base image.

The certificate blocklist update adds the 16 impacted certificate SHA-256 fingerprints in `emudhra-blocked-sha256.txt` to the JDK certificate blocklist. The fingerprints come from the [eMudhra impacted-intermediates snapshot](https://emudhra.we-have-a-problem.com/impacted-intermediates.json), captured 2026-10-22.

The image runs as UID/GID `1001:1001`. At startup it copies the JDK truststore to `/usr/local/tomcat/temp/cacerts` and imports any `*.cer` files mounted read-only at `/opt/certs`. For a read-only root filesystem, provide writable mounts for `/usr/local/tomcat/logs`, `/usr/local/tomcat/temp`, `/usr/local/tomcat/work`, `/usr/local/tomcat/upload`, `/usr/local/tomcat/webapps`, and `/home/tomcat`.

`/javadump.sh` writes to Tomcat's writable `temp` directory by default. Pass an explicit mounted path as its first argument for persistent dumps. The connector limits request parameters to `10000` by default.

### Build

```sh
docker buildx build --platform linux/amd64,linux/arm64 --tag webratio/tomcat:9.0.123-jdk11.0.32.1_1-temurin-noble --push .
```
