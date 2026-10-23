# Java 11.0.32.1+1 / Temurin Noble

This context builds `webratio/java:11.0.32.1_1-temurin-noble` from `eclipse-temurin:11.0.32.1_1-jdk-noble@sha256:149ed37838b04397f2f3dbf3334d4a9f52a867e85e10cc3e6609de6467a56ea5` (base reference checked 2026-10-22).

The 16 impacted certificate SHA-256 fingerprints in `emudhra-blocked-sha256.txt`, from the eMudhra snapshot dated 2026-10-22, are appended to the JDK's `blocked.certs`. The JKS default workaround remains enabled in `$JAVA_HOME/conf/security/java.security`.

### Build

```sh
docker buildx build --platform linux/amd64,linux/arm64 --tag webratio/java:11.0.32.1_1-temurin-noble --push .
```