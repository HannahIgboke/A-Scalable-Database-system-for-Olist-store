-- ORDER_ITEMS TABLE

DESCRIBE order_items;

-- In order to impose some foreign key constraints, I need to alter some column properties
ALTER TABLE order_items
MODIFY product_id VARCHAR(50),
MODIFY seller_id VARCHAR(50);

-- To check if it worked
DESCRIBE order_items;

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

--------------------------------------------------------------------------------------------------------------------------------------------

-- ORDERS TABLE

DESCRIBE orders;

-- This updates the orders table and replaces blank cells with NULL values
UPDATE orders
SET order_approved_at = CASE WHEN order_approved_at = '' THEN NULL ELSE order_approved_at END,
	order_delivered_carrier_date = CASE WHEN order_delivered_carrier_date = '' THEN NULL ELSE order_delivered_carrier_date END,
	order_delivered_customer_date = CASE WHEN order_delivered_customer_date = '' THEN NULL ELSE order_delivered_customer_date END;

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

DESCRIBE orders;   

-- To add a column for the cust_review_tag
ALTER TABLE orders
ADD COLUMN cust_review_tag VARCHAR(50);

UPDATE orders
LEFT JOIN order_reviews
ON orders.order_id = order_reviews.order_id
SET orders.cust_review_tag = order_reviews.cust_review_tag;

-- To check if it worked
SELECT *
FROM orders;

-- Next we reorganize the table in the format we want
DROP TABLE IF EXISTS orders2;

CREATE TABLE orders2 (
	order_id VARCHAR(50) NOT NULL PRIMARY KEY,
	customer_id VARCHAR(50) NOT NULL,
	cust_review_tag VARCHAR(50),
	order_status VARCHAR(20) NOT NULL,
	order_purchase_timestamp TIMESTAMP NOT NULL, 
	order_approved_at DATETIME,
	order_delivered_carrier_date DATETIME,
	order_delivered_customer_date DATETIME,
	order_estimated_delivery_date DATETIME NOT NULL
);

INSERT INTO orders2 (
	order_id,
	customer_id,
	cust_review_tag,
	order_status,
	order_purchase_timestamp, 
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date
)

SELECT 
	order_id,
	customer_id,
	cust_review_tag,
	order_status,
	order_purchase_timestamp, 
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date
FROM orders;

-- To check if it worked
SELECT *
FROM orders2;

-- To rename the table
DROP TABLE IF EXISTS orders;
RENAME TABLE orders2 TO orders;


-- To add a column for the order_payment_id
ALTER TABLE orders
ADD COLUMN order_payment_id VARCHAR(50);

UPDATE orders
LEFT JOIN order_payments
ON orders.order_id = order_payments.order_id
SET orders.order_payment_id = order_payments.order_payment_id;

-- To check if it worked
SELECT * FROM orders;

-- Again, we re-organize the orders table
DROP TABLE IF EXISTS orders3;
CREATE TABLE orders3 (	
	order_id VARCHAR(50) NOT NULL PRIMARY KEY, 
	customer_id VARCHAR(50) NOT NULL, 
    order_payment_id VARCHAR(50),
	cust_review_tag VARCHAR(50), 
	order_status VARCHAR(20) NOT NULL, 
	order_purchase_timestamp TIMESTAMP NOT NULL, 
	order_approved_at DATETIME, 
	order_delivered_carrier_date DATETIME, 
	order_delivered_customer_date DATETIME,
	order_estimated_delivery_date DATETIME NOT NULL
);

INSERT INTO orders3 (
	order_id,
	customer_id,
    order_payment_id,
	cust_review_tag,
	order_status,
	order_purchase_timestamp, 
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date
)
SELECT 
	order_id,
	customer_id,
    order_payment_id,
	cust_review_tag,
	order_status,
	order_purchase_timestamp, 
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date
FROM orders;

-- To rename the table
DROP TABLE IF EXISTS orders;
RENAME TABLE orders3 TO orders;

-- To check if it worked
SELECT *
FROM orders;

-- To modify the column data type
ALTER TABLE orders
MODIFY COLUMN order_payment_id INT;

-- Creating fk constraint and specifing the action that should be taken
ALTER TABLE orders

/* When a customer record has been attempted to be removed from the customers table, 
the action is restricted and therefore the customer_id is not deleted from the orders table. 
Every order needs to have a customer who has made or who made the order.
On update of the customer's id in the customers table, the update should cascade or also take effect in the 
orders table
*/

ADD CONSTRAINT customer_id_fk FOREIGN KEY(customer_id) 
	REFERENCES customers(customer_id) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

/* Any attempt to delete the order_payment id from the order_payments table would be restricted. 
This is because every order made in olist stores should have an order_payment_id 
*/
ADD CONSTRAINT order_payment_id_fk FOREIGN KEY(order_payment_id)
	REFERENCES order_payments(order_payment_id)
    ON DELETE RESTRICT,

/* 
For this constraint I am bearing in mind the fact that some people who placed an order did not drop a review.
On deletion of the cust_review_tag from the order_reviews table, the orders table is set to null. 
This because a customer who places an order could decide not to leave a review
*/

ADD CONSTRAINT cust_review_tag_fk FOREIGN KEY(cust_review_tag) 
	REFERENCES order_reviews(cust_review_tag)
    ON DELETE SET NULL;

--------------------------------------------------------------------------------------------------------------------------------------------

-- ORDER_REVIEWS TABLE

DESCRIBE order_reviews;

ALTER TABLE order_reviews
-- Renames the column
CHANGE COLUMN review_id cust_review_tag VARCHAR(50);

-- To check if it worked
DESCRIBE order_reviews;

-- Now, I need to create a primary key to impose uniqueness for this table
ALTER TABLE order_reviews
ADD COLUMN review_id INT AUTO_INCREMENT PRIMARY KEY;

-- To check if it worked
SELECT * FROM order_reviews;

-- Next, we re-organize the order of the columns in the table
DROP TABLE IF EXISTS order_reviews2;

CREATE TABLE order_reviews2 (
	review_id INT PRIMARY KEY,
	cust_review_tag VARCHAR(50),
	order_id VARCHAR(50),
	review_score INT,
	review_comment_title VARCHAR(50),
	review_comment_message TEXT,
	review_creation_date DATETIME,
	review_answer_timestamp TIMESTAMP

);

INSERT INTO order_reviews2 (
	review_id,
	cust_review_tag,
	order_id,
	review_score,
	review_comment_title,
	review_comment_message,
	review_creation_date,
	review_answer_timestamp)

SELECT review_id,
	cust_review_tag,
	order_id,
	review_score,
	review_comment_title,
	review_comment_message,
	review_creation_date,
	review_answer_timestamp
FROM order_reviews;

-- To check if it worked
SELECT *
FROM order_reviews2;

-- To rename the new table properly
DROP TABLE IF EXISTS order_reviews;
RENAME TABLE order_reviews2 TO order_reviews;

-- To check if it worked
SELECT *
FROM order_reviews;

-- For the foreign key constraint to work I need to create a foreign key constraint
CREATE INDEX idx_cust_review_tag ON order_reviews(cust_review_tag);

--------------------------------------------------------------------------------------------------------------------------------------------

-- ORDER_PAYMENTS TABLE

-- order_payments constraints and normalization

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

DESCRIBE payment_kind;

-- To replace the values in the order_payments table

DROP TABLE IF EXISTS order2_payment2;

CREATE TABLE order2_payment2 AS
SELECT order_id,
		payment_sequential,
        CASE WHEN payment_type = 'credit_card' THEN 1
			 WHEN payment_type = 'boleto' THEN 2
             WHEN payment_type = 'voucher' THEN 3
             WHEN payment_type = 'debit_card' THEN 4
             WHEN payment_type = 'not_defined' THEN 5	END	 AS payment_type,			
        payment_installments,
        payment_value
FROM order_payments;

-- Rename table from order2_payment2 to order_payments
DROP TABLE IF EXISTS order_payments;
RENAME TABLE order2_payment2 TO order_payments;

-- To check for the characteristics of the columns in the table
DESCRIBE order_payments;

-- Working on the order_payments table and creating a primary key

ALTER TABLE order_payments
ADD COLUMN order_payment_id INT AUTO_INCREMENT PRIMARY KEY,
MODIFY COLUMN order_id VARCHAR(50) NOT NULL,
MODIFY payment_sequential INT NOT NULL,
MODIFY payment_type INT NOT NULL,
MODIFY payment_installments INT NOT NULL,
MODIFY payment_value DECIMAL(10,2) NOT NULL;


ALTER TABLE order_payments
-- Renames the column
CHANGE COLUMN payment_type payment_type_id INT NOT NULL;

-- To check if it worked
DESCRIBE order_payments;

-- Now, I need to create a primary key to impose uniqueness for this table
ALTER TABLE order_payments
ADD COLUMN order_payment_id INT AUTO_INCREMENT PRIMARY KEY;

-- To check if it worked
SELECT * FROM order_payments;

-- Next, we re-organize the order of the columns in the table
DROP TABLE IF EXISTS order_payments2;

CREATE TABLE order_payments2 (
	order_payment_id INT PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type_id INT NOT NULL,
    payment_installments INT NOT NULL,
    payment_value DECIMAL(10,2) NOT NULL
);

INSERT INTO order_payments2 (
	order_payment_id,
    order_id,
    payment_sequential,
    payment_type_id,
    payment_installments,
    payment_value
)
SELECT 
	order_payment_id,
    order_id,
    payment_sequential,
    payment_type_id,
    payment_installments,
    payment_value
FROM order_payments;

-- To check if it worked
SELECT *
FROM order_payments2;

-- To rename the new table properly
DROP TABLE IF EXISTS order_payments;
RENAME TABLE order_payments2 TO order_payments;

-- To check if it worked
SELECT *
FROM order_payments;

DESCRIBE order_payments;

-- For the foreign key constraint to work I need to create a foreign key constraint.
CREATE INDEX idx_order_id ON order_payments(order_id);

-- To impose foreign key constraints, I need to modify the column to allow null values
ALTER TABLE order_payments
MODIFY COLUMN payment_type_id INT NULL;


-- FK constraint
ALTER TABLE order_payments
ADD CONSTRAINT payment_type_id_fk FOREIGN KEY (payment_type_id) 
	REFERENCES payment_type (payment_type_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

/* This implies that upon deletion of a payment_id from the payments table, it sets the field value to null
to indicate that the payemnt format is not avaialble.
If however, the payment type id has been updated, it is also updated in the payments table
*/    

--------------------------------------------------------------------------------------------------------------------------------------------

-- PAYMENT_TYPE TABLE

-- Renames a column name and renames the table
RENAME TABLE payment_kind TO payment_type; 

-- To check if it worked
DESCRIBE payment_type;

ALTER TABLE payment_type
CHANGE COLUMN payment_kind_id payment_type_id INT NOT NULL;

-- To check if it worked
DESCRIBE payment_type;

SELECT *
FROM payment_type

--------------------------------------------------------------------------------------------------------------------------------------------

-- PRODUCTS TABLE

DESCRIBE products;

-- Updates the products table and replaces the blank('') cells with NULL
UPDATE products 
SET product_category_name = CASE WHEN product_category_name = '' THEN NULL ELSE product_category_name END,
	product_name_length = CASE WHEN product_name_length = '' THEN NULL ELSE product_name_length END,
    product_description_length = CASE WHEN product_description_length = '' THEN NULL ELSE product_description_length END,
    product_photos_qty = CASE WHEN product_photos_qty = '' THEN NULL ELSE product_photos_qty END,
	product_weight_g = CASE WHEN product_weight_g = '' THEN NULL ELSE product_weight_g END,
    product_length_cm = CASE WHEN product_length_cm = '' THEN NULL ELSE product_length_cm END,
    product_height_cm = CASE WHEN product_height_cm = '' THEN NULL ELSE product_height_cm END,
    product_width_cm = CASE WHEN product_width_cm = '' THEN NULL ELSE product_width_cm END;

-- To check if it worked
SELECT *
FROM products
WHERE product_category_name IS NULL;

-- Updates the products table
UPDATE products AS p
-- LEFT join is used to retain the null values present in the products table but not present in the other table
LEFT JOIN product_cat_name_translation AS pc
ON p.product_category_name = pc.product_category_name
-- Sets/replaces the category name with the category name translation id for every instance there is a match in the category names
SET p.product_category_name = pc.cat_name_trans_id;

-- To check if it worked
SELECT *
FROM products;

DESCRIBE products;

-- This changes the column name from product_category_name to cat_name_trans_id
ALTER TABLE products
CHANGE COLUMN product_category_name cat_name_trans_id INT;

-- To check if it worked
SELECT *
FROM products;

DESCRIBE products;

-- Modifying columns
ALTER TABLE products
MODIFY COLUMN product_name_length INT DEFAULT NULL,
MODIFY COLUMN product_description_length INT DEFAULT NULL,
MODIFY COLUMN product_photos_qty INT DEFAULT NULL,
MODIFY COLUMN product_weight_g INT DEFAULT NULL,
MODIFY COLUMN product_length_cm INT DEFAULT NULL,
MODIFY COLUMN product_height_cm INT DEFAULT NULL,
MODIFY COLUMN product_width_cm INT DEFAULT NULL;

-- Creates a FK constraint
ALTER TABLE products
ADD CONSTRAINT cat_name_trans_id_fk FOREIGN KEY(cat_name_trans_id)
	REFERENCES product_cat_name_translation(cat_name_trans_id)
	ON DELETE SET NULL
	ON UPDATE CASCADE;

/* In the constraint above, if the category transalation name id is ever updated, the update cascades to the products table. If however it becomes
unavailable because it was deleted, it sets that field value to NULL.
*/

--------------------------------------------------------------------------------------------------------------------------------------------

-- PRODUCT_CAT_NAME_TRANSLATION TABLE

DESCRIBE product_cat_name_translation;

-- This alters the table by replacing the primary key
ALTER TABLE product_cat_name_translation
DROP PRIMARY KEY,
ADD COLUMN cat_name_trans_id INT AUTO_INCREMENT PRIMARY KEY;

-- Next, we re-organize the order of the columns in the table
DROP TABLE IF EXISTS product_cat_name_translation2;
CREATE TABLE product_cat_name_translation2 (
	cat_name_trans_id INT PRIMARY KEY NOT NULL,
    product_category_name VARCHAR(100) NOT NULL,
	product_category_name_english VARCHAR(50) NOT NULL
);

INSERT INTO product_cat_name_translation2 (cat_name_trans_id, product_category_name, product_category_name_english)
SELECT cat_name_trans_id, 
		product_category_name, 
		product_category_name_english
FROM product_cat_name_translation;

-- To check if it worked
SELECT *
FROM product_cat_name_translation2;

DROP TABLE product_cat_name_translation;

-- Renames the table
RENAME TABLE product_cat_name_translation2 TO product_cat_name_translation;

-- To check if it worked
SELECT *
FROM product_cat_name_translation;


