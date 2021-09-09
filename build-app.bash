#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 [<apl-name>|clean]"
	exit 1
fi

if [ $1 != "clean" ]
then
    sudo docker exec -it -e APLNAME=$1 -w /root/workspace/sdk/workspace \
        hakoniwa_single-robot /bin/bash -c 'make img=${APLNAME}'
else
    sudo docker exec -it -e APLNAME=$1 -w /root/workspace/sdk/workspace \
        hakoniwa_single-robot /bin/bash -c 'make clean'
fi
