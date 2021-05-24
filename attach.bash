#!/bin/bash

DOCKER_ID=`sudo docker ps | grep "single-robot/ev3rt-v850:v1.0.0" | awk '{print $1}'`

sudo docker exec -it ${DOCKER_ID} /bin/bash
