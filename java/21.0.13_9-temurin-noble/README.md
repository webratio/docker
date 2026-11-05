# Java 21.0.13+9 / Temurin Noble

This context builds `webratio/java:21.0.13_9-temurin-noble`.

The 16 impacted certificate SHA-256 fingerprints in `emudhra-blocked-sha256.txt`, from the eMudhra snapshot dated 2026-10-22, are appended to the JDK's `blocked.certs`. The JKS default workaround remains enabled in `$JAVA_HOME/conf/security/java.security`.

### Build

```sh
docker buildx build --platform linux/amd64,linux/arm64 --tag webratio/java:21.0.13_9-temurin-noble --push .
```