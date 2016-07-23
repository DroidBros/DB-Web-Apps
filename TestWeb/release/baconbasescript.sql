CREATE TABLE users(username varchar(50) NOT NULL, 
password varchar(50) NOT NULL, 
first_name varchar(50),
last_name varchar(50), 
email varchar(100), 
user_type varchar(50) DEFAULT 'customer', 
PRIMARY KEY (username));