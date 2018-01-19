FROM redis:3.2.6

RUN apt-get update && apt-get install -y --no-install-recommends ldnsutils

ENV MIN_SLAVES_TO_WRITE 1
ENV MIN_SLAVES_MAX_LAG 10
ENV SLAVE_ANNOUNCE_HOST localhost

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /redis

COPY redis.conf .

ENTRYPOINT ["entrypoint.sh"]
