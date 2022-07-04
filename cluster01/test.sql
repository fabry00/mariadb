CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;

CREATE TABLE IF NOT EXISTS tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(255)
);

INSERT INTO tasks (`text`) VALUES ("asdas");
SELECT * FROM tasks;


# Circular replicaiton

USE mydb_2;
SELECT * FROM tasks_2;