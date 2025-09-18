\# Mini Project – SQL: From Data to Insight  

\#\# Airbnb NYC Case Study


\---

\#\# 👥 Team Members

\- Irma Fernandez  

\- Janna Julian  

\- Luis Pablo  

\- Ricardo Castanheira


\---

\#\#\# 🎯 Project Overview

This project explores the \*\*business opportunity\*\* of opening a new Airbnb listing in New York City.  

We use the \*\*NYC Airbnb dataset (Kaggle)\*\* to analyze pricing, availability, and room types across boroughs, generating insights for potential hosts.

\---

\#\#\# 📅 Project Plan (Daily Tasks)

\#\#\#\# Day 1 – Project Kickoff & Data Selection 

\- Choose project topic & business case

\- Defined business opportunity: \*Evaluate potential for opening an Airbnb listing in NYC\*  

\- Hypotheses:  

  1\. Manhattan is the most profitable area  

  2\. Entire homes/apartments are more in demand  

  3\. 365-day availability correlates with revenue potential  

\- Created project board (Trello/Jira) for task distribution  

\[Project Board\](https://trello.com/b/fOyKPVLN)

\---

\#\#\#\# Day 2 – Data Understanding & Schema Design

\- Explored dataset and performed data cleaning (removed duplicates, capped outliers, handled missing values, fixed formatting issues)  

\- Designed \*\*Entity Relationship Diagram (ERD)\*\* with 4 tables:  

  \- \`neighbourhood\_groups\`  

  \- \`neighbourhoods\`  

  \- \`rooms\_type\`  

  \- \`listings\`  

\- Created MySQL database schema (\`CREATE DATABASE\` & \`CREATE TABLE\` statements)  

\- Loaded cleaned data into normalized tables


\---

\#\#\#\# Day 3 – SQL Queries & Analysis

\- Wrote SQL queries to answer business questions:  

  \- Average price by borough  

  \- Most common room type per borough  

  \- Minimum nights average  

  \- Availability buckets vs. price  

  \- Top 5 most expensive neighborhoods  

\- Validated results with joins, \`GROUP BY\`, and subqueries  

\- Saved queries in \`.sql\` files inside repo


\---

\#\#\#\# Day 4 – Analysis, Visualization & Data Story

\- Connect database to Python using \*\*pandas\*\* or \*\*SQLAlchemy\*\* to visualize insights  

\- Created meaningful visualizations:  

  1\. Bar chart – Average price by borough  

  2\. Pie chart – Room type distribution  

  3\. Scatterplot – Availability vs. Price  

\- Compiled findings into final Jupyter Notebook report  

\- Finalized README with \*\*Data Story\*\* section  

\- Designed project presentation (Google Slides/Canva)


\---

\#\# 📖 Data Story

This project analyzes \*\*Airbnb listings in NYC\*\* to uncover insights about:

\- Pricing trends by neighborhood and room type  

\- Availability patterns throughout the year  

\- How location and listing characteristics influence rental prices  

\- Supporting data-driven decisions and storytelling

\#\#\# Connecting to the Database in Python

You can load data from MySQL into Python using either \*\*pandas\*\* or \*\*SQLAlchemy\*\*.

\#\#\#\# Using pandas

\`\`\`python

import pandas as pd

import mysql.connector

\# Connect to MySQL

conn \= mysql.connector.connect(

    host='localhost',

    user='your\_username',

    password='your\_password',

    database='airbnb\_miniproject\_mysql'

)

\# Load listings table

df\_listings \= pd.read\_sql("SELECT \* FROM listings", conn)

print(df\_listings.head())

\# Mini Project – SQL: From Data to Insight  

\#\# Airbnb NYC Case Study


\---

\#\# 👥 Team Members

\- Irma Fernandez  

\- Janna Julian  

\- Luis Pablo  

\- Ricardo Castanheira


\---

\#\#\# 🎯 Project Overview

This project explores the \*\*business opportunity\*\* of opening a new Airbnb listing in New York City.  

We use the \*\*NYC Airbnb dataset (Kaggle)\*\* to analyze pricing, availability, and room types across boroughs, generating insights for potential hosts.

\---

\#\#\# 📅 Project Plan (Daily Tasks)

\#\#\#\# Day 1 – Project Kickoff & Data Selection 

\- Choose project topic & business case

\- Defined business opportunity: \*Evaluate potential for opening an Airbnb listing in NYC\*  

\- Hypotheses:  

  1\. Manhattan is the most profitable area  

  2\. Entire homes/apartments are more in demand  

  3\. 365-day availability correlates with revenue potential  

\- Created project board (Trello/Jira) for task distribution  

\[Project Board\](https://trello.com/b/fOyKPVLN)

\---

\#\#\#\# Day 2 – Data Understanding & Schema Design

\- Explored dataset and performed data cleaning (removed duplicates, capped outliers, handled missing values, fixed formatting issues)  

\- Designed \*\*Entity Relationship Diagram (ERD)\*\* with 4 tables:  

  \- \`neighbourhood\_groups\`  

  \- \`neighbourhoods\`  

  \- \`rooms\_type\`  

  \- \`listings\`  

\- Created MySQL database schema (\`CREATE DATABASE\` & \`CREATE TABLE\` statements)  

\- Loaded cleaned data into normalized tables


\---

\#\#\#\# Day 3 – SQL Queries & Analysis

\- Wrote SQL queries to answer business questions:  

  \- Average price by borough  

  \- Most common room type per borough  

  \- Minimum nights average  

  \- Availability buckets vs. price  

  \- Top 5 most expensive neighborhoods  

\- Validated results with joins, \`GROUP BY\`, and subqueries  

\- Saved queries in \`.sql\` files inside repo


\---

\#\#\#\# Day 4 – Analysis, Visualization & Data Story

\- Connect database to Python using \*\*pandas\*\* or \*\*SQLAlchemy\*\* to visualize insights  

\- Created meaningful visualizations:  

  1\. Bar chart – Average price by borough  

  2\. Pie chart – Room type distribution  

  3\. Scatterplot – Availability vs. Price  

\- Compiled findings into final Jupyter Notebook report  

\- Finalized README with \*\*Data Story\*\* section  

\- Designed project presentation (Google Slides/Canva)


\---

\#\# 📖 Data Story

This project analyzes \*\*Airbnb listings in NYC\*\* to uncover insights about:

\- Pricing trends by neighborhood and room type  

\- Availability patterns throughout the year  

\- How location and listing characteristics influence rental prices  

\- Supporting data-driven decisions and storytelling

\#\#\# Connecting to the Database in Python

You can load data from MySQL into Python using either \*\*pandas\*\* or \*\*SQLAlchemy\*\*.

\#\#\#\# Using pandas

\`\`\`python

import pandas as pd

import mysql.connector

\# Connect to MySQL

conn \= mysql.connector.connect(

    host='localhost',

    user='your\_username',

    password='your\_password',

    database='airbnb\_miniproject\_mysql'

)

\# Load listings table

df\_listings \= pd.read\_sql("SELECT \* FROM listings", conn)

print(df\_listings.head())

