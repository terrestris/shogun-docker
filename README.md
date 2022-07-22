# SHOGun-Boot Docker

This project contains a basic docker-compose setup required to develop / run a
[SHOGun-Boot](https://github.com/terrestris/shogun) webapplication.

## Description 📙

This repository contains several `docker-compose` configuration files:

- `common-services.yml`: Contains the shared service configurations for all environments.
- `docker-compose.yml`: Contains the service configurations for DEVELOPMENT.
- `docker-compose-prod.yml`: Contains the service configurations for PRODUCTION.

## Requirements 🛠️

- docker
- docker-compose-plugin

Please note: If you want to develop SHOGun or some of it's components you might need
additional tools (e.g. `mvn` and `node`). Consider the README files of the associated
repositories for more details.

## System architecture

![System architecture](./docs/components.png)

## Development 🧑‍💻

This repository contains the required configurations to develop all SHOGun related
components:

- SHOGun (the backend part)
- SHOGun-Admin (the UI for handling SHOGun entities)
- SHOGun-Demo-Client (the demo mapping client)

### Recommended directory structure

To get things started, please check out all required repositories in the recommended
directory structure:

```bash
your-shogun-workspace-directory/
├── shogun (https://github.com/terrestris/shogun)
├── shogun-admin (https://github.com/terrestris/shogun-admin)
├── shogun-demo-client (https://github.com/terrestris/shogun-demo-client)
├── shogun-docker (this repository)
└── …
```

### Required steps for the very first start

- Check and fulfill all development notes of the child components (e.g. installing the
  `maven` and `node` dependencies).
- Set all required environment variables by executing `./setEnvironment.sh` (and adjusting the values if needed).
- Import the initial Keycloak data, see section [Keycloak Import](#import).

### Startup

Please ensure you have checked out all required repositores (see [Recommended directory structure](#recommended-directory-structure))
and have fulfilled the required steps for the very first start (see [Required steps for the very first start](#required-steps-for-the-very-first-start)).

To start the services required for development of SHOGun (no custom project), just run:

```bash
docker compose up --build
```

You can test whether the SHOGun application started by visiting the URL `https://localhost/`.

### Custom project development

If you are working on a custom project that inherits from SHOGun you have to adjust the
following settings first:

- Copy the file `shogun-boot/dev/Dockerfile` to your project root dir
- Add your project profile to the `Dockerfile`
- In the [docker-compose-dev.yml](docker-compose-dev.yml) update the build context to
  point to your project root dir
- Also update the volumes to point the `/shogun-boot` folder in the container to
  your project root dir

Now you can start the containers:

```bash
docker compose up --build
```

## Test a prebuilt SHOGun 🏭

You want to see SHOGun in action?

- Set all required environment variables by executing `./setEnvironment.sh` (and adjusting the values if needed).
- Import the initial Keycloak data, see section [Keycloak Import](#import).

And start the prebuilt images via:

```bash
docker compose -f docker-compose-prod.yml up
```

You can test whether the SHOGun application started by visiting the URL
`https://localhost/`.

## Default credentials 🔐

- Keycloak Admin: `admin:shogun`
- SHOGun Admin: `shogun:shogun`
- GeoServer: `admin:geoserver`

## Keycloak

### Export

While the Keycloak docker container is runnning execute:

```
docker exec -it shogun-keycloak /opt/jboss/keycloak/bin/standalone.sh -Djboss.socket.binding.port-offset=100 -Dkeycloak.migration.action=export -Dkeycloak.migration.provider=singleFile -Dkeycloak.migration.usersExportStrategy=REALM_FILE -Dkeycloak.migration.file=/tmp/keycloak_export.json
```

Wait until finished (look out for `Export finished successfully` in the logs) and exit the container.

```
docker cp shogun-keycloak:/tmp/keycloak_export.json ./shogun-keycloak/init_data/keycloak_export.json
```

### Import

```
docker cp ./shogun-keycloak/init_data/keycloak_export.json shogun-keycloak:/tmp/keycloak_export.json
```

```
docker exec -it shogun-keycloak /opt/jboss/keycloak/bin/standalone.sh -Djboss.socket.binding.port-offset=100 -Dkeycloak.migration.action=import -Dkeycloak.migration.provider=singleFile -Dkeycloak.migration.usersExportStrategy=REALM_FILE -Dkeycloak.migration.file=/tmp/keycloak_export.json
```

Wait until finished (look out for `Import finished successfully` in the logs) and exit the container.
