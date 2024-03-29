FROM node:21.5.0-bullseye as build

COPY . /app/
WORKDIR /app

RUN npm install

FROM node:21.5.0-bullseye as expressapp
LABEL org.opencontainers.image.source https://github.com/alexispet/final-test-MaximeDan

WORKDIR /app

COPY --from=build /app/package.json .
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/app.js .
COPY --from=build /app/database ./database

RUN ls -la

EXPOSE 3000

COPY docker/app/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT [ "docker-entrypoint" ]
CMD ["npm", "run", "start"]