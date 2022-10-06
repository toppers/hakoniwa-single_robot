#!/bin/bash

IMAGE_NAME=`cat docker/image_name.txt`
IMAGE_TAG=`cat appendix/latest_version.txt`
DOCKER_IMAGE=${IMAGE_NAME}:${IMAGE_TAG}

read -n1 -p "Do you want to build & push mulit-platform Docker image to Docker Hub? (y/N): " yn;
if [[ $yn = [yY] ]]
then
	echo "INFO: build multi-platform docker image and then push it to Docker Hub"
else
	echo "INFO: build docker image locally"
  docker build -t ${DOCKER_IMAGE} -f docker/Dockerfile .
  exit 0
fi

if [[ "$(docker buildx ls)" ]];
then
	:
else
	echo "ERROR: docker buildx could not be executed"
  exit 1
fi

docker buildx create --name hako_builder --platform linux/arm64,linux/amd64
docker buildx use hako_builder

docker buildx build --builder hako_builder --platform linux/arm64 \
  -t ${DOCKER_IMAGE} -f docker/Dockerfile --push .

docker buildx stop hako_builder
docker buildx rm hako_builder
