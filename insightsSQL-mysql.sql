-- Setting the working database
USE airbnb_mysql;

-- 6 Queries for insights

-- A) Average price per borough
SELECT ng.name AS borough, ROUND(AVG(l.price),2) AS avg_price, COUNT(*) AS listings
FROM airbnb_mysql.listings as l
JOIN neighbourhoods n ON l.neighbourhood_id = n.neighbourhood_ID
JOIN airbnb_mysql.neighbourhood_groups ng ON n.ng_ID = ng.ng_ID
GROUP BY ng.name
ORDER BY avg_price DESC;

-- B) Most frequent room type per borough (MySQL 8 version)
WITH counts AS (
  SELECT ng.name AS borough, r.type, COUNT(*) AS amount,
         ROW_NUMBER() OVER (PARTITION BY ng.name ORDER BY COUNT(*) DESC) AS rn
  FROM airbnb_mysql.listings as l
  JOIN airbnb_mysql.rooms_type as r ON l.room_type_id = r.room_type_ID
  JOIN airbnb_mysql.neighbourhoods as n ON l.neighbourhood_id = n.neighbourhood_ID
  JOIN airbnb_mysql.neighbourhood_groups as ng ON n.ng_ID = ng.ng_ID
  GROUP BY ng.name, r.type
)
SELECT borough, type, amount
FROM counts
WHERE rn = 1
ORDER BY borough;

-- C) Average minimum nights per borough
SELECT ng.name AS borough, ROUND(AVG(l.minimun_nights),1) AS avg_min_nights
FROM airbnb_mysql.listings as l
JOIN airbnb_mysql.neighbourhoods as n ON l.neighbourhood_id = n.neighbourhood_ID
JOIN airbnb_mysql.neighbourhood_groups as ng ON n.ng_ID = ng.ng_ID
GROUP BY ng.name
ORDER BY avg_min_nights DESC;

-- D) Availability vs price (buckets)
SELECT
  CASE
    WHEN availability_365 BETWEEN 0 AND 90 THEN '0–90'
    WHEN availability_365 BETWEEN 91 AND 180 THEN '91–180'
    WHEN availability_365 BETWEEN 181 AND 270 THEN '181–270'
    ELSE '271–365'
  END AS availability_bucket,
  ROUND(AVG(price),2) AS avg_price,
  COUNT(*) AS listings
FROM airbnb_mysql.listings
GROUP BY availability_bucket
ORDER BY availability_bucket;

-- E) Top 5 most expensive neighborhoods (min 30 listings)
SELECT
  ng.name AS borough,
  n.name  AS neighborhood,
  ROUND(AVG(l.price), 2) AS avg_price,
  COUNT(*) AS listings
FROM airbnb_mysql.listings as l
JOIN airbnb_mysql.neighbourhoods as n  ON l.neighbourhood_id = n.neighbourhood_ID
JOIN airbnb_mysql.neighbourhood_groups as ng ON n.ng_ID = ng.ng_ID
GROUP BY ng.name, n.name
HAVING COUNT(*) >= 1            
ORDER BY avg_price DESC
LIMIT 5;