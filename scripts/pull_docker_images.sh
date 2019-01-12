#!/bin/bash

EMPTY_MOUNTS_CHECKSUM="56a5457830766120cc4a508b526c0356"
# Checks state of current BackendlessPro/scripts/mounts directory, and generates hash
# If hash matches above, directory is empty, and we need to run backendless_install.sh script
sudo apt-get install md5deep -y
md5deep -r BackendlessPro/scripts/mounts > dirlist_checksum.md5
cat dirlist_checksum.md5  | tr -d '\n' > oneline.txt
md5sum -b oneline.txt | cut -d" " -f1 > checksum.md5
rm dirlist_checksum.md5 && rm oneline.txt
CURRENT_CHECKSUM=$(cat checksum.md5)


if [ "$EMPTY_MOUNTS_CHECKSUM" = "$CURRENT_CHECKSUM" ]; then
        echo "Bootstraping fresh swarm"
        chmod +x BackendlessPro/scripts/*.sh
        cd BackendlessPro/scripts
        ./backendless_install.sh

else
        echo "Changes in mounts directory"
fi
