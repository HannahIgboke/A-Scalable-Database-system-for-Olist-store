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






