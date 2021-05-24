#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: $0 <unity-proj> <binary_name>"
    exit 1
fi

which unzip > /dev/null
if [ $? -eq 1 ]
then
	sudo apt install unzip
fi

PROJ_NAME=${1}
BINARY_NAME=${2}

if [ -d unity/${PROJ_NAME} ]
then
    :
else
    echo "ERROR: not found project ${PROJ_NAME}"
    exit 1
fi

rm -f unity/${PROJ_NAME}/${BINARY_NAME}
rm -rf unity/${PROJ_NAME}/Build

wget https://github.com/toppers/hakoniwa-Unity-HackEV/releases/download/v3.0/${BINARY_NAME}

mv ${BINARY_NAME} unity/${PROJ_NAME}/
cd unity/${PROJ_NAME}/
unzip ${BINARY_NAME}
rm -f ${BINARY_NAME}
