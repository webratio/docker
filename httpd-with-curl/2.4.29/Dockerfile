FROM httpd:2.4.29
    
RUN apt-get update -y && \
    apt-get install -y curl dos2unix && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*