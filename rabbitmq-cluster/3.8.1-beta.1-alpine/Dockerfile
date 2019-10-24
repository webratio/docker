FROM rabbitmq:3.8.1-beta.1-alpine

RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_prometheus

RUN apk --no-cache add drill jq

ADD rabbitmq.config /etc/rabbitmq/

RUN chmod u+rw /etc/rabbitmq/rabbitmq.config \
	&& chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.config

ADD rabbitmq-cluster-entrypoint.sh /
RUN chmod +x /rabbitmq-cluster-entrypoint.sh
ENTRYPOINT ["/rabbitmq-cluster-entrypoint.sh"]
CMD []
