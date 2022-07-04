#!/bin/bash
NODE_NAME="cluster02-node-01"
DATA_DIR=$(pwd)/data/${NODE_NAME}_data
rm -rf ${DATA_DIR}/data
docker run -it --rm  --name ${NODE_NAME} \
   -v ${DATA_DIR}:/bitnami/mariadb:rw \
   bitnami/mariadb-galera:latest \
   mariabackup --copy-back \
   --target-dir=/bitnami/mariadb/backup/

# docker exec -it ${NODE_NAME} mariabackup --copy-back --force-non-empty-directories \
#    --target-dir=/bitnami/mariadb/backup/