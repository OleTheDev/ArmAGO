CREATE DATABASE IF NOT EXISTS `ArmAGO_DB`;
USE `ArmAGO_DB`;

CREATE TABLE IF NOT EXISTS `Data` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `pid` varchar(64) NOT NULL,
  `name` varchar(64),
  `rank` int(100) NOT NULL DEFAULT '1',
  `xp` int(100) NOT NULL DEFAULT '0',
  `xp_needed` int(100) NOT NULL DEFAULT '10',
  `wins` int(100) NOT NULL DEFAULT '0',
  `kills` int(100) NOT NULL DEFAULT '0',
  `death` int(100) NOT NULL DEFAULT '0',
  `insert_time` timestamp DEFAULT CURRENT_TIMESTAMP,
  `last_seen` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;
