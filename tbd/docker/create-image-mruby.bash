#!/bin/bash

DOCKER_IMAGE=single-robot/ev3rt-v850-mruby
DOCKER_TAG=v1.0.0
docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} -f Dockerfile.mruby .
