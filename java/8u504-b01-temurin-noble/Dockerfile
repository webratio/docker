FROM eclipse-temurin:8u504-b01-jdk-noble@sha256:30875dc74fbba9949689e87e62981c5361beb2baa578e85f6b8508b49f8a7bf7

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl dos2unix && \
    rm -rf /var/lib/apt/lists/*

COPY emudhra-blocked-sha256.txt /tmp/emudhra-blocked-sha256.txt
RUN set -eu; \
    blocklist="$JAVA_HOME/jre/lib/security/blacklisted.certs"; \
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