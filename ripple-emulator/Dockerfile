FROM node

RUN npm install -g ripple-emulator
VOLUME ["/data"]
WORKDIR /data
EXPOSE 4400
ENTRYPOINT ["ripple", "emulate"]