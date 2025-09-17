CREATE DATABASE IF NOT EXISTS airbnb_mysql;
USE airbnb_mysql;

/*
CREATE TABLE `hosts`(
    `host_ID` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `host_name` VARCHAR(255) NOT NULL
);
*/
CREATE TABLE `neighbourhood_groups`(
    `ng_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);
CREATE TABLE `neighbourhoods`(
    `neighbourhood_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `ng_id` INT UNSIGNED NOT NULL,
    FOREIGN KEY(`ng_id`) REFERENCES `neighbourhood_groups`(`ng_ID`)
);
CREATE TABLE `rooms_type`(
    `room_type_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `type` VARCHAR(255) NOT NULL
);
CREATE TABLE `listings`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    -- `host_id` BIGINT UNSIGNED NOT NULL,
    `neighbourhood_id` INT UNSIGNED NOT NULL,
    `room_type_id` INT UNSIGNED NOT NULL,
    `price` INT NOT NULL,
    `minimun_nights` INT NOT NULL,
    `availability_365` INT NOT NULL,
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

select * from airbnb_mysql.neighbourhood_groups;
select * from airbnb_mysql.neighbourhoods;

select name from airbnb_mysql.neighbourhood_groups as ng
	where ng_id  in (
select distinct ng_id  from airbnb_mysql.neighbourhoods as n);

select * from airbnb_mysql.neighbourhoods order by name ASC;

