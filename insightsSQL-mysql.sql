-- Setting the working database
USE airbnb_mysql;

-- 6 Queries for insights

-- A) Average price per Neighbourhood Group in New York
/*
What does it do?
This query calculates the average price of Airbnb listings in each borough of New York City.
It also counts how many listings are in each borough.

How does it work?
It combines (joins) the listings table with the neighbourhoods and neighbourhood_groups tables to link each listing to its borough.
For each borough, it calculates:
The average price (rounded to two decimals).
The total number of listings.
Results are sorted so the borough with the highest average price comes first.
*/
SELECT ng.name AS borough, ROUND(AVG(l.price),2) AS avg_price, COUNT(*) AS listings
FROM airbnb_mysql.listings as l
JOIN neighbourhoods n ON l.neighbourhood_id = n.neighbourhood_ID
JOIN airbnb_mysql.neighbourhood_groups ng ON n.ng_ID = ng.ng_ID
GROUP BY ng.name
ORDER BY avg_price DESC;

-- B) Most frequent room type per Neighbourhood Group in New York
/*
What does it do?
This query finds the most common type of Airbnb room (e.g., entire home, private room) in each borough.

How does it work?
It joins listings to rooms_type, neighbourhoods, and neighbourhood_groups to link each listing to its borough and room type.
It counts how many times each room type appears in each borough.
Using a “window function” (ROW_NUMBER), it ranks the room types by frequency for each borough.
It then selects only the top-ranked (most frequent) room type per borough
*/
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

-- C) Average minimum nights per Neighbourhood Group in New York
/*
What does it do?
This query calculates the average minimum stay requirement (in nights) for Airbnb listings in each borough.

How does it work?
It joins listings, neighbourhoods, and neighbourhood_groups to link each listing to its borough.
It calculates the average “minimum_nights” field for each borough, rounded to one decimal.
Results are sorted with the borough requiring the longest average minimum stay at the top.
*/
SELECT ng.name AS borough, ROUND(AVG(l.minimun_nights),1) AS avg_min_nights
FROM airbnb_mysql.listings as l
JOIN airbnb_mysql.neighbourhoods as n ON l.neighbourhood_id = n.neighbourhood_ID
JOIN airbnb_mysql.neighbourhood_groups as ng ON n.ng_ID = ng.ng_ID
GROUP BY ng.name
ORDER BY avg_min_nights DESC;

-- D) Availability vs price (buckets)
/*
What does it do?
This query groups listings into four buckets, depending on how many nights per year they’re available (“availability_365”).
For each bucket, it shows the average price and the number of listings.

How does it work?
It uses a CASE statement to create four availability ranges: 0–90, 91–180, 181–270, and 271–365 days.
It calculates the average price and counts listings for each group.
Results are sorted by the availability bucket.
*/
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
/*
What does it do?
This query finds the five neighborhoods with the highest average Airbnb prices, but only if the neighborhood has at least a minimum number 
of listings (though the query currently allows any count with HAVING COUNT(*) >= 1; typical usage might be >= 30).

How does it work?
It joins listings, neighbourhoods, and neighbourhood_groups to link each listing to its borough and neighborhood.
It calculates the average price and counts listings for each neighborhood.
It only includes neighborhoods with at least the minimum required listings (should be set to 30 for the original intention).
Results are sorted by average price (highest first) and limited to the top 5.
*/
SELECT
  ng.name AS borough,
  n.name  AS neighborhood,
  ROUND(AVG(l.price), 2) AS avg_price,
  COUNT(*) AS listings
FROM airbnb_mysql.listings as l
JOIN airbnb_mysql.neighbourhoods as n  ON l.neighbourhood_id = n.neighbourhood_ID
JOIN airbnb_mysql.neighbourhood_groups as ng ON n.ng_ID = ng.ng_ID
GROUP BY ng.name, n.name
HAVING COUNT(*) >= 30           
ORDER BY avg_price DESC
LIMIT 5;