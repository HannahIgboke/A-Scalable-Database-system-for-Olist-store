-- Creating views

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

/* B. Product summary view

Olist strores would like to see how many products per category, the quantity of orders for each category and the total amount 
spent in each category
*/

CREATE VIEW product_summary AS
WITH cte AS (
SELECT product_id, 
		COUNT(order_item_id) AS count_of_orders_per_product,
        SUM(price + freight_value) AS total_amount
FROM order_items
GROUP BY product_id
)
SELECT 	p.cat_name_trans_id,
		pcnt.product_category_name_english,
		COUNT(p.product_id) AS count_of_products_in_cat,
        SUM(count_of_orders_per_product) AS quantity_ordered,
        ROUND(SUM(total_amount)) AS total_payment_value
FROM products AS p
LEFT JOIN product_cat_name_translation AS pcnt
	ON p.cat_name_trans_id = pcnt.cat_name_trans_id
INNER JOIN cte AS c
	ON p.product_id = c.product_id
GROUP BY p.cat_name_trans_id
ORDER BY cat_name_trans_id;

/* C. Yearly and monthly sales trend 

The sales team would like to easily view (and use the information from the view to create dashboards)
on the year by year and month by month sales trend for olist stores for all completed orders - that is, shipped and delivered order status.
*/
CREATE VIEW year_month_sales AS 
SELECT YEAR(order_delivered_customer_date) AS year,
		MONTHNAME(order_delivered_customer_date) AS month,
		ROUND(SUM(payment_value)) AS sales
FROM orders
INNER JOIN order_payments
USING(order_id)		
WHERE order_status IN ('delivered', 'shipped') AND order_delivered_customer_date IS NOT NULL       
GROUP BY YEAR(order_delivered_customer_date), MONTH(order_delivered_customer_date)
ORDER BY year;


