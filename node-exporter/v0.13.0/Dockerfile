FROM prom/node-exporter:v0.13.0

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENV "NODE_EXPORTER_BIN=/bin/node_exporter"

ENTRYPOINT  [ "/docker-entrypoint.sh" ]
CMD [ "/bin/node_exporter" ]