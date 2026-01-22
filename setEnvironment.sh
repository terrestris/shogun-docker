#!/bin/bash

# Stop at first command failure.
set -e

# SHOGun paths
SHOGUN_DIR=../shogun
SHOGUN_ADMIN_DIR=../shogun-admin
SHOGUN_CLIENT_DIR=../shogun-gis-client
SHOGUN_CLIENT_PLUGINS_DIR=../shogun-gis-client-example-plugin

# Container prefix
CONTAINER_NAME_PREFIX=shogun

# The mail server host
MAIL_HOST=mail.terrestris.de
# The mail server port
MAIL_PORT=587
# The password of the mail server
MAIL_PASSWORD="super secret"

# The database user password
POSTGRES_USER=shogun
# The LDAP admin user password
POSTGRES_PASSWORD=shogun

# The Keycloak host, this must be accessible from inside a docker network and run under HTTPS
KEYCLOAK_HOST=$(ip route get 1 | awk '{gsub("^.*src ",""); print $1; exit}')
# The Keycloak admin user
KEYCLOAK_USER=admin
# The Keycloak admin password
KEYCLOAK_PASSWORD=shogun
# The secret of the admin-cli client
KEYCLOAK_ADMIN_CLIENT_SECRET=supersecret

# The ID of the host user the GS image should run as
USER_ID=$(id -u)
# The group ID of the host user the GS image should run as
GROUP_ID=$(id -g)

# The current mode we're in, it's either create or update
MODE=$1

# GEOSERVER_CSRF_WHITELIST
GEOSERVER_CSRF_WHITELIST=localhost

POSITIONAL_ARGS=()
NO_CONFIRM=false

while [[ $# -gt 0 ]]; do
  case $1 in
    -y|--yes)
      NO_CONFIRM=true
      shift
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1")
      shift
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}"

if [ "$MODE" = "create" ]; then
  if ! "$NO_CONFIRM"; then
    read -rp "This will remove the current .env file. Do you really want to continue (y/n)? "
  fi
elif [ "$MODE" = "update" ]; then
  if ! "$NO_CONFIRM"; then
    read -rp "This will update the current .env file with your local IP only. Do you want to continue (y/n)? "
  fi
else
  echo "Missing argument 'create' or 'update'"
  exit 1
fi

# Check if prompted to continue
if ! "$NO_CONFIRM" && [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
ENV_FILE=.env

if [ "$MODE" = "create" ]; then
  rm -rf $SCRIPT_DIR/$ENV_FILE

  echo "SHOGUN_DIR=${SHOGUN_DIR}" > $SCRIPT_DIR/$ENV_FILE
  echo "SHOGUN_ADMIN_DIR=${SHOGUN_ADMIN_DIR}" >> $SCRIPT_DIR/$ENV_FILE
  echo "SHOGUN_CLIENT_DIR=${SHOGUN_CLIENT_DIR}" >> $SCRIPT_DIR/$ENV_FILE
  echo "SHOGUN_CLIENT_PLUGINS_DIR=${SHOGUN_CLIENT_PLUGINS_DIR}" >> $SCRIPT_DIR/$ENV_FILE

  echo "CONTAINER_NAME_PREFIX=${CONTAINER_NAME_PREFIX}" >> $SCRIPT_DIR/$ENV_FILE

  echo "MAIL_HOST=${MAIL_HOST}" >> $SCRIPT_DIR/$ENV_FILE
  echo "MAIL_PORT=${MAIL_PORT}" >> $SCRIPT_DIR/$ENV_FILE
  echo "MAIL_PASSWORD=${MAIL_PASSWORD}" >> $SCRIPT_DIR/$ENV_FILE

  echo "POSTGRES_USER=${POSTGRES_USER}" >> $SCRIPT_DIR/$ENV_FILE
  echo "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" >> $SCRIPT_DIR/$ENV_FILE

  echo "KEYCLOAK_HOST=${KEYCLOAK_HOST}" >> $SCRIPT_DIR/$ENV_FILE
  echo "KEYCLOAK_USER=${KEYCLOAK_USER}" >> $SCRIPT_DIR/$ENV_FILE
  echo "KEYCLOAK_PASSWORD=${KEYCLOAK_PASSWORD}" >> $SCRIPT_DIR/$ENV_FILE
  echo "KEYCLOAK_ADMIN_CLIENT_SECRET=${KEYCLOAK_ADMIN_CLIENT_SECRET}" >> $SCRIPT_DIR/$ENV_FILE

  echo "UID=${USER_ID}" >> $SCRIPT_DIR/$ENV_FILE
  echo "GID=${GROUP_ID}" >> $SCRIPT_DIR/$ENV_FILE

  echo "GEOSERVER_CSRF_WHITELIST=${GEOSERVER_CSRF_WHITELIST}" >> $SCRIPT_DIR/$ENV_FILE
  echo "GEOSERVER_PROXY_BASE_URL=" >> $SCRIPT_DIR/$ENV_FILE

  echo "Successfully wrote $SCRIPT_DIR/$ENV_FILE"
else
  sed -i -E "s/KEYCLOAK_HOST=(.+)/KEYCLOAK_HOST=${KEYCLOAK_HOST}/" .env

  echo "Successfully updated local IP in $SCRIPT_DIR/$ENV_FILE"
fi

KEYCLOAK_SECURITY_FILTER_CONFIG_FILE='./shogun-geoserver/geoserver_data/security/filter/shogun-keycloak/config.xml'

if [ -f "${KEYCLOAK_SECURITY_FILTER_CONFIG_FILE}" ]; then
  printf "\nUpdating ${KEYCLOAK_SECURITY_FILTER_CONFIG_FILE} with ${KEYCLOAK_HOST}\n"
  sed -i -E "s/&quot;auth-server-url&quot;: &quot;https:\/\/(.+)\/auth\/&quot;,&#xd;/\&quot;auth-server-url\&quot;: \&quot;https:\/\/${KEYCLOAK_HOST}\/auth\/\&quot;,\&#xd;/" $KEYCLOAK_SECURITY_FILTER_CONFIG_FILE
fi

printf "Updating the SSL certificate\n"

sed -i -E "s/IP.2    = (.+)/IP.2    = ${KEYCLOAK_HOST}/g" shogun-firewall/ssl/localhost.conf

openssl req \
  -config ./shogun-firewall/ssl/localhost.conf \
  -addext basicConstraints=critical,CA:TRUE,pathlen:1 \
  -batch \
  -x509 \
  -nodes \
  -days 3650 \
  -newkey rsa:2048 \
  -keyout ./shogun-firewall/ssl/private/localhost.key \
  -out ./shogun-firewall/ssl/private/localhost.crt

printf "Updating the keystore of shogun-boot\n"

if keytool -list -alias DEV -keystore ./shogun-boot/keystore/cacerts -noprompt -storepass changeit > /dev/null 2>&1; then
  keytool -delete -alias DEV -keystore ./shogun-boot/keystore/cacerts -noprompt -storepass changeit
fi
keytool -import -file ./shogun-firewall/ssl/private/localhost.crt -alias DEV -keystore ./shogun-boot/keystore/cacerts -noprompt -storepass changeit

printf "Updating the keystore of shogun-geoserver\n"

if keytool -list -alias DEV -keystore ./shogun-geoserver/keystore/cacerts -noprompt -storepass changeit > /dev/null 2>&1; then
  keytool -delete -alias DEV -keystore ./shogun-geoserver/keystore/cacerts -noprompt -storepass changeit
fi
keytool -import -file ./shogun-firewall/ssl/private/localhost.crt -alias DEV -keystore ./shogun-geoserver/keystore/cacerts -noprompt -storepass changeit

printf "Updating the keystore of shogun-keycloak\n"

if keytool -list -alias DEV -keystore ./shogun-keycloak/keystore/cacerts -noprompt -storepass changeit > /dev/null 2>&1; then
  keytool -delete -alias DEV -keystore ./shogun-keycloak/keystore/cacerts -noprompt -storepass changeit
fi
keytool -import -file ./shogun-firewall/ssl/private/localhost.crt -alias DEV -keystore ./shogun-keycloak/keystore/cacerts -noprompt -storepass changeit
