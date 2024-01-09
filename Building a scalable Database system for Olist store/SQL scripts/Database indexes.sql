/* Query optimization

Indexes are used to optimize the query of the olist_stores database.
The indexes created are as a result of an understanding of the database structure of the olist stores,
that is, the indexes are created on columns of tables in a DB that are commonly used to perform JOIN and WHERE operations
The choice of columns to index is flexible and can evolve over time based on the usage patterns of the database with time.

Naturally indexes are created on columns when you define primary and secondary keys.
*/

-- To view all the present indexes in the database
SELECT DISTINCT TABLE_NAME,
 INDEX_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'olist_stores';

-- Other indexes created include
CREATE INDEX review_score_idx ON order_reviews(review_score);
CREATE INDEX order_status_idx ON orders (order_status);
CREATE INDEX order_purchase_timestamp_idk ON orders(order_purchase_timestamp);

-- To confirm if it worked
SELECT DISTINCT TABLE_NAME,
 INDEX_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'olist_stores';

