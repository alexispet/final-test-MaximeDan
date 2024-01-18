FROM node:21.5.0-bullseye as build

COPY . /app/
WORKDIR /app

RUN npm install

FROM node:21.5.0-bullseye as expressapp

WORKDIR /app

COPY --from=build /app/package.json .
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/app.js .
COPY --from=build /app/database/init-db.js ./database

EXPOSE 3000

COPY docker/app/docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT [ "docker-entrypoint" ]
CMD ["npm", "run", "start"]