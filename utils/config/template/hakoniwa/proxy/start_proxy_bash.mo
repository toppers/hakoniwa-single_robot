#!/bin/bash

if [ -z ${TEMPLATE_PATH} ]
then
	source config/env.bash
fi

cd ${WORKDIR}

bash ${TEMPLATE_PATH}/athrill/create_config.bash {{APLNAME}}

bash proxy/hakoniwa_proxy.bash
