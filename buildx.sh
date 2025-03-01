#!/usr/bin/env bash

APP_VERSION="17"
DOCKER_IMAGE_VERSION="v1.0.0"

APP_NAME_LIST=("Navicat Premium" "Navicat for MySQL" "Navicat for PostgreSQL" "Navicat for MongoDB" "Navicat for MariaDB" "Navicat for Oracle" "Navicat for Redis")
TAG_LIST=("Premium" "MySQL" "PostgreSQL" "MongoDB" "MariaDB" "Oracle" "Redis")
PRODUCT_LIST=("navicat17-premium-cs" "navicat17-mysql-cs" "navicat17-pgsql-cs" "navicat17-mongodb-cs" "navicat17-mariadb-cs" "navicat17-ora-cs" "navicat17-redis-cs")
APP_NUM=${#APP_NAME_LIST[@]}

PLATFORM_LIST=("linux/amd64" "linux/arm64")
PLATFORM_ALIAS_LIST=("x86_64" "aarch64")
PLATFORM_ALIAS2_LIST=("amd64" "arm64")
PLATFORM_NUM=${#PLATFORM_LIST[@]}

for ((i=0; i<${APP_NUM}; i++)); do
  for ((j=0; j<${PLATFORM_NUM}; j++)); do
    docker buildx build --load \
      --platform ${PLATFORM_LIST[$j]} \
      --build-arg APP_NAME="${APP_NAME_LIST[$i]}" \
      --build-arg APP_VERSION=${APP_VERSION} \
      --build-arg DOCKER_IMAGE_VERSION=${DOCKER_IMAGE_VERSION} \
      --build-arg DOCKER_IMAGE_PLATFORM=${PLATFORM_ALIAS_LIST[$j]} \
      --build-arg PRODUCT=${PRODUCT_LIST[$i]} \
      -t mingqing6364/navicat:${TAG_LIST[$i]}-${APP_VERSION}-${PLATFORM_ALIAS2_LIST[$j]} .
  done
done