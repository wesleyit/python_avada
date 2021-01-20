-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: localhost    Database: avada_db
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aulas`
--

DROP TABLE IF EXISTS `aulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aulas` (
  `imagem` varchar(12) DEFAULT NULL,
  `titulo` varchar(25) DEFAULT NULL,
  `descricao` varchar(85) DEFAULT NULL,
  `link` text,
  `id` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aulas`
--

LOCK TABLES `aulas` WRITE;
/*!40000 ALTER TABLE `aulas` DISABLE KEYS */;
INSERT INTO `aulas` VALUES ('img_0001.jpg','Telefone e Notebook','Fazer aplicativos móveis é importante, mas é ruim jogar CS no telefone.','https://reactnative.dev/',1),('img_0002.jpg','Pessoas e Alexa','As pessoas gostam de fazer perguntas engraçadas pra Alexa, aprenda a criar uma skill.','https://developer.amazon.com/en-US/alexa/alexa-skills-kit\r\nimg_0003.jpg; Satélites; Já pensou se cai na sua casa? Aprenda as leis da física e evite uma tragédia.; https://en.wikipedia.org/wiki/Satellite\r\nimg_0004.jpg; Carro Inteligente; Não preciso nem falar que esse carro é incrível, faz até café.; https://aws.amazon.com/solutions/implementations/aws-connected-vehicle-solution/',2),('img_0005.jpg','Cidade Inteligente','Nesse lugar as paredes tem olhos, cuidado ao digitar a senha.','https://aws.amazon.com/mp/gctc/',3),('img_0006.jpg','Se o Leonardo Da Vinci...','...estivesse vivo, adoraria a Internet.','https://www.louvre.fr/en',4),('img_0007.jpg','Achei!','Com uma lupa dessas fica fácil achar o Wally.','https://en.wikipedia.org/wiki/Where%27s_Wally%3F',5),('img_0008.jpg','Gráficos Importantes','Aprenda a fazer gráficos importantes (ou ao menos bonitos :).','https://aws.amazon.com/pt/quicksight/',6),('img_0003.jpg','Satélites','Já pensou se cai na sua casa? Aprenda as leis da física e evite uma tragédia.','https://en.wikipedia.org/wiki/Satellite',7),('img_0004.jpg','Carro Inteligente','Não preciso nem falar que esse carro é incrível, faz até café.','https://aws.amazon.com/solutions/implementations/aws-connected-vehicle-solution/',8);
/*!40000 ALTER TABLE `aulas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sqlite_sequence`
--

DROP TABLE IF EXISTS `sqlite_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sqlite_sequence` (
  `name` varchar(8) DEFAULT NULL,
  `seq` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sqlite_sequence`
--

LOCK TABLES `sqlite_sequence` WRITE;
/*!40000 ALTER TABLE `sqlite_sequence` DISABLE KEYS */;
INSERT INTO `sqlite_sequence` VALUES ('usuarios',3),('aulas',8);
/*!40000 ALTER TABLE `sqlite_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `login` varchar(6) DEFAULT NULL,
  `nome` varchar(6) DEFAULT NULL,
  `privilegio` varchar(7) DEFAULT NULL,
  `senha` varchar(8) DEFAULT NULL,
  `id` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES ('carlos','Carlos','aluno','ca123',1),('paulo','Paulo','suporte','admin123',2),('wesley','Wesley','aluno','123',3);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-13 19:28:13
