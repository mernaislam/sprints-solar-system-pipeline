FROM node:18-alpine3.17

WORKDIR /usr/app

COPY package*.json .

RUN npm install

COPY . .

ENV MONGO_USERNAME=""
ENV MONGO_PASSWORD=""
ENV MONGO_URI=""

EXPOSE 3000

CMD ["npm", "start"]