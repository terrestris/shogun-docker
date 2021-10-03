#!/bin/bash

CURRENT_IP=$(hostname -I | awk '{print $1}')

sed -i -E "s/KEYCLOAK_HOST=(.+)/KEYCLOAK_HOST=${CURRENT_IP}/" .env

USER_ID=$(id -u)
GROUP_ID=$(id -g)
USER_NAME=$(whoami)

sed -i -E "s/UID=(.+)/UID=${USER_ID}/" .env
sed -i -E "s/GID=(.+)/GID=${GROUP_ID}/" .env
sed -i -E "s/UNAME=(.+)/UNAME=${USER_NAME}/" .env
