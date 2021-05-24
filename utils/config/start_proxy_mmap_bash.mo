#!/bin/bash

bash utils/config/create_config-mmap.bash {{APLNAME}} 

cd proxy

bash hakoniwa_proxy-mac.bash {{RESOLVE_IPADDR}}
