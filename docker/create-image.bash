#!/bin/bash

DOCKER_IMAGE=`cat docker/docker_image.txt`

sudo docker build -t ${DOCKER_IMAGE} -f docker/Dockerfile .
