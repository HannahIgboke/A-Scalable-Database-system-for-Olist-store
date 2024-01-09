/* This stored procedure would come in handy for Olist stores as they frequently would like to gain 
an idea into the order history of specific customers
*/

DROP PROCEDURE GetCustomerOrderHistory

DELIMITER //
CREATE PROCEDURE GetCustomerOrderHistory (IN cust_id VARCHAR(50)) -- where cust_id is the name of the parameter created
BEGIN
    SELECT o.order_id,
			oi.product_id,
            oi.order_item_id,
            o.order_purchase_timestamp,
            o.order_status,
            oi.price,
            oi.freight_value
     FROM order_items AS oi
     INNER JOIN orders AS o
     ON oi.order_id = o.order_id
     WHERE o.customer_id = cust_id;
END //
DELIMITER ;		


-- To confirm that it worked
CALL GetCustomerOrderHistory('8bb3bef4e75a95524235cdc11a7331af');
