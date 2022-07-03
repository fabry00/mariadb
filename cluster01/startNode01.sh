#!/bin/bash
HOST="127.0.0.1"
NODE_NAME="cluster01-node-01"
SERVER_ID_PER_CLUSTER=1
CONF=$(pwd)/conf
mkdir -p ${CONF}
MYQSL_PORT=7500
GALERA_PORT=7501
IST_PORT=7502
SST_PORT=7503
echo "Stopping ${NODE_NAME}"
docker stop -t 30 ${NODE_NAME} || true
docker rm -f ${NODE_NAME} || true
echo "Starting ${NODE_NAME}"
docker run -d --name ${NODE_NAME} \
  --network host \
  -v ${CONF}/my_custom.cnf:/opt/bitnami/mariadb/conf/my_custom.cnf:ro \
  -e MARIADB_GALERA_CLUSTER_NAME=my_galera \
  -e MARIADB_GALERA_MARIABACKUP_USER=my_mariabackup_user \
  -e MARIADB_GALERA_MARIABACKUP_PASSWORD=my_mariabackup_password \
  -e MARIADB_ROOT_PASSWORD=my_root_password \
  -e MARIADB_GALERA_CLUSTER_BOOTSTRAP=yes \
  -e MARIADB_USER=my_user \
  -e MARIADB_PASSWORD=my_password \
  -e MARIADB_DATABASE=my_database \
  -e MARIADB_REPLICATION_USER=my_replication_user \
  -e MARIADB_REPLICATION_PASSWORD=my_replication_password \
  -e MARIADB_PORT_NUMBER=${MYQSL_PORT} \
  -e MARIADB_EXTRA_FLAGS="--server-id=${SERVER_ID_PER_CLUSTER};--log-slave-updates=ON;--wsrep-node-incoming-address=${MYQSL_PORT};--wsrep-node-name=${NODE_NAME};--wsrep_provider_options=ist.recv_addr=${HOST}:${IST_PORT};ist.recv_bind=0.0.0.0:${IST_PORT} --wsrep_node_incoming_address=${HOST}  --wsrep_sst_receive_address=${HOST}:${SST_PORT} --wsrep_node_address=${HOST}:${GALERA_PORT}" \
  -p ${GALERA_PORT}:${GALERA_PORT} \
  -p ${IST_PORT}:${IST_PORT} \
  -p ${SST_PORT}:${SST_PORT} \
  bitnami/mariadb-galera:latest

  docker logs -f ${NODE_NAME}