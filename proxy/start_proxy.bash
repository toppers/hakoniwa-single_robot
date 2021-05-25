#!/bin/bash

export PATH=/root/hakoniwa-core/impl/asset/client/build/cpp:${PATH}
cd /root/workspace 

bash config/create_config.bash base_practice_1 eth0
#bash config/create_config_bt.bash base_practice_1 eth0

cd proxy

bash hakoniwa_proxy.bash
