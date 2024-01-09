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
-- Table structure for table `product_cat_name_translation`
--

DROP TABLE IF EXISTS `product_cat_name_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_cat_name_translation` (
  `cat_name_trans_id` int NOT NULL,
  `product_category_name` varchar(100) NOT NULL,
  `product_category_name_english` varchar(50) NOT NULL,
  PRIMARY KEY (`cat_name_trans_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_cat_name_translation`
--

LOCK TABLES `product_cat_name_translation` WRITE;
/*!40000 ALTER TABLE `product_cat_name_translation` DISABLE KEYS */;
INSERT INTO `product_cat_name_translation` VALUES (1,'agro_industria_e_comercio','agro_industry_and_commerce\r'),(2,'alimentos','food\r'),(3,'alimentos_bebidas','food_drink\r'),(4,'artes','art\r'),(5,'artes_e_artesanato','arts_and_craftmanship\r'),(6,'artigos_de_festas','party_supplies\r'),(7,'artigos_de_natal','christmas_supplies\r'),(8,'audio','audio\r'),(9,'automotivo','auto\r'),(10,'bebes','baby\r'),(11,'bebidas','drinks\r'),(12,'beleza_saude','health_beauty\r'),(13,'brinquedos','toys\r'),(14,'cama_mesa_banho','bed_bath_table\r'),(15,'casa_conforto','home_confort\r'),(16,'casa_conforto_2','home_comfort_2\r'),(17,'casa_construcao','home_construction\r'),(18,'cds_dvds_musicais','cds_dvds_musicals\r'),(19,'cine_foto','cine_photo\r'),(20,'climatizacao','air_conditioning\r'),(21,'consoles_games','consoles_games\r'),(22,'construcao_ferramentas_construcao','construction_tools_construction\r'),(23,'construcao_ferramentas_ferramentas','costruction_tools_tools\r'),(24,'construcao_ferramentas_iluminacao','construction_tools_lights\r'),(25,'construcao_ferramentas_jardim','costruction_tools_garden\r'),(26,'construcao_ferramentas_seguranca','construction_tools_safety\r'),(27,'cool_stuff','cool_stuff\r'),(28,'dvds_blu_ray','dvds_blu_ray\r'),(29,'eletrodomesticos','home_appliances\r'),(30,'eletrodomesticos_2','home_appliances_2\r'),(31,'eletronicos','electronics\r'),(32,'eletroportateis','small_appliances\r'),(33,'esporte_lazer','sports_leisure\r'),(34,'fashion_bolsas_e_acessorios','fashion_bags_accessories\r'),(35,'fashion_calcados','fashion_shoes\r'),(36,'fashion_esporte','fashion_sport\r'),(37,'fashion_roupa_feminina','fashio_female_clothing\r'),(38,'fashion_roupa_infanto_juvenil','fashion_childrens_clothes\r'),(39,'fashion_roupa_masculina','fashion_male_clothing\r'),(40,'fashion_underwear_e_moda_praia','fashion_underwear_beach\r'),(41,'ferramentas_jardim','garden_tools\r'),(42,'flores','flowers\r'),(43,'fraldas_higiene','diapers_and_hygiene\r'),(44,'industria_comercio_e_negocios','industry_commerce_and_business\r'),(45,'informatica_acessorios','computers_accessories\r'),(46,'instrumentos_musicais','musical_instruments\r'),(47,'la_cuisine','la_cuisine\r'),(48,'livros_importados','books_imported\r'),(49,'livros_interesse_geral','books_general_interest\r'),(50,'livros_tecnicos','books_technical\r'),(51,'malas_acessorios','luggage_accessories\r'),(52,'market_place','market_place\r'),(53,'moveis_colchao_e_estofado','furniture_mattress_and_upholstery\r'),(54,'moveis_cozinha_area_de_servico_jantar_e_jardim','kitchen_dining_laundry_garden_furniture\r'),(55,'moveis_decoracao','furniture_decor\r'),(56,'moveis_escritorio','office_furniture\r'),(57,'moveis_quarto','furniture_bedroom\r'),(58,'moveis_sala','furniture_living_room\r'),(59,'musica','music\r'),(60,'papelaria','stationery\r'),(61,'pcs','computers\r'),(62,'perfumaria','perfumery\r'),(63,'pet_shop','pet_shop\r'),(64,'portateis_casa_forno_e_cafe','small_appliances_home_oven_and_coffee\r'),(65,'relogios_presentes','watches_gifts\r'),(66,'seguros_e_servicos','security_and_services'),(67,'sinalizacao_e_seguranca','signaling_and_security\r'),(68,'tablets_impressao_imagem','tablets_printing_image\r'),(69,'telefonia','telephony\r'),(70,'telefonia_fixa','fixed_telephony\r'),(71,'utilidades_domesticas','housewares\r');
/*!40000 ALTER TABLE `product_cat_name_translation` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_product_cat_name_translation_insert` AFTER INSERT ON `product_cat_name_translation` FOR EACH ROW BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('product_cat_name_translation', 'INSERT', NEW.cat_name_trans_id, USER(), NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_product_cat_name_translation_update` AFTER UPDATE ON `product_cat_name_translation` FOR EACH ROW BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('product_cat_name_translation', 'UPDATE', NEW.cat_name_trans_id, USER(), NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_product_cat_name_translation_delete` AFTER DELETE ON `product_cat_name_translation` FOR EACH ROW BEGIN
	INSERT INTO audit_log (table_name, action, affected_row_id, user, timestamp)
    VALUES('product_cat_name_translation', 'DELETE', OLD.cat_name_trans_id, USER(), NOW());
END */;;
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

-- Dump completed on 2024-01-08 21:01:32
