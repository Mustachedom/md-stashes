
CREATE TABLE IF NOT EXISTS `mdstashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loc` text NOT NULL,
  `name` text NOT NULL,
  `job` text DEFAULT NULL,
  `gang` text DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `slots` int(11) DEFAULT NULL,
  `item` text DEFAULT NULL,
  `targetlabel` text DEFAULT NULL,
  `password` int(11) DEFAULT NULL,
  `citizenid` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
