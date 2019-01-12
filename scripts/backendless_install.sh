#!/bin/bash

echo "Usage: \"`basename "$0"` <version>"

cd `dirname "$0"`;

#docker swarm init &> /dev/null

version=${1:-"latest"}
registry=${2:-"backendless"}

if [[ "$registry" == "private"  ]]; then
  ./pull.sh ${version} registry.backendless.com:5000
fi

if [[ "$registry" == "backendless"  ]]; then
  ./pull.sh ${version} backendless
fi

cat >> ports.env <<EOL
BL_MYSQL_PORT=3306
BL_MONGODB_PORT=27017
BL_PROPERTY_config_redis_bl_debug_port=6380
BL_PROPERTY_config_server_publicPort=9000
BL_PROPERTY_config_console_port=80
BL_PROPERTY_config_rt_server_socketServer_connection_port=5000
EOL
#./check_ports.sh
