#!/bin/bash
NODE_NAME="Cluster01-node-02"
docker exec -it ${NODE_NAME} mysql -h 127.0.0.1 -u root -P 7500 -pmy_root_password 