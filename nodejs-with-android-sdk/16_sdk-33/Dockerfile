FROM webratio/android-sdk:r33.0.2

# Installs Nodesource GPG key to work around a bug in the Node install script
RUN apt-get update && \
    apt-get install -y gnupg && \
    curl --silent https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

# Installs Node.js
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean
