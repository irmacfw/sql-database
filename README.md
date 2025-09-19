For this project we will be using the New York City Airbnb Open Data from Kaggle:
http://kaggle.com/datasets/dgomonov/new-york-city-airbnb-open-data

# NYC Airbnb Data Analysis & SQL Database Project

## Overview

This project provides a structured SQL database and a set of data analysis tools for exploring Airbnb listings in New York City. The main goal is to facilitate queries and visualizations that help understand pricing, room types, availability, and spatial distribution of listings across NYC boroughs and neighborhoods.

The database is designed from the original Airbnb NYC dataset (`AB_NYC_2019.csv`) and is complemented by Python notebooks for data cleaning, transformation, and insights extraction. The SQL schema is based on best practices for relational modeling and supports efficient queries for typical Airbnb-related business questions.

## Database Schema

The project implements a normalized relational schema with four main tables:

![image1](https://github.com/luispabloaiello-da/sql-database/blob/main/drawSQL-image-export-2025-09-16.png)

- **neighbourhood_groups**  
  - `ng_ID` (int, PK): Unique ID for each borough/group  
  - `name` (varchar): Borough name (e.g. Brooklyn, Manhattan)

- **neighbourhoods**  
  - `neighbourhood_ID` (int, PK): Unique ID for each neighborhood  
  - `name` (varchar): Neighborhood name (e.g. Harlem, Midtown)  
  - `ng_id` (int, FK): References `neighbourhood_groups.ng_ID`

- **rooms_type**  
  - `room_type_ID` (int, PK): Unique ID for each room type  
  - `type` (varchar): Room type (e.g. Private room, Entire home/apt)

- **listings**  
  - `id` (int, PK): Listing ID  
  - `name` (varchar): Listing name  
  - `neighbourhood_id` (int, FK): References `neighbourhoods.neighbourhood_ID`  
  - `room_type_id` (int, FK): References `rooms_type.room_type_ID`  
  - `price` (int): Price per night  
  - `minimun_nights` (int): Minimum nights required  
  - `availability_365` (int): Days available per year

> See image above for a visual ER diagram (drawSQL).

## Data Preparation & Loading

Data is cleaned and transformed using Python (Pandas), following these steps:

1. **Data Cleaning:**  
   - Remove irrelevant columns and rows with missing names.
   - Standardize textual fields (listing names, remove punctuation).
   - Export reference lists (neighbourhoods and room types) for easy SQL population.

2. **Database Population:**  
   - Tables are created using `drawSQL-mysql.sql`.
   - Data is inserted using SQL scripts and/or CSV imports.
   - Foreign key constraints ensure data integrity between tables.

3. **Analysis-ready Data:**  
   - The cleaned DataFrame is used for further visualizations and SQL insights.

## Example Insights & SQL Queries

The project includes a set of pre-defined SQL queries in `insightsSQL-mysql.sql` to answer business questions such as:

- **Average Price by Borough:**  
  Calculate average price and number of listings per borough.

- **Most Frequent Room Type by Borough:**  
  Find the most common room type in each borough.

- **Average Minimum Nights by Borough:**  
  Get average minimum stay required per borough.

- **Availability vs Price Buckets:**  
  Group listings by availability ranges and show average price.

- **Top 5 Most Expensive Neighborhoods (min listings):**  
  Show neighborhoods with the highest average prices (with at least 30 listings).

Each query is documented in the SQL file with explanations and is designed to be run directly against the `airbnb_mysql` database.

## Data Analysis & Visualization

The Jupyter notebook (`Insights.ipynb`) demonstrates:

- Data cleaning and transformation steps.
- Exploratory analysis and summary statistics.
- Key visualizations (using matplotlib/seaborn), e.g.:
  - Average price per borough.
  - Most frequent room type by borough.
  - Minimum nights by borough.
  - Price distribution by availability.
  - Most expensive neighborhoods plot.

Custom Python functions (in `src/functions.py`, referenced but not included here) are used for plotting and further data manipulation.

## How to Use

1. **Set up the MySQL database:**  
   - Run the table creation and data insertion commands in `drawSQL-mysql.sql`.
   - Use provided CSVs for bulk data import if needed.

2. **Run analysis notebooks:**  
   - Open `Insights.ipynb` and execute code cells for data cleaning and visualization.
   - Use the functions for generating plots and inspecting data.

3. **Query the database:**  
   - Use queries from `insightsSQL-mysql.sql` to extract insights.
   - Adapt queries as needed for deeper exploration.

## Notes

- The database is designed for read-heavy analytical workloads, not transactional updates.
- The schema and scripts are based strictly on the original Airbnb NYC dataset and do not invent additional features.
- All data cleaning and transformation steps are documented in the notebooks.
- For details on reference tables (neighborhoods, room types), see the exported CSV files or scripts.

## Files Included

- `drawSQL-mysql.sql` — SQL table creation and sample inserts.
- `insightsSQL-mysql.sql` — Documented SQL queries for insights.
- `Insights.ipynb` — Data cleaning and visualization notebook.
- `sql-database.ipynb` — Data exploration and preparation notebook.
- Reference CSVs: `NYC_Neighbourhoods_2019.csv`, `NYC_Airbnb_Room_Types_ID.csv`, etc.

## Presentation Slides
[Link to Slides](https://docs.google.com/presentation/d/1fDsE9lEGz5-o3DHoFpw40KqCYZZhyjZGlEdcj_FNNJ0/edit?slide=id.p1#slide=id.p1)

## Authors
- Ricardo Castanheira
- Irma Fernandez
- Janna Julian
- Luis Pablo Aiello

## License

This project is for educational and analytical purposes only. Data is derived from publicly available Airbnb NYC datasets.