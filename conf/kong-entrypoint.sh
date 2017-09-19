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

# remove hosts configs for busted tests
sed -i '/dns_hostsfile = spec\/fixtures\/hosts/d' /kong/spec/kong_tests.conf

# run kong migrations
kong migrations up

exec "$@"
