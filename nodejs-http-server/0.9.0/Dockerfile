FROM node:4

ENV HTTP_SERVER_VERSION 0.9.0
ENV PUBLIC_FOLDER /opt/www

RUN mkdir -p $PUBLIC_FOLDER
RUN npm install -g http-server@0.9.0

CMD http-server $PUBLIC_FOLDER

EXPOSE 8080