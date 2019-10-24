FROM rabbitmq:3.8.1-beta.1

RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_prometheus

RUN apt-get update && apt-get install -y --no-install-recommends ldnsutils jq && apt-get -y autoclean && rm -rf /var/lib/apt/lists/*;

ADD rabbitmq.config /etc/rabbitmq/

RUN chmod u+rw /etc/rabbitmq/rabbitmq.config \
	&& chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.config

ADD rabbitmq-cluster-entrypoint.sh /
RUN chmod +x /rabbitmq-cluster-entrypoint.sh
ENTRYPOINT ["/rabbitmq-cluster-entrypoint.sh"]
CMD []
