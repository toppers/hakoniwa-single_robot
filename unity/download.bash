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

if [ -d unity/assets/${PROJ_NAME} ]
then
    echo "WARNING: unity/assets/${PROJ_NAME} already exists"
    read -n1 -p "Do you want to download and generate it again? (y/N): " yn;
    if [[ $yn = [yY] ]]
    then
        rm -rf unity/assets/${PROJ_NAME}
        mkdir unity/assets/${PROJ_NAME}
    else 
        echo "aborted."
        exit 1
    fi
else
    mkdir unity/assets/${PROJ_NAME}
fi

wget https://github.com/toppers/hakoniwa-Unity-HackEV/releases/download/v4.0/${BINARY_NAME}

mv ${BINARY_NAME} unity/assets/${PROJ_NAME}/
cd unity/assets/${PROJ_NAME}/
unzip ${BINARY_NAME}
chmod +x Build/${PROJ_NAME}.exe
rm -f ${BINARY_NAME}
