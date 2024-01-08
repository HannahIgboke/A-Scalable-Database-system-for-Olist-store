<div align="center">
  
  # A Scalable Database system for Olist store 🏪 
</div>


<div align="center">
  
   _A Database design project_ 
</div>

------------------------------------------------------------------------------------------------------------

<p align="center">
    <img width="800" src="https://github.com/HannahIgboke/A-Scalable-Database-system-for-Olist-store/blob/main/Building%20a%20scalable%20Database%20system%20for%20Olist%20store/Images/Olist.jpg" alt="Olist">
</p>

Olist, one of the largest department stores in Brazilian marketplaces connects small businesses from all over Brazil to channels without hassle and with a single contract. Those merchants are able to sell their products through the Olist Store and ship them directly to the customers using Olist logistics partners. Currently, Olist has information of 100,000 orders from 2016 to 2018 made at multiple marketplaces in Brazil stored in several excel files.

With recent information during the board meeting, Olist store manager has been informed of the projected triple in sales and data volume in the coming years and the need to build a more robust system for data collection, retrieval and organization to monitor business performance.

# Project overview

The aim of this project is to develop(design and build) a comprehensive and scalable database system for Olist store to handle potential increase in data volume and allow for more efficient data collection, retrieval and organization.

## Features

Olist stores have the following data in excel files:
-	Customers information
-	Order items
-	Order payments
-	Order reviews
-	Orders details
-	Products
-	Sellers information
-	Product category name translation

## Project breakdown

I conducted a comprehensive analysis of the company's background, posed insightful questions about its processes and methods, and carefully reviewed the project aims and objectives. From the information gathered, I have delineated the project into the following stages to guarantee the achievement of all project objectives:

- [Database setup and creation]()
-	[Data migration, table constraints and creating EER diagram]()
-	[Creating views]()
-	[Automating database activity – triggers and stored procedures]()
-	[Assign user roles and Privileges]()
-	[Query optimization and scalability strategies]()
-	[Backup and recovery]()
-	[Database security]()
-	[Database documentation and dictionary]()

**Tool used**: The Olist store database system is built on MySQL RDBMS.

# Database setup and creation

To setup the database I considered the following:

-	What Character encoding to use? It is a method used to represent characters(letters, digits, symbols) as binary numbers read about it [here](https://www.motionpoint.com/blog/the-importance-of-character-encoding-website-translation-user-experience/) – I used utf8mb4 a chacrater encoding type that accommodates a diverse character especially in a case like this for a Brazillian department store.
-	What Scalability strategies can be implemented?

After this considerations, I proceeded to create and setup my database

```sql
-- Drops database if it exists
DROP DATABASE IF EXISTS olist_stores;

-- Creating the database using character encoding of utf-8
CREATE DATABASE olist_stores DEFAULT CHARACTER SET utf8mb4;

-- To check if the database was created
SHOW DATABASES;

-- to make the olist_stores the active database
USE olist_stores;
```

# Data migration, table constraints and creating EER diagram

## Data migration

At this stage, the database to hold the business data has been created and the next step is to migrate data from the excel files provided into the database schema. While migrating the data I kept the following in mind:
-	What tables are present and how do they connect to each other?
-	What primary keys, foreign keys, constraints, data validation and integrity can be enforced.

Data migration can be achieved in two different ways:
- Using the Table Import wizard on MySQL Workbench to import the data
- Using LOAD DATA INFILE on MySQL Shell to load the data into a table

# Table constraints


I used the second method as it is efficient to load large data(in excel/csv files) into databases in record time. I also used the data import wizard to import one of the files in json format.




