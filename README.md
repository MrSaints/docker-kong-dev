# docker-kong-dev

[![](https://images.microbadger.com/badges/image/mrsaints/kong-dev.svg)](https://microbadger.com/images/mrsaints/kong-dev "Get your own image badge on microbadger.com")

_A work in progress. Use at your own discretion._

An unofficial Docker image (tooling) for [Kong][kong] testing, and development.

    Kong is a scalable, open source API Layer (also known as an API Gateway, or API Middleware)... Backed by the battle-tested NGINX with a focus on high performance.

This repository provides lightweight tooling for testing, and developing Kong.
It is intended to serve as an unofficial, easy-to-use, alternative to [kong-vagrant][] for developing on Kong or on custom plugins.

The [`mrsaints/kong-dev`][kong-dev] image contains all the necessary dependencies to run, test, and develop Kong (e.g. OpenResty, luarocks, Serf, and Kong). It is a fork of [`openresty/openresty:alpine-fat`][openresty-docker].


## Getting Started

To get started, clone this repository, and modify the `docker-compose.yml` file if you would like to mount your local Kong repository or your custom plugin source code.

Once ready, run `docker-compose run --rm --service-ports kong bash`, and you can begin running commands like `kong start -v`. _The database might take a while to start up._


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
