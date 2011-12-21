SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `imbriano` ;
USE `imbriano` ;

-- -----------------------------------------------------
-- Table `imbriano`.`State`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`State` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`State` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `abbreviation` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `imbriano`.`State` (`name` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`User` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `password` VARCHAR(45) NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `first_name` VARCHAR(45) NOT NULL ,
  `last_name` VARCHAR(45) NOT NULL ,
  `dob` DATE NOT NULL ,
  `street_address` VARCHAR(45) NULL ,
  `city` VARCHAR(45) NULL ,
  `state_id` INT NULL ,
  `zip_code` VARCHAR(10) NULL ,
  `is_professor` TINYINT(1)  NOT NULL DEFAULT False ,
  `gender` CHAR(1)  NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_user_state`
    FOREIGN KEY (`state_id` )
    REFERENCES `imbriano`.`State` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `userName_UNIQUE` ON `imbriano`.`User` (`email` ASC) ;

CREATE INDEX `fk_user_state` ON `imbriano`.`User` (`state_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Institution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Institution` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Institution` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `imbriano`.`Institution` (`name` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Attended`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Attended` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Attended` (
  `user_id` INT NOT NULL ,
  `institution_id` INT NOT NULL ,
  `start_year` YEAR NULL ,
  `end_year` YEAR NULL ,
  PRIMARY KEY (`user_id`, `institution_id`) ,
  CONSTRAINT `fk_att_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `imbriano`.`User` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_att_institution`
    FOREIGN KEY (`institution_id` )
    REFERENCES `imbriano`.`Institution` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_att_user` ON `imbriano`.`Attended` (`user_id` ASC) ;

CREATE INDEX `fk_att_institution` ON `imbriano`.`Attended` (`institution_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Student` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Student` (
  `user_id` INT NOT NULL ,
  `major` VARCHAR(45) NULL ,
  `gpa` DOUBLE NULL ,
  PRIMARY KEY (`user_id`) ,
  CONSTRAINT `fk_st_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `imbriano`.`User` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_st_user` ON `imbriano`.`Student` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Professor` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Professor` (
  `user_id` INT NOT NULL ,
  `research_area` VARCHAR(45) NULL ,
  `title` VARCHAR(45) NULL ,
  PRIMARY KEY (`user_id`) ,
  CONSTRAINT `fk_pr_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `imbriano`.`User` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pr_user` ON `imbriano`.`Professor` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Advises`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Advises` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Advises` (
  `student_id` INT NOT NULL ,
  `professor_id` INT NOT NULL ,
  PRIMARY KEY (`student_id`, `professor_id`) ,
  CONSTRAINT `fk_adv_student`
    FOREIGN KEY (`student_id` )
    REFERENCES `imbriano`.`Student` (`user_id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adv_professor`
    FOREIGN KEY (`professor_id` )
    REFERENCES `imbriano`.`Professor` (`user_id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_adv_student` ON `imbriano`.`Advises` (`student_id` ASC) ;

CREATE INDEX `fk_adv_professor` ON `imbriano`.`Advises` (`professor_id` ASC) ;

CREATE UNIQUE INDEX `student_id_UNIQUE` ON `imbriano`.`Advises` (`student_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Circle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Circle` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Circle` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NOT NULL ,
  `owner_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_crc_owner`
    FOREIGN KEY (`owner_id` )
    REFERENCES `imbriano`.`User` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_crc_owner` ON `imbriano`.`Circle` (`owner_id` ASC) ;

CREATE UNIQUE INDEX `name_UNIQUE` ON `imbriano`.`Circle` (`name` ASC, `owner_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`In_Circle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`In_Circle` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`In_Circle` (
  `circle_id` INT NOT NULL ,
  `friend_id` INT NOT NULL ,
  PRIMARY KEY (`circle_id`, `friend_id`) ,
  CONSTRAINT `fk_in_crc_circle`
    FOREIGN KEY (`circle_id` )
    REFERENCES `imbriano`.`Circle` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_in_crc_friend`
    FOREIGN KEY (`friend_id` )
    REFERENCES `imbriano`.`User` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_in_crc_circle` ON `imbriano`.`In_Circle` (`circle_id` ASC) ;

CREATE INDEX `fk_in_crc_friend` ON `imbriano`.`In_Circle` (`friend_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Photo` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Photo` (
  `id` INT NOT NULL ,
  `owner_id` INT NOT NULL ,
  `url` VARCHAR(255) NOT NULL ,
  `is_private` TINYINT(1)  NOT NULL DEFAULT True ,
  `upload_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_photo_owner`
    FOREIGN KEY (`owner_id` )
    REFERENCES `imbriano`.`User` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_photo_owner` ON `imbriano`.`Photo` (`owner_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Photo_Visible_To_User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Photo_Visible_To_User` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Photo_Visible_To_User` (
  `photo_id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  PRIMARY KEY (`photo_id`, `user_id`) ,
  CONSTRAINT `fk_pvtu_photo`
    FOREIGN KEY (`photo_id` )
    REFERENCES `imbriano`.`Photo` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pvtu_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `imbriano`.`User` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pvtu_photo` ON `imbriano`.`Photo_Visible_To_User` (`photo_id` ASC) ;

CREATE INDEX `fk_pvtu_user` ON `imbriano`.`Photo_Visible_To_User` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Photo_Visible_To_Circle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Photo_Visible_To_Circle` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Photo_Visible_To_Circle` (
  `photo_id` INT NOT NULL ,
  `circle_id` INT NOT NULL ,
  PRIMARY KEY (`photo_id`, `circle_id`) ,
  CONSTRAINT `fk_pvtc_photo`
    FOREIGN KEY (`photo_id` )
    REFERENCES `imbriano`.`Photo` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pvtc_circle`
    FOREIGN KEY (`circle_id` )
    REFERENCES `imbriano`.`Circle` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pvtc_photo` ON `imbriano`.`Photo_Visible_To_Circle` (`photo_id` ASC) ;

CREATE INDEX `fk_pvtc_circle` ON `imbriano`.`Photo_Visible_To_Circle` (`circle_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Tag` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Tag` (
  `photo_id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  `tag` VARCHAR(45) NOT NULL ,
  `tag_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `fk_tag_photo`
    FOREIGN KEY (`photo_id` )
    REFERENCES `imbriano`.`Photo` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tag_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `imbriano`.`User` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tag_photo` ON `imbriano`.`Tag` (`photo_id` ASC) ;

CREATE INDEX `fk_tag_user` ON `imbriano`.`Tag` (`user_id` ASC) ;

CREATE UNIQUE INDEX `photo_tag_UNIQUE` ON `imbriano`.`Tag` (`tag` ASC, `photo_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Rating` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Rating` (
  `photo_id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  `rating` INT NOT NULL ,
  PRIMARY KEY (`photo_id`, `user_id`) ,
  CONSTRAINT `fk_rt_photo`
    FOREIGN KEY (`photo_id` )
    REFERENCES `imbriano`.`Photo` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rt_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `imbriano`.`User` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_rt_photo` ON `imbriano`.`Rating` (`photo_id` ASC) ;

CREATE INDEX `fk_rt_user` ON `imbriano`.`Rating` (`user_id` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Interest_Desc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Interest_Desc` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Interest_Desc` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

CREATE UNIQUE INDEX `label_UNIQUE` ON `imbriano`.`Interest_Desc` (`label` ASC) ;


-- -----------------------------------------------------
-- Table `imbriano`.`Interested_In`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `imbriano`.`Interested_In` ;

CREATE  TABLE IF NOT EXISTS `imbriano`.`Interested_In` (
  `user_id` INT NOT NULL ,
  `interest_id` INT NOT NULL ,
  PRIMARY KEY (`user_id`, `interest_id`) ,
  CONSTRAINT `fk_int_in_user`
    FOREIGN KEY (`user_id` )
    REFERENCES `imbriano`.`User` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_int_in_interest`
    FOREIGN KEY (`interest_id` )
    REFERENCES `imbriano`.`Interest_Desc` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_int_in_user` ON `imbriano`.`Interested_In` (`user_id` ASC) ;

CREATE INDEX `fk_int_in_interest` ON `imbriano`.`Interested_In` (`interest_id` ASC) ;


-- -----------------------------------------------------
-- Placeholder table for view `imbriano`.`Friendship_View`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `imbriano`.`Friendship_View` (`user_id` INT, `friend_id` INT);

-- -----------------------------------------------------
-- View `imbriano`.`Friendship_View`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `imbriano`.`Friendship_View` ;
DROP TABLE IF EXISTS `imbriano`.`Friendship_View`;
USE `imbriano`;
CREATE  OR REPLACE VIEW `imbriano`.`Friendship_View` AS
SELECT distinct owner_id as user_id, friend_id 
FROM Circle C INNER JOIN In_Circle IC ON C.id = IC.circle_id;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
