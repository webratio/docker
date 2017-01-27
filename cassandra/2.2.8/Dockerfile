FROM cassandra:2.2.8

RUN apt-get update -y && \
    apt-get install -y curl && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
ADD http://central.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.6/jmx_prometheus_javaagent-0.6.jar /usr/app/jmx_prometheus_javaagent.jar
ADD prometheus-config.yml /usr/app/prometheus-config.yml
RUN chmod +r /usr/app/jmx_prometheus_javaagent.jar && \
    echo 'JVM_OPTS="$JVM_OPTS -javaagent:/usr/app/jmx_prometheus_javaagent.jar=${PROMETHEUS_PORT:-31500}:/usr/app/prometheus-config.yml"' >> $CASSANDRA_CONFIG/cassandra-env.sh
