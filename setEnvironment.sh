#!/bin/bash

# Stop at first command failure.
set -e

if ! [ -f ".env" ]; then
  echo "Error: .env not found. Can not continue."
  exit 1
fi

CURRENT_IP=$(ip route get 1 | awk '{gsub("^.*src ",""); print $1; exit}')

USER_ID=$(id -u)
GROUP_ID=$(id -g)
USER_NAME=$(whoami)

printf "Updating .env:\nKEYCLOAK_HOST=${CURRENT_IP}\nUID=${USER_ID}\nGID=${GROUP_ID}\nUNAME=${USER_NAME}"

sed -i -E "s/KEYCLOAK_HOST=(.+)/KEYCLOAK_HOST=${CURRENT_IP}/" .env

sed -i -E "s/UID=(.+)/UID=${USER_ID}/" .env
sed -i -E "s/GID=(.+)/GID=${GROUP_ID}/" .env
sed -i -E "s/UNAME=(.+)/UNAME=${USER_NAME}/" .env
