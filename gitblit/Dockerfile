FROM jmoger/gitblit

# Disables the HTTPS port
RUN sed -e "s/server\.httpsPort\s=\s8443/server\.httpsPort=0/" \
        -e "s/server\.httpPort\s=\s0/server\.httpPort=80/" \
        -e "s/web\.enableRpcManagement\s=\sfalse/web\.enableRpcManagement=true/" \
        -e "s/web\.enableRpcAdministration\s=\sfalse/web.enableRpcAdministration=true/" \
        /opt/gitblit-data/defaults.properties > /opt/gitblit-data/gitblit.properties

