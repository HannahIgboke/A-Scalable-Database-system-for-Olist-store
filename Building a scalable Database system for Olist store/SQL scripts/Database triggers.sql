/* TRIGGER 1: Logging and auditing triggers

I created a trigger to log changes made to the tables in the database to provide an audit trail.
This helps Olist store managers track when and what the changes as well as what users made the changes,
in order to ensure security and compliance.
*/

-- First, I created an audit_log table to keep tabs on all that goes on in the database tables

CREATE TABLE audit_log (
	log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(255), -- stores the name of the table on which the operation was performed
    action VARCHAR(10), -- Represents the kind of action done on the table - INSERT, UPDATE or DELETE
    affected_row_id INT,-- stores the ID of the affected row
    user VARCHAR(70), -- stores the user who made the change
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- records the timestamp of when the operation occurred
 );   

-- For the ORDERS TABLE

-- Audit trigger for insert
DELIMITER //
CREATE TRIGGER after_orders_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('orders', 'INSERT', NEW.order_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for update
DELIMITER //
CREATE TRIGGER after_orders_update
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('orders', 'UPDATE', NEW.order_id, USER(), NOW());
END //
DELIMITER ;


-- Audit trigger for delete
DELIMITER //
CREATE TRIGGER after_orders_delete
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('orders', 'DELETE', OLD.order_id, USER(), NOW());
END //
DELIMITER ;

-- For the ORDER_REVIEWS TABLE

-- Audit trigger for insert
DELIMITER //
CREATE TRIGGER after_order_reviews_insert
AFTER INSERT ON order_reviews
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('order_reviews', 'INSERT', NEW.review_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for update	
DELIMITER //
CREATE TRIGGER after_order_reviews_update
AFTER UPDATE ON order_reviews
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('order_reviews', 'UPDATE', NEW.review_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for delete
DELIMITER //
CREATE TRIGGER after_order_reviews_delete
AFTER DELETE ON order_reviews
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('order_reviews', 'DELETE', OLD.review_id, USER(), NOW());
END //
DELIMITER ;
    
-- For the ORDER_PAYMENTS

-- Audit trigger for insert
DELIMITER //
CREATE TRIGGER after_order_payments_insert
AFTER INSERT ON order_payments
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('order_payments', 'INSERT', NEW.order_payment_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for update
DELIMITER //
CREATE TRIGGER after_order_payments_update
AFTER UPDATE ON order_payments
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('order_payments', 'UPDATE', NEW.order_payment_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for delete
DELIMITER //
CREATE TRIGGER after_order_payments_delete
AFTER DELETE ON order_payments
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('order_payments', 'DELETE', OLD.order_payment_id, USER(), NOW());
END //
DELIMITER ;

-- For the PRODUCTS table

-- Audit trigger for insert
DELIMITER //
CREATE TRIGGER after_products_insert
AFTER INSERT ON products
FOR EACH ROW
BEGIN 
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('products', 'INSERT', NEW.product_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for update
DELIMITER //
CREATE TRIGGER after_products_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('products', 'UPDATE', NEW.product_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for delete
DELIMITER //
CREATE TRIGGER after_products_delete
AFTER DELETE ON products
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('products', 'DELETE', OLD.product_id, USER(), NOW());
END //
DELIMITER ;

-- For product_cat_name_translation table

-- Audit trigger for insert
DELIMITER //
CREATE TRIGGER after_product_cat_name_translation_insert
AFTER INSERT ON product_cat_name_translation
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('product_cat_name_translation', 'INSERT', NEW.cat_name_trans_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for update
DELIMITER //
CREATE TRIGGER after_product_cat_name_translation_update
AFTER UPDATE ON product_cat_name_translation
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('product_cat_name_translation', 'UPDATE', NEW.cat_name_trans_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for delete
DELIMITER //
CREATE TRIGGER after_product_cat_name_translation_delete
AFTER DELETE ON product_cat_name_translation
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('product_cat_name_translation', 'DELETE', OLD.cat_name_trans_id, USER(), NOW());
END //
DELIMITER ;

-- For the PAYMENT_TYPE table

-- Audit trigger for insert
DELIMITER //
CREATE TRIGGER after_payment_type_insert
AFTER INSERT ON payment_type
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES ('payment_type', 'INSERT', NEW.payment_type_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for update
DELIMITER //
CREATE TRIGGER after_payment_type_update
AFTER UPDATE ON payment_type
FOR EACH ROW
BEGIN 
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES ('payment_type', 'UPDATE', NEW.payment_type_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for delete
DELIMITER //
CREATE TRIGGER after_payment_type_delete
AFTER DELETE ON payment_type
FOR EACH ROW
BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES ('payment_type', 'DELETE', OLD.payment_type_id, USER(), NOW());
END //
DELIMITER ;

-- For the CUSTOMERS table

-- Audit trigger for insert
DELIMITER //
CREATE TRIGGER after_customers_insert
AFTER INSERT ON customers
FOR EACH ROW
BEGIN
	INSERT INTO audit_log(table_name, action, affected_row_id, user, timestamp)
    VALUES('customers', 'INSERT', NEW.customer_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for update
DELIMITER //
CREATE TRIGGER after_customers_update
AFTER UPDATE ON customers
FOR EACH ROW
BEGIN
	INSERT INTO audit_log(table_name, action, affected_row_id, user, timestamp)
    VALUES('customers', 'UPDATE', NEW.customer_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger on delete
DELIMITER //
CREATE TRIGGER after_customers_delete
AFTER DELETE ON customers
FOR EACH ROW
BEGIN
	INSERT INTO audit_log(table_name, action, affected_row_id, user, timestamp)
    VALUES('customers', 'DELETE', OLD.customer_id, USER(), NOW());
END //
DELIMITER ;

-- For the SELLERS table

-- Audit trigger for insert
DELIMITER //
CREATE TRIGGER after_sellers_insert
AFTER INSERT ON sellers
FOR EACH ROW
BEGIN
	INSERT INTO audit_log(table_name, action, affected_row_id, user, timestamp)
    VALUES('sellers', 'INSERT', NEW.seller_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for update
DELIMITER //
CREATE TRIGGER after_sellers_update
AFTER UPDATE ON sellers
FOR EACH ROW 
BEGIN
	INSERT INTO audit_log(table_name, action, affected_row_id, user, timestamp)
    VALUES('sellers', 'UPDATE', NEW.seller_id, USER(), NOW());
END //
DELIMITER ;

-- Audit trigger for delete
DELIMITER //
CREATE TRIGGER after_sellers_delete
AFTER DELETE ON sellers
FOR EACH ROW
BEGIN
	INSERT INTO audit_log(table_name, action, affected_row_id, user, timestamp)
    VALUES('sellers', 'DELETE', OLD.seller_id, USER(), NOW());
END //
DELIMITER ;


-- To test if the triggers worked
INSERT INTO payment_type (payment_type_id, types)
VALUES(6, 'cash');
-- It worked

UPDATE payment_type
SET payment_type_id = 7, 
	types = 'transfer'
WHERE payment_type_id = 6 AND types = 'cash';
-- It worked

DELETE FROM payment_type
WHERE payment_type_id = 7;


-----------------------------------------------------------------------------------------------------------------------------------------
/* TRIGGER TWO: new customer notification trigger

Olist stores would like to be notified when they gain a new customer - i.e someone who has never shopped
at the store before*/

-- Creating the notifications table

CREATE TABLE notifications (
	notification_id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- creating the trigger on the customers table

DELIMITER //
CREATE TRIGGER notify_new_customer
AFTER INSERT ON customers
FOR EACH ROW
BEGIN
	DECLARE message VARCHAR(255); -- This declares a variable named message to store the notification message
    SET message = CONCAT('New customer: ', NEW.customer_id, ' !');
    INSERT INTO notifications(message)
    VALUES (message);
END //
DELIMITER ;

-- To check if the trigger was created
SHOW TRIGGERS;

-- To test the trigger
INSERT INTO customers (customer_id, customer_unique_id, customer_zip_code_prefix)
VALUES ('4aw2a9397am4bc099783511faa1p6830', '090f6d7f674977d08a9b445l5117cqd8', 2394);
-- It worked!
