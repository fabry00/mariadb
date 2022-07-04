#!/bin/bash

HOST="127.0.0.1"
NODE_NAME="cluster01-node-02"
CLUSTER_ADDR="gcomm://${HOST}:7501"
CONF=$(pwd)/conf
DATA_DIR=$(pwd)/data/${NODE_NAME}_data
mkdir -p ${CONF} ${DATA_DIR}
MYQSL_PORT=7510
GALERA_PORT=7511
IST_PORT=7512
SST_PORT=7513
echo "Stopping ${NODE_NAME}"
docker stop -t 10 ${NODE_NAME} || true
docker rm -f ${NODE_NAME} || true
echo "Starting ${NODE_NAME}"
docker run -d --name ${NODE_NAME} \
  --network host \
  -v ${CONF}/my_custom_01.cnf:/opt/bitnami/mariadb/conf/my_custom.cnf:ro \
  -v ${DATA_DIR}:/bitnami/mariadb:rw \
  -e BITNAMI_DEBUG=true \
  -e MARIADB_GALERA_CLUSTER_NAME=my_galera \
  -e MARIADB_GALERA_MARIABACKUP_USER=my_mariabackup_user \
  -e MARIADB_GALERA_MARIABACKUP_PASSWORD=my_mariabackup_password \
  -e MARIADB_ROOT_PASSWORD=my_root_password \
  -e MARIADB_GALERA_CLUSTER_BOOTSTRAP=no \
  -e MARIADB_GALERA_CLUSTER_ADDRESS=${CLUSTER_ADDR} \
  -e MARIADB_USER=my_user \
  -e MARIADB_PASSWORD=my_password \
  -e MARIADB_DATABASE=my_database \
  -e MARIADB_REPLICATION_USER=my_replication_user \
  -e MARIADB_REPLICATION_PASSWORD=my_replication_password \
  -e MARIADB_PORT_NUMBER=${MYQSL_PORT} \
  -e MARIADB_EXTRA_FLAGS="--log-slave-updates=ON;--log-slave-updates=ON;--wsrep-node-incoming-address=${MYQSL_PORT};--wsrep-node-name=${NODE_NAME};--wsrep_provider_options=ist.recv_addr=${HOST}:${IST_PORT};ist.recv_bind=0.0.0.0:${IST_PORT} --wsrep_node_incoming_address=${HOST}  --wsrep_sst_receive_address=${HOST}:${SST_PORT} --wsrep_node_address=${HOST}:${GALERA_PORT}" \
  -p ${GALERA_PORT}:${GALERA_PORT} \
  -p ${IST_PORT}:${IST_PORT} \
  -p ${SST_PORT}:${SST_PORT} \
  bitnami/mariadb-galera:latest

  docker logs -f ${NODE_NAME}