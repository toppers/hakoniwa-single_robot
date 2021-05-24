#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <dir>"
	exit 1
fi

DIR=${1}

if [ -d ${DIR}/extract ]
then
	:
else
	mkdir ${DIR}/extract
fi

#delete unuse lines
grep -v NONE ${DIR}/athrill.csv > ${DIR}/extract/athrill.csv
grep -v ",1E-06," ${DIR}/unity.csv > ${DIR}/extract/unity.csv

#set same lines
L1=`wc -l ${DIR}/extract/athrill.csv | awk '{print $1}'`
L2=`wc -l ${DIR}/extract/unity.csv | awk '{print $1}'`

if [ $L1 -eq $L2 ]
then
	echo "PASSED: same size: ${L1}"
else
	echo "FAILED: not same size: athrill=${L1} unity=${L2}"
fi
ruby calc.ruby ${DIR}/extract/athrill.csv
ruby calc.ruby ${DIR}/extract/unity.csv
