#!/bin/bash
set -e

if [[ "$1" = '--nowait' || "$1" = '-W' ]]; then
    echo "Skip waiting for DB..."
else
    while ! (echo > /dev/tcp/postgres/5432) >/dev/null 2>&1
    do
        echo "Waiting for DB..."
        sleep 1
    done
fi

exec "$@"