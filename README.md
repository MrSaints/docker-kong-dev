# docker-kong-dev

_A work in progress. Use at your own discretion._

An unofficial Docker image (tooling) for [Kong][kong] testing, and development.

    Kong is a scalable, open source API Layer (also known as an API Gateway, or API Middleware)... Backed by the battle-tested NGINX with a focus on high performance.

This repository provides lightweight tooling for testing, and developing Kong.
It is intended to serve as an unofficial, easy-to-use, alternative to [kong-vagrant][] for developing on Kong or on custom plugins.

---

The `mrsaints/docker-kong-dev` image contains all the necessary dependencies to run, test, and develop Kong (e.g. OpenResty, luarocks, Serf, and Kong). It is a fork of [`openresty/openresty:alpine-fat`][openresty-docker].

To get started, clone this repository, and modify the `docker-compose.yml` file if you would like to mount your local Kong repository or your custom plugin source code.


[kong]: https://github.com/Mashape/kong/
[kong-vagrant]: https://github.com/Mashape/kong-vagrant/
[openresty-docker]: https://hub.docker.com/r/openresty/openresty/
