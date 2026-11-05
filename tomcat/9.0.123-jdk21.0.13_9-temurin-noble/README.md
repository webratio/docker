# Tomcat 9.0.123 / Temurin Java 21 / Ubuntu Noble

This context builds `webratio/tomcat:9.0.123-jdk21.0.13_9-temurin-noble` from the official `tomcat:9.0.123-jdk21-temurin-noble@sha256:e4038d9ad82ee83bc84e3a68ef7c2ea1ee8902e5ae887754f9a146362479509d` OCI image index (reference checked 2026-10-22). It uses the Temurin Java 21 runtime supplied by that pinned base image.

The certificate blocklist update adds the 16 impacted certificate SHA-256 fingerprints in `emudhra-blocked-sha256.txt` to the JDK certificate blocklist. The fingerprints come from the [eMudhra impacted-intermediates snapshot](https://emudhra.we-have-a-problem.com/impacted-intermediates.json), captured 2026-10-22.

The image includes MySQL Connector/J `26.10.0` from [Maven Central](https://repo.maven.apache.org/maven2/com/mysql/mysql-connector-j/26.10.0/mysql-connector-j-26.10.0.jar), SHA-256 `cef70caf532833c9ab8f41f74773ce22c08bf503fad215c9c2ee1e9db87e759e`. The selected driver supports MySQL 8.4 and newer, as confirmed for this release.

The PostgreSQL JDBC driver is `42.7.14` from [jdbc.postgresql.org](https://jdbc.postgresql.org/download/postgresql-42.7.14.jar), SHA-256 `73914527305a40cce504b0d3d90b23caf565136912d607ae8ae7c5895512332c`. Driver coordinates, source URLs, and SHA-256 values recorded here were verified on 2026-10-22. Other helpers, Log4j, and runtime defaults are carried forward; YourKit is configured for version 2026.9.149 (architectures amd64 and arm64).

The image runs as UID/GID `1001:1001`. At startup it copies the JDK truststore to `/usr/local/tomcat/temp/cacerts` and imports any `*.cer` files mounted read-only at `/opt/certs`. For a read-only root filesystem, provide writable mounts for `/usr/local/tomcat/logs`, `/usr/local/tomcat/temp`, `/usr/local/tomcat/work`, `/usr/local/tomcat/upload`, `/usr/local/tomcat/webapps`, and `/home/tomcat`.

`/javadump.sh` writes to Tomcat's writable `temp` directory by default. Pass an explicit mounted path as its first argument for persistent dumps. The connector limits request parameters to `10000` by default.

### Build

```sh
docker buildx build --platform linux/amd64,linux/arm64 --tag webratio/tomcat:9.0.123-jdk21.0.13_9-temurin-noble --push .
```
