# SHOGun-Boot Docker

This project contains a basic docker-compose setup required to run / develop a [SHOGun-Boot](https://github.com/terrestris/shogun) webapplication.

## Requirements

* docker
* docker-compose

## Steps

```
docker-compose up
```

## Redis

The Redis config files are located in `shogun-redis/redis_config`. The default redis password
can be changed in file `shogun-redis/redis_config/.redis`.

## Default credentials

* Keycloak Admin: `admin:shogun`
* SHOGun Admin: `shogun:shogun`
