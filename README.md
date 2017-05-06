# docker-kong-dev

[![](https://images.microbadger.com/badges/image/mrsaints/kong-dev.svg)](https://microbadger.com/images/mrsaints/kong-dev "Get your own image badge on microbadger.com")

_A work in progress. Use at your own discretion. A basic understanding of Docker, Compose, and Kong is required._

An unofficial Docker image (tooling) for [Kong][kong] testing, and development.

    Kong is a scalable, open source API Layer (also known as an API Gateway, or API Middleware)... Backed by the battle-tested NGINX with a focus on high performance.

This repository provides lightweight tooling for testing, and developing Kong.
It is intended to serve as an unofficial, easy-to-use, alternative to [kong-vagrant][] for developing on Kong or on custom plugins.
Some manual labour however, is still required (e.g. Mounting directories, setting environment variables / flags, etc).

The [`mrsaints/kong-dev`][kong-dev] image contains all the necessary dependencies to run, test, and develop Kong (e.g. OpenResty, luarocks, Serf, and Kong). It runs on the _latest_ (at the time of build) Kong source code.

It is a fork of [`openresty/openresty:alpine-fat`][openresty-docker].


## Getting Started

To get started, clone this repository, and modify the `docker-compose.yml` file if you would like to mount your local Kong repository or your custom plugin source code.
Alternatively, you can clone the [`Mashape/kong-plugin`][kong-plugin] boilerplate into this directory to begin working on your custom plugin. The [`Mashape/kong`][kong] repository can also be cloned into this directory.

Once ready, run `docker-compose run --rm --service-ports kong bash`, and you can begin running commands like `kong start --vv`.

_There is an entrypoint for Kong to wait for the database. To bypass it, pass a `-W` flag before your command, e.g. `docker-compose run --rm --service-ports kong -W bash`. You can even pass a `--no-deps` flag after `run` to launch Kong without the database_

No restarts should be needed for local changes to be reflected (assuming the code is mounted). The default log level has also been set to `DEBUG`.


## Developing Plugins

Once you have mounted your plugin source code, you can install it manually by including it in the `LUA_ PATH` _(change `kong-plugin` accordingly)_:

```
export LUA_PATH="/kong-plugin/?.lua;/kong-plugin/?/init.lua;;"
```

Then, load it:

```
export KONG_CUSTOM_PLUGINS=myPlugin
```

These environment variables are already included in the `docker-compose.yml` file. You can uncomment, and modify the lines before executing Compose commands.


## Tests

Tests must execute Kong in daemon mode otherwise they will hang (i.e. `KONG_NGINX_DAEMON=on`, note the `on`).

To run tests for your custom plugin (assuming it is in `/kong-plugin/spec`):

```
export LUA_PATH="/kong-plugin/?.lua;/kong-plugin/?/init.lua;;"
bin/busted -o gtest -v --exclude-tags=ci /kong-plugin/spec/
```


## Caveats

Due to an unknown problem, possibly related to Serf / clustering, you may have to clear the cache manually when making changes (e.g. enabling or updating plugins), otherwise they may not be reflected:

```
curl -i -XDELETE http://localhost:8001/cache
```

---

[https://github.com/MrSaints/kong-plugin-aws/][kong-plugin-aws] was built using these tooling.


[kong]: https://github.com/Mashape/kong/
[kong-vagrant]: https://github.com/Mashape/kong-vagrant/
[kong-dev]: https://hub.docker.com/r/mrsaints/kong-dev/
[openresty-docker]: https://hub.docker.com/r/openresty/openresty/
[kong-plugin]: https://github.com/Mashape/kong-plugin/
[kong-plugin-aws]: https://github.com/MrSaints/kong-plugin-aws/
