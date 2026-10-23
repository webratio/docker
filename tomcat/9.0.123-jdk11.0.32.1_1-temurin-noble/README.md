# Tomcat 9.0.123 / Temurin Java 11 / Ubuntu Noble

This context builds `webratio/tomcat:9.0.123-jdk11.0.32.1_1-temurin-noble` from the official `tomcat:9.0.123-jdk11-temurin-noble@sha256:1ec188cb1cea9e8cebab1db0ec56a8184f191a4864d6539a6e07f952b4616321` OCI image index (reference checked 2026-10-22). It uses the Temurin Java 11 runtime supplied by that pinned base image.

The certificate blocklist update adds the 16 impacted certificate SHA-256 fingerprints in `emudhra-blocked-sha256.txt` to the JDK certificate blocklist. The fingerprints come from the [eMudhra impacted-intermediates snapshot](https://emudhra.we-have-a-problem.com/impacted-intermediates.json), captured 2026-10-22.

The image includes MySQL Connector/J `26.10.0` from [Maven Central](https://repo.maven.apache.org/maven2/com/mysql/mysql-connector-j/26.10.0/mysql-connector-j-26.10.0.jar), SHA-256 `cef70caf532833c9ab8f41f74773ce22c08bf503fad215c9c2ee1e9db87e759e`. The selected driver supports MySQL 8.4 and newer, as confirmed for this release.

The PostgreSQL JDBC driver is `42.7.14` from [jdbc.postgresql.org](https://jdbc.postgresql.org/download/postgresql-42.7.14.jar), SHA-256 `73914527305a40cce504b0d3d90b23caf565136912d607ae8ae7c5895512332c`. Driver coordinates, source URLs, and SHA-256 values recorded here were verified on 2026-10-22. Other helpers, Log4j, profiler settings, and runtime defaults are carried forward from the 9.0.122 context.

The image runs as UID/GID `1001:1001`. At startup it copies the JDK truststore to `/usr/local/tomcat/temp/cacerts` and imports any `*.cer` files mounted read-only at `/opt/certs`. For a read-only root filesystem, provide writable mounts for `/usr/local/tomcat/logs`, `/usr/local/tomcat/temp`, `/usr/local/tomcat/work`, `/usr/local/tomcat/upload`, `/usr/local/tomcat/webapps`, and `/home/tomcat`.

`/javadump.sh` writes to Tomcat's writable `temp` directory by default. Pass an explicit mounted path as its first argument for persistent dumps. The connector limits request parameters to `10000` by default.

### Build

```sh
docker buildx build --platform linux/amd64,linux/arm64 --tag webratio/tomcat:9.0.123-jdk11.0.32.1_1-temurin-noble --push .
```