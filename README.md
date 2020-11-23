# SHOGun-Boot Docker

This project contains a basic docker-compose setup required to run / develop a [SHOGun-Boot](https://github.com/terrestris/shogun) webapplication.

## Description

This repository contains two `docker-compose` configuration files:

* `docker-compose.yml`: Contains the required ready-to-use services to run all
  `SHOGun` services (either in dev or non-dev environment).
* `docker-compose-shogun.yml`: Contains an example configuration for the latest
  prebuilt SHOGun images.

## Requirements

* docker
* docker-compose

## Steps

### Development (databases and Keycloak)

To start the services required for development (databases and Keycloak), just start:

```bash
docker-compose up
```

You can test whether the Keycloak application started by visiting the URL
`http://localhost:8000/auth/`.


### Import the initial keycloak data

See [Keycloak import](#import).

### Test a prebuilt SHOGun

If you want to run the prebuilt SHOGun services, just start:

```bash
docker-compose -f docker-compose.yml -f docker-compose-shogun.yml up
```

Note: Before running the images, you need to set the correct `KEYCLOAK_HOST` (your local IP)
      for both services. Please edit the appropriate lines in `docker-compose-shogun.yml` to
      do so.

You can test whether the SHOGun application started by visiting the URL
`http://localhost:8080/shogun-boot/`.

## Default credentials

* Keycloak Admin: `admin:shogun`
* SHOGun Admin: `shogun:shogun`

## Redis

The Redis config files are located in `shogun-redis/redis_config`. The default redis password
can be changed in file `shogun-redis/redis_config/.redis`.

## Keycloak

### Export

While keycloak docker container is runnning execute:

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

Wait until fininshed (look out for `Import finished successfully` in the logs) and exit the container.
