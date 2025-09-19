CREATE DATABASE IF NOT EXISTS airbnb_mysql;

/*
Schema References:
The listings table holds individual Airbnb listings, with fields for price, minimum nights, room type, neighborhood, and availability.
The neighbourhoods table links each listing to a neighborhood, which is part of a borough (neighbourhood_groups table).
The rooms_type table describes the type of room for each listing.
*/

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

-- Simple SQl queries to validate data loading in each table --

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
select distinct ng_id from airbnb_mysql.neighbourhoods as n);

select name from airbnb_mysql.neighbourhoods as n
	where ng_id  in (
select ng_id from airbnb_mysql.neighbourhood_groups as ng 
	where ng.name in ('Manhattan'));

-- Simple JOIN SQl queries to validate Foreign keys constraints between tables. --

-- Count listings per neighbourhood (showing both neighbourhood and neighbourhood_group):
SELECT 
    ng.name AS neighbourhood_group,
    n.name AS neighbourhood,
    COUNT(*) AS listings_count
FROM listings l
JOIN neighbourhoods n ON l.neighbourhood_id = n.neighbourhood_ID
JOIN neighbourhood_groups ng ON n.ng_id = ng.ng_ID
GROUP BY ng.name, n.name
ORDER BY listings_count DESC;

-- Count listings per neighbourhood_group (borough):
SELECT 
    ng.name AS neighbourhood_group,
    COUNT(*) AS listings_count
FROM listings l
JOIN neighbourhoods n ON l.neighbourhood_id = n.neighbourhood_ID
JOIN neighbourhood_groups ng ON n.ng_id = ng.ng_ID
GROUP BY ng.name
ORDER BY listings_count DESC;

-- Count listings per type of room
SELECT
    rt.type AS room_type,
    COUNT(*) AS listings_count
FROM listings l
JOIN rooms_type rt ON l.room_type_id = rt.room_type_ID
GROUP BY rt.type
ORDER BY listings_count DESC;

-- Count listings per type of room and per neighbourhood_group
SELECT
    ng.name AS neighbourhood_group,
    rt.type AS room_type,
    COUNT(*) AS listings_count
FROM listings l
JOIN neighbourhoods n ON l.neighbourhood_id = n.neighbourhood_ID
JOIN neighbourhood_groups ng ON n.ng_id = ng.ng_ID
JOIN rooms_type rt ON l.room_type_id = rt.room_type_ID
GROUP BY ng.name, rt.type
ORDER BY ng.name, listings_count DESC;
