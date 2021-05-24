#!/bin/bash


if [ $# -ne 1 ]
then
	echo "Usage: $0 <apl-name>"
	exit 1
fi

MRUBY_BIN=/root/workspace/mruby/bin
EV3RT_DIR=/root/workspace/ev3rt-athrill-v850e2m/sdk/workspace
APL_NAME=${1}

cd ${EV3RT_DIR}

cd ${APL_NAME}
rm -f main_task.h
${MRUBY_BIN}/mrbc -g -v -Bbcode -omain_task.h main_task.rb > /dev/null
ruby /root/workspace/mruby/delete_extern.rb
cd ..

make -f ../../../make/Makefile.workspace img=${APL_NAME}

