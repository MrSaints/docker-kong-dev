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

# Remove Kong specified `hosts` file as it conflicts
# with the `hosts` modifications made by Docker (Compose)
sed -i '/dns_hostsfile = spec\/fixtures\/hosts/d' /kong/spec/kong_tests.conf

# Run Kong migrations
# As of 0.11.0, migrations are not executed automatically
# on `kong start`
kong migrations up

exec "$@"
