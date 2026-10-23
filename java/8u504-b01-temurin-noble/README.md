# Java 8u504-b01 / Temurin Noble

This context builds `webratio/java:8u504-b01-temurin-noble` from `eclipse-temurin:8u504-b01-jdk-noble@sha256:30875dc74fbba9949689e87e62981c5361beb2baa578e85f6b8508b49f8a7bf7` (base reference checked 2026-10-22).

The 16 impacted certificate SHA-256 fingerprints in `emudhra-blocked-sha256.txt`, from the eMudhra snapshot dated 2026-10-22, are appended to the JDK's `blacklisted.certs`.

### Build

```sh
docker buildx build --platform linux/amd64,linux/arm64 --tag webratio/java:8u504-b01-temurin-noble --push .
```