CREATE TABLE IF NOT EXISTS `password_recovery` (
  `token` VARCHAR(50) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `expiration` DATETIME NOT NULL,
  PRIMARY KEY (`token`),
  UNIQUE INDEX `token_UNIQUE` (`token` ASC))
