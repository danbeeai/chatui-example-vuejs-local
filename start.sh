#!/bin/sh

cd /app/web
[ ! -L "node_modules" ] && ln -s /app/web2/node_modules node_modules

npm run dev
