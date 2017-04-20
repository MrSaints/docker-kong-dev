# docker-kong-dev

[![](https://images.microbadger.com/badges/image/mrsaints/kong-dev.svg)](https://microbadger.com/images/mrsaints/kong-dev "Get your own image badge on microbadger.com")

_A work in progress. Use at your own discretion. A basic understanding of Docker, Compose, and Kong is required._

An unofficial Docker image (tooling) for [Kong][kong] testing, and development.

    Kong is a scalable, open source API Layer (also known as an API Gateway, or API Middleware)... Backed by the battle-tested NGINX with a focus on high performance.

This repository provides lightweight tooling for testing, and developing Kong.
It is intended to serve as an unofficial, easy-to-use, alternative to [kong-vagrant][] for developing on Kong or on custom plugins.
Some manual labour however, is still required (e.g. Mounting directories, setting environment variables / flags, etc).

The [`mrsaints/kong-dev`][kong-dev] image contains all the necessary dependencies to run, test, and develop Kong (e.g. OpenResty, luarocks, Serf, and Kong).
It is a fork of [`openresty/openresty:alpine-fat`][openresty-docker].


## Getting Started

To get started, clone this repository, and modify the `docker-compose.yml` file if you would like to mount your local Kong repository or your custom plugin source code.
Alternatively, you can clone the [`Mashape/kong-plugin`][kong-plugin] boilerplate into this directory to begin working on your custom plugin. The [`Mashape/kong`][kong] repository can also be cloned into this directory.

Once ready, run `docker-compose run --rm --service-ports kong bash`, and you can begin running commands like `kong start -v`.
_The database might take a while to start up. There is no entrypoint for Kong to wait for the database._

No restarts should be needed for local changes to be reflected (assuming the code is mounted). The default log level has also been set to `DEBUG`.


## Tests

Tests must execute Kong in daemon mode otherwise they will hang (i.e. `KONG_NGINX_DAEMON=on`, note the `on`).

To run tests for your custom plugin (assuming it is in `/kong-plugin/spec`):

```
export LUA_PATH="/kong-plugin/?.lua;/kong-plugin/?/init.lua;;"
bin/busted -o gtest -v --exclude-tags=ci /kong-plugin/spec/
```


[kong]: https://github.com/Mashape/kong/
[kong-vagrant]: https://github.com/Mashape/kong-vagrant/
[kong-dev]: https://hub.docker.com/r/mrsaints/kong-dev/
[openresty-docker]: https://hub.docker.com/r/openresty/openresty/
[kong-plugin]: https://github.com/Mashape/kong-plugin/
