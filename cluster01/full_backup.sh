#!/bin/bash
NODE_NAME="cluster01-node-01"
docker exec -it ${NODE_NAME} mariabackup --backup \
   --target-dir=/bitnami/mariadb/backup/ \
   --user=my_mariabackup_user --password=my_mariabackup_password

docker exec -it ${NODE_NAME} mariabackup --prepare \
   --target-dir=/bitnami/mariadb/backup/   