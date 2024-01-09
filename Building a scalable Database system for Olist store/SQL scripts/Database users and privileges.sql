-- Creating user roles and privileges

-- For admin
CREATE USER IF NOT EXISTS "olist_stores_admin"@localhost 
/* Creates the new named "olist_stores_admin" and specifies the host from which the user can connect which in this case, 
the user can connect only from "localhost"
*/
IDENTIFIED BY "OS_admin"; -- identified by the password
GRANT ALL PRIVILEGES ON olist_stores.* TO "olist_stores_admin"@localhost;

-- For sales manager
CREATE USER IF NOT EXISTS "sales_manager"@localhost
IDENTIFIED BY "OS_sales_manager";
GRANT SELECT, INSERT, UPDATE, DELETE ON olist_stores.* TO "sales_manager"@localhost;
GRANT EXECUTE ON PROCEDURE GetCustomerOrderHistory TO "sales_manager"@localhost;

-- For analytics team
CREATE USER IF NOT EXISTS "analytics_team"@localhost
IDENTIFIED BY "OS_analyst";
GRANT SELECT ON olist_stores.* TO "analytics_team"@localhost;

-- To be sure the privileges are accurately given
SHOW GRANTS FOR "olist_stores_admin"@localhost;
SHOW GRANTS FOR "sales_manager"@localhost;
SHOW GRANTS FOR "analytics_team"@localhost;
