FROM postgres:8.4

RUN apt-get update \
    && apt-get install -y postgresql-plperl-8.4=8.4.22-1.pgdg70+1 \
    && rm -rf /var/lib/apt/lists/*