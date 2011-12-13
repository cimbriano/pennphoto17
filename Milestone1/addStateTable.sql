DROP TABLE IF EXISTS `imbriano`.`State` ;

CREATE TABLE IF NOT EXISTS `imbriano`.`State` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `abbreviation` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`id`) ) ;

CREATE UNIQUE INDEX `name_UNIQUE` ON `imbriano`.`State` (`name` ASC) ;

ALTER TABLE `imbriano`.`User`
      ADD CONSTRAINT `fk_user_state`
      FOREIGN KEY (`state_id`)
      REFERENCES `imbriano`.`State` (`id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION ;
