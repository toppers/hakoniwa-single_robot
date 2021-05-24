#!/bin/bash

export PATH=/root/hakoniwa-core/impl/asset/client/build/cpp:${PATH}
cd /root/workspace 

bash config/create_config_dbg.bash {{APLNAME}} eth0

cd proxy

bash hakoniwa_proxy.bash
