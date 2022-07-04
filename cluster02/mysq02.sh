#!/bin/bash
NODE_NAME="cluster02-node-02"
docker exec -it ${NODE_NAME} mysql -h 127.0.0.1 -u root -P 8510 -pmy_root_password 