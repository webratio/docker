FROM redis:3.2.6

ENV PORT 26379
ENV MASTER_NAME master
ENV MASTER_IP 127.0.0.1
ENV MASTER_PORT 6379
ENV QUORUM 2
ENV DOWN_AFTER 30000
ENV FAILOVER_TIMEOUT 180000
ENV PARALLEL_SYNCS 1 

ADD sentinel.conf /etc/redis/sentinel.conf
ADD redis-sentinel-entrypoint.sh /
RUN chmod +x /redis-sentinel-entrypoint.sh 
ENTRYPOINT ["/redis-sentinel-entrypoint.sh"]
CMD []