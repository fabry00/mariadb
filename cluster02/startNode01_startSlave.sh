#!/bin/bash
NODE_NAME="cluster02-node-01"
docker exec -it ${NODE_NAME} mysql -h 127.0.0.1 -u root -P 7500 -pmy_root_password
#On primary GRANT REPLICATION SLAVE ON *.*  TO 'my_replication_user'@'%';
# SELECT @@server_id;
# if needed SET GLOBAL server_id=1;
# SET GLOBAL gtid_slave_pos = "0-1-56";
CHANGE MASTER TO
MASTER_HOST="127.0.0.1",
MASTER_PORT=7500,
MASTER_USER="my_replication_user",
MASTER_PASSWORD="my_replication_password",
MASTER_USE_GTID=slave_pos;
# START SLAVE;
#SHOW SLAVE STATUS\G


# Test replica

# Set ciruclar
#On second cluster GRANT REPLICATION SLAVE ON *.*  TO 'my_replication_user'@'%';
# you need to ensure that the second cluster is not accepting any writes other than those that it replicates from the first cluster at this stage.
# second cluster: SHOW GLOBAL VARIABLES LIKE 'gtid_current_pos';

# first cluster
SET GLOBAL gtid_slave_pos = "0-2-60";
CHANGE MASTER TO 
MASTER_HOST="127.0.0.1", 
MASTER_PORT=8500, 
MASTER_USER="my_replication_user",  
MASTER_PASSWORD="my_replication_password", 
MASTER_USE_GTID=slave_pos;
START SLAVE;
