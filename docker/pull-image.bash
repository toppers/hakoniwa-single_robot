#!/bin/bash

DOCKER_IMAGE=`cat docker/docker_image.txt`

sudo service docker start
sudo docker pull ${DOCKER_IMAGE}
