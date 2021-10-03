# SHOGun-Boot Docker

This project contains a basic docker-compose setup required to run / develop a [SHOGun-Boot](https://github.com/terrestris/shogun) webapplication.

## Description

This repository contains two `docker-compose` configuration files:

* `docker-compose.yml`: Contains the required ready-to-use services to run all
  `SHOGun` services (either in dev or non-dev environment).
* `docker-compose-shogun.yml`: Contains an example configuration for the latest
  prebuilt SHOGun images.
* `docker-compose-dev.yml`: Contains an example configuration for a locally
  mounted / linked shogun checkout.

## Requirements

* docker
* docker-compose

## Recommended directory structure

```bash
shogun-directory/
├── shogun (https://github.com/terrestris/shogun)
├── shogun-docker (this repository)
└── …
```

## Steps

### Required steps for the very first start

* Set all required environment variables by executing `./setEnvironment.sh`.

* Generate a self-signed SSL certificate by executing `generateKey.sh`.

### Development (databases and Keycloak)

To start the services required for development (databases and Keycloak), just start:

```bash
docker-compose -f docker-compose.yml -f docker-compose-dev.yml up
```

You can test whether the Keycloak application started by visiting the URL
`https://localhost/auth/`.

### Import the initial Keycloak data

See section [Keycloak Import](#import).

### Test a prebuilt SHOGun

If you want to run the prebuilt SHOGun services, just start:

```bash
docker-compose -f docker-compose.yml -f docker-compose-shogun.yml up
```

You can test whether the SHOGun application started by visiting the URL
`https://localhost/`.

## Default credentials

* Keycloak Admin: `admin:shogun`
* SHOGun Admin: `shogun:shogun`
* GeoServer: `admin:geoserver`

## Redis

The Redis config files are located in `shogun-redis/redis_config`. The default redis password
can be changed in file `shogun-redis/redis_config/.redis`.

## Keycloak

### Export

While the Keycloak docker container is runnning execute:

```
docker exec -it shogun-docker_shogun-keycloak_1 /opt/jboss/keycloak/bin/standalone.sh -Djboss.socket.binding.port-offset=100 -Dkeycloak.migration.action=export -Dkeycloak.migration.provider=singleFile -Dkeycloak.migration.usersExportStrategy=REALM_FILE -Dkeycloak.migration.file=/tmp/keycloak_export.json
```

Wait until finished (look out for `Export finished successfully` in the logs) and exit the container.

```
docker cp shogun-docker_shogun-keycloak_1:/tmp/keycloak_export.json ./shogun-keycloak/init_data/keycloak_export.json
```

### Import

```
docker cp ./shogun-keycloak/init_data/keycloak_export.json shogun-docker_shogun-keycloak_1:/tmp/keycloak_export.json
```

```
docker exec -it shogun-docker_shogun-keycloak_1 /opt/jboss/keycloak/bin/standalone.sh -Djboss.socket.binding.port-offset=100 -Dkeycloak.migration.action=import -Dkeycloak.migration.provider=singleFile -Dkeycloak.migration.usersExportStrategy=REALM_FILE -Dkeycloak.migration.file=/tmp/keycloak_export.json
```

Wait until finished (look out for `Import finished successfully` in the logs) and exit the container.
