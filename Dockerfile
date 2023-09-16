FROM node:latest AS build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

RUN npm install pm2 -g

COPY . .

# Stage 2: Create a minimal production image
FROM node:latest

WORKDIR /usr/src/app

COPY . /usr/src/app

COPY --from=build /usr/src/app/package*.json ./

RUN npm install

RUN npm install pm2 -g

EXPOSE 3000

CMD ["pm2-runtime", "index.js"]

