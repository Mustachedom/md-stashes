
CREATE TABLE IF NOT EXISTS `mdstashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loc` text NOT NULL,
  `name` text NOT NULL,
  `data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
