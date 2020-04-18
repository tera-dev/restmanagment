-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.6.38 - MySQL Community Server (GPL)
-- Операционная система:         Win32
-- HeidiSQL Версия:              9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных restaurant
CREATE DATABASE IF NOT EXISTS `restaurant` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `restaurant`;

-- Дамп структуры для таблица restaurant.departments
CREATE TABLE IF NOT EXISTS `departments` (
  `departmentID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`departmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.departments: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` (`departmentID`, `name`) VALUES
	(1, 'Зал'),
	(2, 'Кухня');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.employees
CREATE TABLE IF NOT EXISTS `employees` (
  `employeeID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `middle_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `emplmt_date` date DEFAULT NULL,
  PRIMARY KEY (`employeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.employees: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` (`employeeID`, `name`, `middle_name`, `last_name`, `emplmt_date`) VALUES
	(1, 'Иван', 'Иванович', 'Иванов', NULL),
	(2, 'Петр', 'Иванович', 'Сидоров', NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.flow_charts
CREATE TABLE IF NOT EXISTS `flow_charts` (
  `flow_chartID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `price` int(10) unsigned NOT NULL,
  `categoryID` int(10) unsigned NOT NULL,
  `is_good` tinyint(1) NOT NULL,
  PRIMARY KEY (`flow_chartID`),
  KEY `FK1_category_flow` (`categoryID`),
  CONSTRAINT `FK1_category_flow` FOREIGN KEY (`categoryID`) REFERENCES `flow_chart_categories` (`flow_chart_categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.flow_charts: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `flow_charts` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_charts` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.flow_chart_categories
CREATE TABLE IF NOT EXISTS `flow_chart_categories` (
  `flow_chart_categoryID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `parentID` int(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`flow_chart_categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.flow_chart_categories: ~9 rows (приблизительно)
/*!40000 ALTER TABLE `flow_chart_categories` DISABLE KEYS */;
INSERT INTO `flow_chart_categories` (`flow_chart_categoryID`, `name`, `parentID`) VALUES
	(5, 'Выпечка', 0),
	(6, 'тесто', 0),
	(7, 'тесто2', 5),
	(8, 'лбло', 0),
	(9, 'круаан', 5),
	(10, 'круаан', 7),
	(11, '51541', 5),
	(12, 'лбло', 5),
	(13, 'dd', 0),
	(14, 'яяшш', 0);
/*!40000 ALTER TABLE `flow_chart_categories` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.flow_chart_modifiers
CREATE TABLE IF NOT EXISTS `flow_chart_modifiers` (
  `flow_chart_modifierID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `flow_chartID` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`flow_chart_modifierID`),
  KEY `FK_flow_chart_modifiers_flow_charts` (`flow_chartID`),
  CONSTRAINT `FK_flow_chart_modifiers_flow_charts` FOREIGN KEY (`flow_chartID`) REFERENCES `flow_charts` (`flow_chartID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.flow_chart_modifiers: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `flow_chart_modifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_chart_modifiers` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.flow_chart_recipes
CREATE TABLE IF NOT EXISTS `flow_chart_recipes` (
  `flow_chartID` int(10) unsigned NOT NULL,
  `ingridID` int(10) unsigned NOT NULL,
  `amount` int(10) unsigned NOT NULL,
  KEY `dishID` (`flow_chartID`),
  KEY `ingridID` (`ingridID`),
  CONSTRAINT `flow_chart_recipes_ibfk_1` FOREIGN KEY (`flow_chartID`) REFERENCES `flow_charts` (`flow_chartID`),
  CONSTRAINT `flow_chart_recipes_ibfk_2` FOREIGN KEY (`ingridID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.flow_chart_recipes: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `flow_chart_recipes` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_chart_recipes` ENABLE KEYS */;

-- Дамп структуры для процедура restaurant.getInvoiceDetail
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `getInvoiceDetail`(
	IN `invoiceID` INT
)
BEGIN
select products.name as `product`, products_in_invoices.amount,
products_in_invoices.manufctr_date,units.name as `unit`
from products_in_invoices left join products
on products_in_invoices.productID = products.productID
left join units
on units.unitID = products.unitID
where products_in_invoices.invoiceID = invoiceID;
END//
DELIMITER ;

-- Дамп структуры для процедура restaurant.getLastInvoice
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `getLastInvoice`()
BEGIN
select invoices.invoiceID from invoices order by invoices.invoiceID desc limit 1;
END//
DELIMITER ;

-- Дамп структуры для функция restaurant.GetLastInvoiceID
DELIMITER //
CREATE DEFINER=`root`@`%` FUNCTION `GetLastInvoiceID`() RETURNS int(10)
BEGIN
	declare id int;
  select invoices.invoiceID into id from invoices order by invoices.invoiceID desc limit 1;
  return (id);
END//
DELIMITER ;

-- Дамп структуры для таблица restaurant.goods
CREATE TABLE IF NOT EXISTS `goods` (
  `goodID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `price` int(10) unsigned NOT NULL,
  `categoryID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`goodID`),
  KEY `categoryID` (`categoryID`),
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`categoryID`) REFERENCES `flow_chart_categories` (`flow_chart_categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.goods: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.good_storage
CREATE TABLE IF NOT EXISTS `good_storage` (
  `goodID` int(10) unsigned NOT NULL,
  `in_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `amount` int(10) unsigned NOT NULL,
  KEY `goodID` (`goodID`),
  CONSTRAINT `good_storage_ibfk_1` FOREIGN KEY (`goodID`) REFERENCES `goods` (`goodID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.good_storage: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `good_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `good_storage` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.half_stuff_orders
CREATE TABLE IF NOT EXISTS `half_stuff_orders` (
  `hs_orderID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`hs_orderID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.half_stuff_orders: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `half_stuff_orders` DISABLE KEYS */;
INSERT INTO `half_stuff_orders` (`hs_orderID`, `start_time`, `end_time`, `date`, `status`) VALUES
	(1, '11:54:57', '15:55:58', '2018-12-10', NULL);
/*!40000 ALTER TABLE `half_stuff_orders` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.half_stuff_order_details
CREATE TABLE IF NOT EXISTS `half_stuff_order_details` (
  `hs_orderID` int(10) unsigned NOT NULL,
  `half_stuffID` int(10) unsigned NOT NULL,
  `amount` int(10) unsigned DEFAULT NULL,
  KEY `FK_half_stuff_order_details_half_stuff_orders` (`hs_orderID`),
  KEY `FK_half_stuff_order_details_half_stuffes` (`half_stuffID`),
  CONSTRAINT `FK_half_stuff_order_details_half_stuff_orders` FOREIGN KEY (`hs_orderID`) REFERENCES `half_stuff_orders` (`hs_orderID`),
  CONSTRAINT `FK_half_stuff_order_details_half_stuffes` FOREIGN KEY (`half_stuffID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.half_stuff_order_details: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `half_stuff_order_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `half_stuff_order_details` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.half_stuff_recipes
CREATE TABLE IF NOT EXISTS `half_stuff_recipes` (
  `half_stuffID` int(10) unsigned NOT NULL,
  `productID` int(10) unsigned NOT NULL,
  `amount` int(10) unsigned NOT NULL,
  KEY `FK_half_stuffes_recipes_products` (`productID`),
  KEY `FK_half_stuffes_recipes_half_stuffes` (`half_stuffID`),
  CONSTRAINT `FK_half_stuffes_recipes_half_stuffes` FOREIGN KEY (`half_stuffID`) REFERENCES `products` (`productID`),
  CONSTRAINT `FK_half_stuffes_recipes_products` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.half_stuff_recipes: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `half_stuff_recipes` DISABLE KEYS */;
INSERT INTO `half_stuff_recipes` (`half_stuffID`, `productID`, `amount`) VALUES
	(18, 15, 1000),
	(18, 20, 500),
	(18, 16, 50);
/*!40000 ALTER TABLE `half_stuff_recipes` ENABLE KEYS */;

-- Дамп структуры для процедура restaurant.ins
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `ins`(
	IN `kolich` INT

)
BEGIN

END//
DELIMITER ;

-- Дамп структуры для процедура restaurant.insrt
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `insrt`(
	IN `kolich` int 




)
BEGIN
 DECLARE done INT;
 set done = 0;
 WHILE done < kolich DO
 insert INTO suppliers(suppliers.name,suppliers.telephone) 
 values ('Джек','ааа');
 set done = done + 1;
 END WHILE;
 
 
END//
DELIMITER ;

-- Дамп структуры для таблица restaurant.invoices
CREATE TABLE IF NOT EXISTS `invoices` (
  `invoiceID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `in_date` date NOT NULL,
  `supplierID` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`invoiceID`),
  KEY `FK_invoices_suppliers` (`supplierID`),
  CONSTRAINT `FK_invoices_suppliers` FOREIGN KEY (`supplierID`) REFERENCES `suppliers` (`supplierID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.invoices: ~6 rows (приблизительно)
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` (`invoiceID`, `in_date`, `supplierID`) VALUES
	(1, '2018-12-07', 1),
	(2, '2018-12-07', 1),
	(3, '2018-12-07', 1),
	(4, '2018-12-08', 1),
	(5, '2018-12-05', 5),
	(6, '2018-12-05', 3);
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `orderID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `waiterID` int(10) unsigned NOT NULL,
  `start_time` datetime NOT NULL,
  `payment_time` datetime DEFAULT NULL,
  `tableID` tinyint(3) unsigned NOT NULL,
  `sum_to_pay` int(10) unsigned DEFAULT NULL,
  `status` int(10) unsigned NOT NULL,
  PRIMARY KEY (`orderID`),
  KEY `tableID` (`tableID`),
  KEY `waiterID` (`waiterID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`tableID`) REFERENCES `tables` (`tableID`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`waiterID`) REFERENCES `employees` (`employeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.orders: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`orderID`, `waiterID`, `start_time`, `payment_time`, `tableID`, `sum_to_pay`, `status`) VALUES
	(2, 1, '2018-12-10 06:15:56', '2018-12-10 13:45:15', 1, NULL, 0),
	(7, 1, '2018-12-10 13:39:42', '2018-12-10 13:40:03', 4, NULL, 0);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.order_details
CREATE TABLE IF NOT EXISTS `order_details` (
  `orderID` int(10) unsigned NOT NULL,
  `flow_chartID` int(10) unsigned NOT NULL,
  `cookID` int(10) unsigned NOT NULL,
  `portions_amount` tinyint(3) unsigned NOT NULL,
  `price` int(10) unsigned DEFAULT NULL,
  KEY `orderID` (`orderID`),
  KEY `dishID` (`flow_chartID`),
  KEY `cookID` (`cookID`),
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`),
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`flow_chartID`) REFERENCES `flow_charts` (`flow_chartID`),
  CONSTRAINT `order_details_ibfk_3` FOREIGN KEY (`cookID`) REFERENCES `employees` (`employeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.order_details: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.order_statuses
CREATE TABLE IF NOT EXISTS `order_statuses` (
  `statusID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`statusID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.order_statuses: ~4 rows (приблизительно)
/*!40000 ALTER TABLE `order_statuses` DISABLE KEYS */;
INSERT INTO `order_statuses` (`statusID`, `name`) VALUES
	(1, 'Принят'),
	(2, 'Готовится'),
	(3, 'Подан'),
	(4, 'Оплачен');
/*!40000 ALTER TABLE `order_statuses` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.positions
CREATE TABLE IF NOT EXISTS `positions` (
  `positionID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `salary` int(10) unsigned DEFAULT NULL,
  `departmentID` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`positionID`),
  KEY `departmentID` (`departmentID`),
  CONSTRAINT `positions_ibfk_1` FOREIGN KEY (`departmentID`) REFERENCES `departments` (`departmentID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.positions: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` (`positionID`, `name`, `salary`, `departmentID`) VALUES
	(1, 'Официант', 5000, 1),
	(2, 'Повар', 7000, 1);
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.positions_of_employees
CREATE TABLE IF NOT EXISTS `positions_of_employees` (
  `employeeID` int(10) unsigned NOT NULL,
  `positionID` int(10) unsigned NOT NULL,
  KEY `employeeID` (`employeeID`),
  KEY `positionID` (`positionID`),
  CONSTRAINT `positions_of_employees_ibfk_1` FOREIGN KEY (`employeeID`) REFERENCES `employees` (`employeeID`),
  CONSTRAINT `positions_of_employees_ibfk_2` FOREIGN KEY (`positionID`) REFERENCES `positions` (`positionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.positions_of_employees: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `positions_of_employees` DISABLE KEYS */;
INSERT INTO `positions_of_employees` (`employeeID`, `positionID`) VALUES
	(1, 1),
	(2, 2);
/*!40000 ALTER TABLE `positions_of_employees` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.products
CREATE TABLE IF NOT EXISTS `products` (
  `productID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `unitID` int(10) unsigned NOT NULL,
  `expiry_count` smallint(5) unsigned NOT NULL,
  `product_typeID` tinyint(1) unsigned NOT NULL,
  `categoryID` int(10) unsigned DEFAULT NULL,
  `half_stuff_recipe` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`productID`),
  KEY `FK_products_units` (`unitID`),
  KEY `FK2_products_product_categories` (`categoryID`),
  CONSTRAINT `FK2_products_product_categories` FOREIGN KEY (`categoryID`) REFERENCES `product_categories` (`product_categoryID`),
  CONSTRAINT `FK_products_units` FOREIGN KEY (`unitID`) REFERENCES `units` (`unitID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.products: ~13 rows (приблизительно)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`productID`, `name`, `unitID`, `expiry_count`, `product_typeID`, `categoryID`, `half_stuff_recipe`) VALUES
	(3, 'Jack Daniels', 3, 0, 1, 3, NULL),
	(4, 'Blue Label', 3, 0, 1, NULL, NULL),
	(5, 'Свинной балык', 2, 0, 1, 1, NULL),
	(7, 'Дорадо', 2, 0, 1, NULL, NULL),
	(10, 'Куриная грудка', 2, 0, 1, NULL, NULL),
	(13, 'Помидор-черри', 2, 0, 1, NULL, NULL),
	(15, 'Мука пшеничная', 2, 0, 1, NULL, NULL),
	(16, 'Дрожжи', 2, 0, 1, NULL, NULL),
	(18, 'Тесто', 2, 0, 0, NULL, NULL),
	(20, 'Вода', 3, 0, 1, NULL, NULL),
	(21, 'Помидор', 1, 1, 1, 1, NULL),
	(22, 'Помидор', 2, 5, 0, 4, '[{"id":"5","weight":"55"},{"id":"4","weight":"520"}]'),
	(24, 'Помидор', 1, 1, 0, 2, '[{"id":"5","weight":"2"}]'),
	(25, 'Помидор', 1, 1, 0, 1, '[{"id":"7","weight":"22"}]'),
	(26, 'Помидор', 2, 444, 1, 2, '');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.products_in_invoices
CREATE TABLE IF NOT EXISTS `products_in_invoices` (
  `invoiceID` int(10) unsigned NOT NULL,
  `productID` int(10) unsigned NOT NULL,
  `amount` int(10) unsigned NOT NULL,
  `price` int(10) unsigned DEFAULT NULL,
  `manufctr_date` date NOT NULL,
  KEY `FK_products_in_invoices_invoices` (`invoiceID`),
  KEY `FK_products_in_invoices_products` (`productID`),
  CONSTRAINT `FK_products_in_invoices_invoices` FOREIGN KEY (`invoiceID`) REFERENCES `invoices` (`invoiceID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_products_in_invoices_products` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.products_in_invoices: ~16 rows (приблизительно)
/*!40000 ALTER TABLE `products_in_invoices` DISABLE KEYS */;
INSERT INTO `products_in_invoices` (`invoiceID`, `productID`, `amount`, `price`, `manufctr_date`) VALUES
	(1, 4, 1111, 111, '2018-12-07'),
	(1, 4, 2222, 222, '2018-12-08'),
	(2, 3, 1111, 111, '2018-12-07'),
	(2, 4, 2222, 222, '2018-12-08'),
	(3, 5, 4324, 123, '2018-12-07'),
	(3, 7, 567, 32423, '2018-12-08'),
	(3, 3, 654, 3423, '2018-12-08'),
	(3, 4, 54645, 213, '2018-12-07'),
	(4, 5, 21312, 34, '2018-12-08'),
	(4, 3, 123213, 324325, '2018-11-29'),
	(1, 5, 10, 150, '2018-12-10'),
	(1, 5, 10, 200, '2018-12-09'),
	(1, 5, 10, 200, '2018-12-09'),
	(5, 5, 12321, 3214, '2018-12-10'),
	(6, 5, 222, 12321, '2018-12-10'),
	(6, 3, 55, 32432, '2018-11-27');
/*!40000 ALTER TABLE `products_in_invoices` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.product_categories
CREATE TABLE IF NOT EXISTS `product_categories` (
  `product_categoryID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`product_categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.product_categories: ~9 rows (приблизительно)
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` (`product_categoryID`, `name`) VALUES
	(1, 'Мясоjjj'),
	(2, 'Рыба'),
	(3, 'Алкоголь'),
	(4, 'Овощи'),
	(5, 'Макароные изделия'),
	(6, 'Мучное'),
	(7, 'Напитки'),
	(8, 'молочка'),
	(9, 'молочкаввв');
/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.product_storage
CREATE TABLE IF NOT EXISTS `product_storage` (
  `productID` int(10) unsigned NOT NULL,
  `in_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `amount` int(10) unsigned NOT NULL,
  KEY `product_storage_ibfk_2` (`productID`),
  CONSTRAINT `product_storage_ibfk_1` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.product_storage: ~8 rows (приблизительно)
/*!40000 ALTER TABLE `product_storage` DISABLE KEYS */;
INSERT INTO `product_storage` (`productID`, `in_date`, `expiry_date`, `amount`) VALUES
	(5, '2018-12-10', '2018-12-10', 39543),
	(5, '2018-12-09', '2018-12-09', 31943),
	(10, '2018-12-10', NULL, 39200),
	(13, '2018-12-10', NULL, 49900),
	(7, '2018-12-10', NULL, 48500),
	(3, '2018-12-10', NULL, 19800),
	(20, '2018-12-10', NULL, 10000),
	(16, '2018-12-10', NULL, 1000),
	(15, '2018-12-10', NULL, 10000),
	(3, '2018-11-27', NULL, 55);
/*!40000 ALTER TABLE `product_storage` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.suppliers
CREATE TABLE IF NOT EXISTS `suppliers` (
  `supplierID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `telephone` varchar(100) NOT NULL,
  PRIMARY KEY (`supplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.suppliers: ~6 rows (приблизительно)
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` (`supplierID`, `name`, `telephone`) VALUES
	(1, 'ООО "Салтовский мясокомбинат"', '55-63-96'),
	(2, 'ООО "Глонбиский мясокомбинат"', '44-88-77'),
	(3, 'ООО "Глобинский молокозавод"', '12-36-45'),
	(4, 'ООО "Харьковский молокозавод"', '17-36-45'),
	(5, 'ЧОП "Август"', '45-63-89'),
	(6, 'ЧОП "Август"', '45-63-89'),
	(7, 'ЧОП "Американо"', '78-52-96');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.tables
CREATE TABLE IF NOT EXISTS `tables` (
  `tableID` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `free` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`tableID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.tables: ~5 rows (приблизительно)
/*!40000 ALTER TABLE `tables` DISABLE KEYS */;
INSERT INTO `tables` (`tableID`, `free`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1);
/*!40000 ALTER TABLE `tables` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.test
CREATE TABLE IF NOT EXISTS `test` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `type` enum('var1','var2','var3','varrrr4') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.test: ~3 rows (приблизительно)
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` (`id`, `name`, `type`) VALUES
	(1, '2018-12-07', NULL),
	(2, '2019-12-07', NULL),
	(3, '2020-12-07', NULL);
/*!40000 ALTER TABLE `test` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.test2
CREATE TABLE IF NOT EXISTS `test2` (
  `intID` int(10) unsigned NOT NULL,
  KEY `FK_test2_test` (`intID`),
  CONSTRAINT `FK_test2_test` FOREIGN KEY (`intID`) REFERENCES `test` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.test2: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `test2` DISABLE KEYS */;
INSERT INTO `test2` (`intID`) VALUES
	(1);
/*!40000 ALTER TABLE `test2` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.units
CREATE TABLE IF NOT EXISTS `units` (
  `unitID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`unitID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.units: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` (`unitID`, `name`) VALUES
	(1, 'кг.'),
	(2, 'гр.'),
	(3, 'мл.');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;

-- Дамп структуры для таблица restaurant.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `authKey` varchar(100) NOT NULL,
  `accessToken` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы restaurant.users: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`, `authKey`, `accessToken`) VALUES
	(4, 'Jack', 'fsdfds', 'dfsdfs', NULL),
	(5, 'Paul', 'kj,kj', 'dfs', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Дамп структуры для триггер restaurant.half_stuff_order_details_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `half_stuff_order_details_after_insert` AFTER INSERT ON `half_stuff_order_details` FOR EACH ROW BEGIN


END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дамп структуры для триггер restaurant.orders_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `orders_after_insert` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
update tables set tables.free = 0 where tables.tableID = new.tableID;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дамп структуры для триггер restaurant.orders_after_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `orders_after_update` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
if new.payment_time > old.start_time then
update tables set tables.free = 1 where tables.tableID = old.tableID;
end if;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дамп структуры для триггер restaurant.order_detail_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `order_detail_after_insert` AFTER INSERT ON `order_details` FOR EACH ROW BEGIN
declare maxID int;
declare minID int;
declare currentID int;
declare productID int;
declare isFound int;
declare portion_amount int;
declare minDate date;

select max(flow_chart_recipes.ingridID) into maxID from flow_chart_recipes;

select min(flow_chart_recipes.ingridID) into minID from flow_chart_recipes;

set currentID = minID;

WHILE (currentID <= maxID) DO
	select count(flow_chart_recipes.ingridID) into isFound 
	from flow_chart_recipes where flow_chart_recipes.flow_chartID = new.flow_chartID and flow_chart_recipes.ingridID = currentID;
	if isFound > 0 then
		select flow_chart_recipes.amount into portion_amount from flow_chart_recipes 
		where flow_chart_recipes.flow_chartID = new.flow_chartID and flow_chart_recipes.ingridID = currentID;
		
		select flow_chart_recipes.ingridID into productID from flow_chart_recipes 
		where flow_chart_recipes.flow_chartID = new.flow_chartID and flow_chart_recipes.ingridID = currentID;
		
		select min(product_storage.in_date) into minDate from product_storage where product_storage.productID = currentID;
		
		update product_storage set product_storage.amount = product_storage.amount - portion_amount * new.portions_amount
   	where product_storage.productID = currentID and product_storage.in_date = minDate;
   end if;
   SET currentID = currentID + 1;
END WHILE;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Дамп структуры для триггер restaurant.products_in_invoices_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `products_in_invoices_after_insert` AFTER INSERT ON `products_in_invoices` FOR EACH ROW BEGIN
declare countProd int;
select count(product_storage.productID) into countProd from product_storage
where product_storage.productID = new.productID
and product_storage.in_date = new.manufctr_date;

if countProd >0
then update product_storage set product_storage.amount = product_storage.amount + new.amount where product_storage.productID = new.productID;

else 
insert into product_storage(product_storage.productID,product_storage.in_date,product_storage.amount )
values (new.productID,new.manufctr_date,new.amount);
end if;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
