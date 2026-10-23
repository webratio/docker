# Tomcat 9.0.123 sample application

This context builds `webratio/tomcat:9.0.123-jdk11.0.32.1_1-temurin-noble-sample` on the fixed release tag `webratio/tomcat:9.0.123-jdk11.0.32.1_1-temurin-noble`. After publishing that parent image, record and use its registry digest for immutable parent identity. No unpublished digest is asserted here.

The image installs Apache Tomcat's sample WAR as the root application and retains the parent's runtime UID/GID `1001:1001`. It inherits the parent's JDK certificate blocklist update.

### Build

```sh
docker buildx build --platform linux/amd64,linux/arm64 --tag webratio/tomcat:9.0.123-jdk11.0.32.1_1-temurin-noble-sample --push .
```
