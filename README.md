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
- SHOGun-GIS-Client (the default mapping client)

### Recommended directory structure

To get things started, please check out all required repositories in the recommended
directory structure:

```bash
your-shogun-workspace-directory/
├── shogun (https://github.com/terrestris/shogun)
├── shogun-admin (https://github.com/terrestris/shogun-admin)
├── shogun-gis-client (https://github.com/terrestris/shogun-gis-client)
└── shogun-docker (this repository)
```

### Required steps for the very first start

- Check and fulfill all development notes of the child components (e.g. installing the
  `maven` and `node` dependencies).
- Set all required environment variables by executing `./setEnvironment.sh create` (and adjusting the values if needed).
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

The contents of this repository may be a good starting point for creating a custom project
based on [SHOGun](https://github.com/terrestris/shogun).

There is a SHOGun example app repository at [https://github.com/terrestris/shogun-example-app](https://github.com/terrestris/shogun-example-app) which demonstrates on how SHOGun can be extended for custom implementations and can be used as follows:

1. Create a new folder directory as suggested:

```bash
your-custom-shogun-workspace-directory/
├── shogun-example-app (export of https://github.com/terrestris/shogun-example-app)
└── shogun-example-docker (export of this repository)
```

1. Initialize git in both subdirectories (`git init`) and adjust the upstream to your
   needs (e.g. `git remote add upstream git@github.com:yourorg/shogun-example.git`).

1. (Optional) Make use of the prebuilt images for both the `shogun-admin` and `shogun-gis-client`
   by adjusting the `docker-compose.yml`:

    ```diff
    -    build:
    -      context: ${SHOGUN_ADMIN_DIR}
    -      dockerfile: Dockerfile.dev
    -    ports:
    -      - 9090:9090
    -    volumes:
    -      - ${SHOGUN_ADMIN_DIR}:/app
    +    image: nexus.terrestris.de/repository/terrestris-public/shogun-admin:9.0.0
    ```

    ```diff
    -    build:
    -      context: ${SHOGUN_CLIENT_DIR}
    -      dockerfile: Dockerfile.dev
    -    ports:
    -      - 3000:3000
    -    volumes:
    -      - ${SHOGUN_CLIENT_DIR}:/app
    +    image: nexus.terrestris.de/repository/terrestris-public/shogun-gis-client:4.0.0
    ```

1. Remove the `shogun-gs-interceptor` service from the `docker-compose.yml`.

1. Update the context path to the `shogun-boot` service:

    ```diff
    -    context: ${SHOGUN_DIR}/shogun-boot/
    +    context: ${SHOGUN_DIR}/example-backend/
    ```

1. Check for all comments _TODO: Adjust to your project_ in the `shogun-example-app` and
   adjust the appropriate lines to your needs (e.g. the name of the project).

1. Set all required environment variables by executing `./setEnvironment.sh create` (and adjusting the values if needed).

1. Depending on the mode (development or production) of the `shogun-admin` and `shogun-gis-client`,
   you might need to adjust the reverse proxy settings in the `shogun-nginx/dev/default.conf` file, e.g.:

    ```diff
    -    proxy_pass https://shogun-admin:9090/;
    +    proxy_pass http://shogun-admin/;
    ```
    ```diff
    -    proxy_pass https://shogun-client:3000/;
    +    proxy_pass http://shogun-gis-client/;
    ```

1. Run the services with `docker compose up` which should be available at `https://localhost/` afterwards.

1. Import the initial Keycloak data, see section [Keycloak Import](#import).

## Test a prebuilt SHOGun 🏭

You want to see SHOGun in action?

- Set all required environment variables by executing `./setEnvironment.sh create` (and adjusting the values if needed).
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

## Solr

The solr instance is preconfigured with a core named `search`. This can be used immediately after start to import documents.
