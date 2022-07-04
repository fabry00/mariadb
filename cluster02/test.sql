SHOW DATABASES;
USE mydb;
DESCRIBE tasks;
SELECT * FROM tasks;


# Ciruclar replication

CREATE DATABASE IF NOT EXISTS mydb_2;
USE mydb_2;

CREATE TABLE IF NOT EXISTS tasks_2 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(255)
);

INSERT INTO tasks_2 (`text`) VALUES ("asdas222");
INSERT INTO tasks_2 (`text`) VALUES ("asdas333");
SELECT * FROM tasks_2;