#/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <unity-proj>"
	exit 1
fi

bash unity/config-proxy.bash ${1}

cp unity/assets/${1}/core_config.json unity/assets/${1}/Build/

if [ -d unity/assets/${1}/Build/pdu ]
then
	:
else
	cp -rp utils/config/pdu unity/assets/${1}/Build/
fi

if [ -d unity/assets/${1}/Build/mmap ]
then
	:
else
	mkdir unity/assets/${1}/Build/mmap
	dd if=/dev/zero of=unity/assets/${1}/Build/mmap/athrill_mmap.bin bs=1k count=8
	dd if=/dev/zero of=unity/assets/${1}/Build/mmap/unity_mmap.bin bs=1k count=8
fi

cd unity/assets/${1}/Build/

./${1}.exe
