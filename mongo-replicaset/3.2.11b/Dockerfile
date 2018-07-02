FROM mongo:3.2.11

RUN apt-get update -y && \
    apt-get install -y python python-pip python-virtualenv dos2unix && \
    mkdir /aws && \
    virtualenv /aws/env && \
    /aws/env/bin/pip install awscli && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD rs-init.sh /
ADD rs-reconfig.sh /
ADD rs-status.sh /
ADD backup.sh /
RUN chmod +x /rs-init.sh /rs-reconfig.sh /rs-status.sh /backup.sh

ADD mongo-cluster-entrypoint.sh /
RUN chmod +x /mongo-cluster-entrypoint.sh
ENTRYPOINT ["/mongo-cluster-entrypoint.sh"]