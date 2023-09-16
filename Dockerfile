FROM node:10 AS build

WORKDIR /usr/app

COPY package*.json ./

RUN npm install

RUN npm install pm2 -g

COPY . .

# Stage 2: Create a minimal production image
FROM node:10

WORKDIR /usr/app

COPY . /usr/app

COPY --from=build /usr/app/package*.json ./

RUN npm install pm2 -g

EXPOSE 3000

CMD ["pm2-runtime", "index.js"]

