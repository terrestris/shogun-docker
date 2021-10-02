#!/bin/bash

openssl req \
  -config ./shogun-nginx/ssl/localhost.conf \
  -batch \
  -x509 \
  -nodes \
  -days 365 \
  -newkey rsa:2048 \
  -keyout ./shogun-nginx/ssl/private/localhost.key \
  -out ./shogun-nginx/ssl/private/localhost.crt
