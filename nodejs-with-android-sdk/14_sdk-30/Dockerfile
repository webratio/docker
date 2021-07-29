FROM webratio/android-sdk:r30.0.3

# Installs Nodesource GPG key to work around a bug in the Node install script
RUN curl --silent https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -

# Installs Node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - && \
    sudo apt-get install -y nodejs
