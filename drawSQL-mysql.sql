CREATE DATABASE IF NOT EXISTS airbnb_mysql;

-- Setting the working database
USE airbnb_mysql;

-- Display all available tables in the Sakila database.
SHOW TABLES;

/*
CREATE TABLE `hosts`(
    `host_ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `host_name` VARCHAR(255) NOT NULL
);
*/
CREATE TABLE `neighbourhood_groups`(
    `ng_ID` int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);
CREATE TABLE `neighbourhoods`(
    `neighbourhood_ID` int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `ng_id` int UNSIGNED NOT NULL,
    FOREIGN KEY(`ng_id`) REFERENCES `neighbourhood_groups`(`ng_ID`)
);
CREATE TABLE `rooms_type`(
    `room_type_ID` int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `type` VARCHAR(255) NOT NULL
);
CREATE TABLE `listings`(
    `id` int UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    -- `host_id` BIGINT UNSIGNED NOT NULL,
    `neighbourhood_id` int UNSIGNED NOT NULL,
    `room_type_id` int UNSIGNED NOT NULL,
    `price` int NOT NULL,
    `minimun_nights` int NOT NULL,
    `availability_365` int NOT NULL,
    FOREIGN KEY(`neighbourhood_id`) REFERENCES `neighbourhoods`(`neighbourhood_ID`),
    -- FOREIGN KEY(`host_id`) REFERENCES `hosts`(`host_ID`),
    FOREIGN KEY(`room_type_id`) REFERENCES `rooms_type`(`room_type_ID`)
);

INSERT INTO neighbourhood_groups (name)
VALUE ('Brooklyn'),
('Manhattan'),
('Queens'),
('Staten Island'),
('Bronx');

INSERT INTO rooms_type (type)
VALUE ('Private room'),
('Entire home/apt'),
('Shared room');

select * from airbnb_mysql.neighbourhood_groups;
select * from airbnb_mysql.rooms_type;

select * from airbnb_mysql.neighbourhoods;
select COUNT(*) from airbnb_mysql.neighbourhoods;
select * from airbnb_mysql.neighbourhoods order by name ASC;

select * from airbnb_mysql.neighbourhoods where name in ('Kensington');

select COUNT(*) from airbnb_mysql.listings;
select * from airbnb_mysql.listings;

select name from airbnb_mysql.neighbourhood_groups as ng
	where ng_id  in (
select distinct ng_id  from airbnb_mysql.neighbourhoods as n);



