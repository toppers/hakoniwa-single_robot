#!/bin/bash


if [ $# -ne 1 ]
then
	echo "Usage: $0 <apl-name>"
	exit 1
fi
EV3RT_DIR=ev3rt-athrill-v850e2m/sdk/workspace
APL_NAME=${1}

cd ${EV3RT_DIR}
make -f ../../../make/Makefile.workspace img=${APL_NAME}

