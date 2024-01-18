#!/bin/sh

if [ "$NODE_ENV" = "development" ]; then
    echo "Run npm install in development mode"
    npm install
fi

echo "Exécution de npm import DB"

npm run db:import

echo "Import DB OK"
echo "-------------------------------------"

exec "$@"