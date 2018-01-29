FROM alpine:3.4

RUN  apk add --update rsyslog rsyslog-tls logrotate\
  && rm -rf /var/cache/apk/*

RUN mkdir -p /var/log/remote/ \
    && mkdir -p /var/spool/rsyslog \
    && chmod 644 /var/log/remote/ -R && chmod 644 /var/spool/rsyslog


EXPOSE 10514/udp

VOLUME [ "/var/log", "/etc/rsyslog.d" ]

COPY ./etc/rsyslog.conf /etc/rsyslog.conf
COPY ./etc/logrotate.conf /etc/logrotate.conf

RUN chmod 644 /etc/logrotate.conf
RUN chmod 644 /etc/rsyslog.conf

COPY ./rsyslog.d/* /etc/rsyslog.d/

COPY run-logrotate /run-logrotate
COPY entrypoint.sh /entrypoint.sh

RUN chmod 755 /run-logrotate
RUN chmod 755 /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
#Only for debug ENTRYPOINT [ "sh" ]
