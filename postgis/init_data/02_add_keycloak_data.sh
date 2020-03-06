#!/bin/bash
set -e

# we need to connect to the keycloak database here. that's why we use a script
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "keycloak" < /docker-entrypoint-initdb.d/keycloak_data/keycloak_data.sql
