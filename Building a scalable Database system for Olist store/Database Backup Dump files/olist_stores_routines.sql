CREATE DATABASE  IF NOT EXISTS `olist_stores` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `olist_stores`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: olist_stores
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `product_summary`
--

DROP TABLE IF EXISTS `product_summary`;
/*!50001 DROP VIEW IF EXISTS `product_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `product_summary` AS SELECT 
 1 AS `cat_name_trans_id`,
 1 AS `product_category_name_english`,
 1 AS `count_of_products_in_cat`,
 1 AS `quantity_ordered`,
 1 AS `total_payment_value`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `year_month_sales`
--

DROP TABLE IF EXISTS `year_month_sales`;
/*!50001 DROP VIEW IF EXISTS `year_month_sales`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `year_month_sales` AS SELECT 
 1 AS `year`,
 1 AS `month`,
 1 AS `sales`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `order_history`
--

DROP TABLE IF EXISTS `order_history`;
/*!50001 DROP VIEW IF EXISTS `order_history`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `order_history` AS SELECT 
 1 AS `customer_id`,
 1 AS `order_id`,
 1 AS `order_purchase_timestamp`,
 1 AS `order_status`,
 1 AS `order_quantity`,
 1 AS `total_amount`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `product_summary`
--

/*!50001 DROP VIEW IF EXISTS `product_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `product_summary` AS with `cte` as (select `order_items`.`product_id` AS `product_id`,count(`order_items`.`order_item_id`) AS `count_of_orders_per_product`,sum((`order_items`.`price` + `order_items`.`freight_value`)) AS `total_amount` from `order_items` group by `order_items`.`product_id`) select `p`.`cat_name_trans_id` AS `cat_name_trans_id`,`pcnt`.`product_category_name_english` AS `product_category_name_english`,count(`p`.`product_id`) AS `count_of_products_in_cat`,sum(`c`.`count_of_orders_per_product`) AS `quantity_ordered`,round(sum(`c`.`total_amount`),0) AS `total_payment_value` from ((`products` `p` left join `product_cat_name_translation` `pcnt` on((`p`.`cat_name_trans_id` = `pcnt`.`cat_name_trans_id`))) join `cte` `c` on((`p`.`product_id` = `c`.`product_id`))) group by `p`.`cat_name_trans_id` order by `p`.`cat_name_trans_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `year_month_sales`
--

/*!50001 DROP VIEW IF EXISTS `year_month_sales`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `year_month_sales` AS select year(`orders`.`order_delivered_customer_date`) AS `year`,monthname(`orders`.`order_delivered_customer_date`) AS `month`,round(sum(`order_payments`.`payment_value`),0) AS `sales` from (`orders` join `order_payments` on((`orders`.`order_id` = `order_payments`.`order_id`))) where ((`orders`.`order_status` in ('delivered','shipped')) and (`orders`.`order_delivered_customer_date` is not null)) group by year(`orders`.`order_delivered_customer_date`),month(`orders`.`order_delivered_customer_date`) order by `year` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `order_history`
--

/*!50001 DROP VIEW IF EXISTS `order_history`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `order_history` AS select `c`.`customer_id` AS `customer_id`,`o`.`order_id` AS `order_id`,`o`.`order_purchase_timestamp` AS `order_purchase_timestamp`,`o`.`order_status` AS `order_status`,count(`oi`.`order_item_id`) AS `order_quantity`,sum((`oi`.`price` + `oi`.`freight_value`)) AS `total_amount` from ((`orders` `o` left join `customers` `c` on((`o`.`customer_id` = `c`.`customer_id`))) left join `order_items` `oi` on((`o`.`order_id` = `oi`.`order_id`))) group by `o`.`order_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'olist_stores'
--

--
-- Dumping routines for database 'olist_stores'
--
/*!50003 DROP PROCEDURE IF EXISTS `GetCustomerOrderHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerOrderHistory`(IN cust_id VARCHAR(50))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-08 21:01:40
