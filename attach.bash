#!/bin/bash

DOCKER_IMAGE=`cat docker/docker_image.txt`
DOCKER_ID=`sudo docker ps | grep "${DOCKER_IMAGE}" | awk '{print $1}'`

sudo docker exec -it ${DOCKER_ID} /bin/bash
