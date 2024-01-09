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


-----------------------------------------------------------------------------------------------

-- Drops table if it exists
DROP TABLE IF EXISTS order_items;

-- To create the table for the order_items data
CREATE TABLE order_items (
		order_id VARCHAR(50) NOT NULL,	
        order_item_id INT NOT NULL,
        product_id VARCHAR(50) NOT NULL,
        seller_id VARCHAR(50) NOT NULL,
        shipping_limit_date	DATETIME NOT NULL,
        price DECIMAL (10,2) NOT NULL, -- Choosen for scalability to be able to accomodate higher price points
        freight_value DECIMAL(5,2) NOT NULL
);

-- To insert into the newly created table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

----------------------------------------------------------------------------------

-- Drops table if exists
DROP TABLE IF EXISTS order_reviews;

-- To create the table for the order_reviews data 
CREATE TABLE order_reviews (
			review_id VARCHAR(50) NOT NULL,
            order_id VARCHAR(50) NOT NULL,
            review_score INT NOT NULL,
            review_comment_title VARCHAR(50) DEFAULT NULL,	
            review_comment_message TEXT DEFAULT NULL,
            review_creation_date DATETIME NOT NULL,
            review_answer_timestamp TIMESTAMP NOT NULL
);

-- To insert data into the newly created table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_order_reviews_dataset.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

------------------------------------------------------------------

-- Drops table if exists
DROP TABLE IF EXISTS order_payments;

-- To create the table for the order_payments data
CREATE TABLE order_payments (
		order_id VARCHAR(50) NOT NULL,
        payment_sequential INT NOT NULL,
        payment_type VARCHAR(50) NOT NULL,
        payment_installments INT NOT NULL,
        payment_value DECIMAL(10,2) NOT NULL
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_order_payments_dataset.csv'
INTO TABLE order_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

----------------------------------------------------------------------

-- Drops table if exists
DROP TABLE IF EXISTS sellers;

-- To create the table for sellers data
CREATE TABLE sellers (
		seller_id VARCHAR(50) PRIMARY KEY,
        seller_zip_code_prefix INT NOT NULL
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

------------------------------------------------------------------ 

-- Drops table if exists
DROP TABLE IF EXISTS orders;

/* Due to issues encountered during the load infile process for the orders table, 
I used the table data import wizard to import the json type version of the orders table data.  
*/
-------------------------------------------------------------------------

-- Drops table if exists 
DROP TABLE IF EXISTS products;

-- To create the table for products data
CREATE TABLE products (
		product_id VARCHAR(50) PRIMARY KEY NOT NULL,
        product_category_name VARCHAR(100) DEFAULT NULL,	
        product_name_length	VARCHAR(50) DEFAULT NULL,
        product_description_length VARCHAR(50) DEFAULT NULL,	
        product_photos_qty VARCHAR(50) DEFAULT NULL,
        product_weight_g VARCHAR(50) DEFAULT NULL,
        product_length_cm VARCHAR(50) DEFAULT NULL,
        product_height_cm VARCHAR(50) DEFAULT NULL,
        product_width_cm VARCHAR(50) DEFAULT NULL
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-----------------------------------------------

-- Drops the table if exists 
DROP TABLE IF EXISTS product_cat_name_translation;

-- To create the table for product_cat_name_translation
CREATE TABLE product_cat_name_translation (
	product_category_name VARCHAR(100) PRIMARY KEY NOT NULL,	
    product_category_name_english VARCHAR(50) NOT NULL
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\product_category_name_translation.csv'
INTO TABLE product_cat_name_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- To verify if all the tables were created
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = "olist_stores";
