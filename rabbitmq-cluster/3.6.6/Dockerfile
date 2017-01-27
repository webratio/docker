FROM rabbitmq:3.6.6

RUN rabbitmq-plugins enable --offline rabbitmq_management

EXPOSE 15671 15672

ADD rabbitmq-cluster-entrypoint.sh /
RUN chmod +x /rabbitmq-cluster-entrypoint.sh
ENTRYPOINT ["/rabbitmq-cluster-entrypoint.sh"]
CMD []