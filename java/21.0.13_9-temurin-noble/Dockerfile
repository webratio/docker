FROM eclipse-temurin:21.0.13_9-jdk-noble@sha256:114cabb73033ca4ce7ceec3deb62396bc1b716282bae051ed3c1d82e38fcab2d

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl dos2unix && \
    rm -rf /var/lib/apt/lists/*

# Keep the existing JKS default for applications that rely on it.
RUN sed -i 's/keystore.type=pkcs12/keystore.type=jks/' "$JAVA_HOME/conf/security/java.security"

COPY emudhra-blocked-sha256.txt /tmp/emudhra-blocked-sha256.txt
RUN set -eu; \
    blocklist="$JAVA_HOME/lib/security/blocked.certs"; \
    test -r "$blocklist"; \
    test "$(head -n 1 "$blocklist")" = "Algorithm=SHA-256"; \
    test "$(grep -c '^Algorithm=' "$blocklist")" -eq 1; \
    while IFS= read -r hash; do \
      case "$hash" in ''|\#*) continue ;; esac; \
      if ! grep -Fxq "$hash" "$blocklist"; then \
        if [ -s "$blocklist" ] && [ "$(tail -c 1 "$blocklist" | wc -l)" -eq 0 ]; then \
          printf '\n' >> "$blocklist"; \
        fi; \
        printf '%s\n' "$hash" >> "$blocklist"; \
      fi; \
    done < /tmp/emudhra-blocked-sha256.txt; \
    chmod 0644 "$blocklist"