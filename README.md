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
- [Data migration]()
- [Table alterations]()
  - [Data normalization]()
  - [Table constraints]()
- [Creating views]()
- [Automating database activity]
  - [Triggers and stored procedures]()
- [Assign user roles and Privileges]()
- [Query optimization and scalability strategies]()
- [Backup and recovery]()
- [Database security]()
- [Database documentation and dictionary]()

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

# Data migration

At this stage, the database to hold the business data has been created and the next step is to create the tables that would hold the data. Next step is to migrate data from the excel files provided into the database schema. While migrating the data I kept the following in mind:
-	What tables are present and how do they connect to each other?
-	What primary keys, foreign keys, constraints, data validation and integrity can be enforced.

Data migration can be achieved in two different ways:
- Using the Table Import wizard on MySQL Workbench to import the data
- Using LOAD DATA INFILE on MySQL Shell to load the data into a table

I used the second method as it is efficient to load large data(in excel/csv files) into databases in record time. I also used the data import wizard to import one of the files in json format. The script below contains the SQL scripts used to import the customers information into a table in the olist stores database. The full scripts can be found in my SQL file.

```sql
-- Specifies and activates the required database
USE olist_stores;
------------------------------------------

-- Drops table if it exists
DROP TABLE IF EXISTS customers;

-- To create the table for the customers data
CREATE TABLE customers (
	customer_id	VARCHAR(50) PRIMARY KEY NOT NULL,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT NOT NULL
);

-- To insert data into the newly created table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' 
-- For a csv file - it defines the field seperator in a csv file
ENCLOSED BY '"' -- For the strings
LINES TERMINATED BY '\n' -- This defines the line terminator in the csv file. It indicates that each record is terminated by a newline character('\n')
IGNORE 1 ROWS; -- instructs mysql to ignore the first row of the csv file since the first row contain headers, and these headers are not needed since they have been created above

```

# Table alterations

## Data normalization

After importing the tables into the database, I observed that some table data were denormalized. Data normalization is used to eliminate redundant data, minimise data modification errors, and simplify the query process. I followed the three step normalization method to go through the database plan and address whatsoever may cause data integrity issues. They are as follows:

- First Normal form (1NF): this deals with data atomicity, i.e ensuring that each field contains one type of information. All tables imported passed this check.
- Second Normal Form (2NF): handles partial dependency where one column only depends on part of the primary key (commonly present in tables with composite/compound keys). The tables scaled through this step.
- Third Normal form: this tackles transitive dependency where a column depends on a column which depends on the primary key. 

I also observed that the tables below contained redundant data that could cause data modification errors:
- order_payments

<p align="center">
    <img width="800" src="https://github.com/HannahIgboke/A-Scalable-Database-system-for-Olist-store/blob/main/Building%20a%20scalable%20Database%20system%20for%20Olist%20store/Images/order_payments.PNG" alt="order_payments">
</p>

The payments_type column contains values that upon any sort of modification - deletion or update would cause errors. To rectify this, I used the SQL script below to create a table: payment_type containing information solely about the types of payment available on the olist store platform.

```sql

/*Data normalization to reduce redenudancy
The SQL technique I used to normalize my data is the CTAS (CREATE TABLE AS SELECT) method to create a table 
where each payment type would have its own id for easy reference and data update*/

DROP TABLE IF EXISTS payment_kind;

CREATE TABLE payment_kind (
		payment_kind_id INT AUTO_INCREMENT PRIMARY KEY,
        types VARCHAR(20) NOT NULL
);

INSERT INTO payment_kind (types)
SELECT DISTINCT payment_type
FROM order_payments;

-- To check if it was successful
SELECT *
FROM payment_kind;

-- To rename the table
RENAME TABLE payment_kind TO payment_type;

```

The reviewed tables are as follows

order_payments                                                                                                   |payment_type                     
-----------------------------------------------------------------------------------------------------------------|---------------------------
![order_payments](Building%20a%20scalable%20Database%20system%20for%20Olist%20store/Images/order_payments2.PNG)  |![payment_type](Building%20a%20scalable%20Database%20system%20for%20Olist%20store/Images/payment_type.PNG)    


- products

The same concept as the above applies here

<p align="center">
    <img width="800" src="https://github.com/HannahIgboke/A-Scalable-Database-system-for-Olist-store/blob/main/Building%20a%20scalable%20Database%20system%20for%20Olist%20store/Images/products.PNG" alt="products">
</p>

The reviewed are seen below

products                                                                                                   |product_category_translation                    
-----------------------------------------------------------------------------------------------------------|---------------------------
![products](Building%20a%20scalable%20Database%20system%20for%20Olist%20store/Images/products2.PNG)  |![product_category_translation](Building%20a%20scalable%20Database%20system%20for%20Olist%20store/Images/product_category_translation.PNG)    


## Table constraints

Table constraints are used to enforce data integrity in a database. This means having correct data as a result of certain database rules. For the olist store database it meant ensuring there are no broken relationships between the tables in the Database, incorrect values and presence of duplicates. Data integrity is divided into:

- Entity integrity: to ensure unique entries – table keys.
- 
Some tables in the database contained natural primary keys while others don't. I had to create primary keys for the tables devoid of primary keys. 

```sql
-- For the order_reviews table

ALTER TABLE order_reviews
ADD COLUMN review_id INT AUTO_INCREMENT PRIMARY KEY;

-- For the order_payments

ALTER TABLE order_payments
ADD COLUMN order_payment_id INT AUTO_INCREMENT PRIMARY KEY

```


- Referential integrity: to ensure connection between the tables in the database – Foreign key constraints

```sql
-- Foreign key constraints for the order_items table

ALTER TABLE order_items
-- On deletion of an order_id from the orders table, the record in the order_items table is removed as well.
ADD CONSTRAINT order_id_fk FOREIGN KEY(order_id) 
	REFERENCES orders(order_id) 
    ON DELETE CASCADE,

/* When a product is deleted, it sets the product_id value in the order_items table to null, 
if however the product_id has been updated, it updates the product_id in the order_items table
*/

ADD CONSTRAINT product_id_fk FOREIGN KEY(product_id) 
	REFERENCES products(product_id) 
	ON DELETE SET NULL
    ON UPDATE CASCADE,

/* When a sellers info is deleted, it sets the seller's value in the order_items table to null, 
if however the seller_id has been updated, it updates the seller_id in the order_items table
*/

ADD CONSTRAINT seller_id_fk FOREIGN KEY(seller_id) 
	REFERENCES sellers(seller_id) 
	ON DELETE SET NULL
    ON UPDATE CASCADE;


```
The full scripts for the foreign key constraints can be found here.


- Domain integrity: to enforce a set of rules i.e acceptable values or range of what we’re storing in a database – data type rules
For most tables I enforced domain integrity on creation of the tables. For some tables, these were enforced during modification of the tables.

```sql
-- This alters the orders table and modifies the data type for each column
ALTER TABLE orders
MODIFY COLUMN order_id VARCHAR(50) NOT NULL PRIMARY KEY,
MODIFY COLUMN customer_id VARCHAR(50) NOT NULL,
MODIFY COLUMN order_status VARCHAR(20) NOT NULL,
MODIFY COLUMN order_purchase_timestamp TIMESTAMP NOT NULL,
MODIFY COLUMN order_approved_at DATETIME,
MODIFY COLUMN order_delivered_carrier_date DATETIME,
MODIFY COLUMN order_delivered_customer_date DATETIME,
MODIFY COLUMN order_estimated_delivery_date DATETIME NOT NULL;

```

At this point, I also drew a sketch of what the final database is supposed to look like to view the relationship between tables

# Creating views
At this point the database for Olist stores have been setup, populated and functional. Olist store manager has made the following requests:
- Order history view
- Product summary view
- Yearly and monthly sales trend 

The views requeted above are intended to created a unified view to make analysis and reporting easier.
Database views are virtual tables that don't store data themselves but provide a customized way to look at data from one or more underlying base tables.

```sql
/* A. Order history view

Olist store sales team would like to easily access and view the history of all orders in the store. They would like
to see all orders placed, what customers placed them, the quanity of goods ordered, the status of the order as 
well as the total payment for that order.
*/

CREATE VIEW order_history AS
SELECT  c.customer_id,
		o.order_id,
        o.order_purchase_timestamp,
        o.order_status,
        COUNT(order_item_id) AS order_quantity,
        SUM(oi.price + oi.freight_value) AS total_amount
FROM orders AS o
LEFT JOIN customers AS c
	ON o.customer_id = c.customer_id
LEFT JOIN order_items AS oi
	ON o.order_id = oi.order_id
GROUP BY o.order_id;

```

The full sql scripts can be found here.

# Automating database activity
## Triggers


## Stored procedures



