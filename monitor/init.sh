#!/bin/bash

envsubst < ~/alertmanager/config.yml | sponge ~/alertmanager/config.yml
envsubst < ~/prometheus/prometheus.yml | sponge ~/prometheus/prometheus.yml

cp -a ~/prometheus/* ${DATA_VOLUME}/prometheus/config/
cp -a ~/alertmanager/* ${DATA_VOLUME}/alertmanager/config/
cp -a ~/grafana/provisioning/* ${DATA_VOLUME}/grafana/provisioning/
cp -a ~/caddy/* ${DATA_VOLUME}/caddy/config/

docker-compose up -d
