FROM node:18-alpine

WORKDIR /app

COPY package.json .
COPY server.js .

ARG APP_VERSION=v1
ENV APP_VERSION=$APP_VERSION

EXPOSE 8080

CMD ["npm", "start"]

