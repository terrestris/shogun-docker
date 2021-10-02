#!/bin/bash

CURRENT_IP=$(hostname -I | awk '{print $1}')

sed -i -E "s/KEYCLOAK_HOST=(.+)/KEYCLOAK_HOST=${CURRENT_IP}/" .env

#USER_ID=$(id -u)
#GROUP_ID=$(id -g)
#USER_NAME=$(whoami)

#sed -i "s/<<INSERT_YOUR_USER_ID>>/${USER_ID}/" .env
#sed -i "s/<<INSERT_YOUR_USER_GROUP_ID>>/${GROUP_ID}/" .env
#sed -i "s/<<INSERT_YOUR_USER_NAME_ID>>/${USER_NAME}/" .env
