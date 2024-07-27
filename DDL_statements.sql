SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema movies_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema movies_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `movies_db` DEFAULT CHARACTER SET utf8 ;
USE `movies_db` ;

-- -----------------------------------------------------
-- Table `movies_db`.`timestamps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`timestamps` (
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NULL,
  `idTimestamps` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idTimestamps`));


-- -----------------------------------------------------
-- Table `movies_db`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`country` (
  `idCountry` INT NOT NULL AUTO_INCREMENT,
  `nameCountry` VARCHAR(50) NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  PRIMARY KEY (`idCountry`),
  INDEX `fk_country_timestamps1_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  CONSTRAINT `fk_country_timestamps1`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies_db`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(15) NOT NULL,
  `lastName` VARCHAR(15) NOT NULL,
  `dateOfBirth` DATE NOT NULL,
  `gender` BIT NOT NULL,
  `country_idCountry` INT NOT NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  `biography` TEXT NULL,
  PRIMARY KEY (`idPerson`),
  INDEX `fk_person_country1_idx` (`country_idCountry` ASC) VISIBLE,
  INDEX `fk_person_timestamps1_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  CONSTRAINT `fk_person_country1`
    FOREIGN KEY (`country_idCountry`)
    REFERENCES `movies_db`.`country` (`idCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_timestamps1`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies_db`.`files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`files` (
  `idFiles` INT NOT NULL AUTO_INCREMENT,
  `fileName` VARCHAR(100) NULL,
  `mimeType` VARCHAR(45) NULL,
  `keyFile` VARCHAR(50) NULL,
  `url` VARCHAR(30) NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  `person_idPerson` INT NOT NULL,
  PRIMARY KEY (`idFiles`),
  INDEX `fk_files_timestamps1_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  INDEX `fk_files_person1_idx` (`person_idPerson` ASC) VISIBLE,
  CONSTRAINT `fk_files_timestamps1`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_files_person1`
    FOREIGN KEY (`person_idPerson`)
    REFERENCES `movies_db`.`person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies_db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`user` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(30) NOT NULL,
  `password` VARCHAR(10) NOT NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  `files_idFiles` INT NULL,
  `firstName` VARCHAR(15) NULL,
  `lastName` VARCHAR(15) NULL,
  PRIMARY KEY (`idUser`),
  INDEX `fk_user_timestamps_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_user_files1_idx` (`files_idFiles` ASC) VISIBLE,
  CONSTRAINT `fk_user_timestamps`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_files1`
    FOREIGN KEY (`files_idFiles`)
    REFERENCES `movies_db`.`files` (`idFiles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `movies_db`.`director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`director` (
  `idDirector` INT NOT NULL AUTO_INCREMENT,
  `person_idPerson` INT NOT NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  PRIMARY KEY (`idDirector`),
  INDEX `fk_director_person1_idx` (`person_idPerson` ASC) VISIBLE,
  INDEX `fk_director_timestamps1_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  CONSTRAINT `fk_director_person1`
    FOREIGN KEY (`person_idPerson`)
    REFERENCES `movies_db`.`person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_director_timestamps1`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies_db`.`character`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`character` (
  `idCharacter` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `description` TEXT NULL,
  `role` ENUM('leading', 'supporting', 'background') NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  `person_idPerson` INT NULL,
  PRIMARY KEY (`idCharacter`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_character_timestamps1_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  INDEX `fk_character_person1_idx` (`person_idPerson` ASC) VISIBLE,
  CONSTRAINT `fk_character_timestamps1`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_character_person1`
    FOREIGN KEY (`person_idPerson`)
    REFERENCES `movies_db`.`person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies_db`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`movie` (
  `idMovie` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(40) NOT NULL,
  `description` TEXT NULL,
  `budget` DECIMAL(10,2) NULL,
  `releaseDate` DATE NULL,
  `duration` INT NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  `files_idFiles` INT NOT NULL,
  `director_idDirector` INT NOT NULL,
  `country_idCountry` INT NOT NULL,
  PRIMARY KEY (`idMovie`),
  INDEX `fk_movie_timestamps1_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  INDEX `fk_movie_files1_idx` (`files_idFiles` ASC) VISIBLE,
  INDEX `fk_movie_director1_idx` (`director_idDirector` ASC) VISIBLE,
  INDEX `fk_movie_country1_idx` (`country_idCountry` ASC) VISIBLE,
  CONSTRAINT `fk_movie_timestamps1`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_files1`
    FOREIGN KEY (`files_idFiles`)
    REFERENCES `movies_db`.`files` (`idFiles`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_director1`
    FOREIGN KEY (`director_idDirector`)
    REFERENCES `movies_db`.`director` (`idDirector`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_country1`
    FOREIGN KEY (`country_idCountry`)
    REFERENCES `movies_db`.`country` (`idCountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies_db`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`genre` (
  `idGenre` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(35) NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  PRIMARY KEY (`idGenre`),
  INDEX `fk_genre_timestamps1_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  CONSTRAINT `fk_genre_timestamps1`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies_db`.`MovieGenre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`MovieGenre` (
  `movie_idMovie` INT NOT NULL,
  `genre_idGenre` INT NOT NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  PRIMARY KEY (`movie_idMovie`, `genre_idGenre`),
  INDEX `fk_movie_has_genre_genre1_idx` (`genre_idGenre` ASC) VISIBLE,
  INDEX `fk_movie_has_genre_movie1_idx` (`movie_idMovie` ASC) VISIBLE,
  INDEX `fk_MovieGenre_timestamps1_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_genre_movie1`
    FOREIGN KEY (`movie_idMovie`)
    REFERENCES `movies_db`.`movie` (`idMovie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_genre_genre1`
    FOREIGN KEY (`genre_idGenre`)
    REFERENCES `movies_db`.`genre` (`idGenre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MovieGenre_timestamps1`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies_db`.`movieCharacter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`movieCharacter` (
  `movie_idMovie` INT NOT NULL,
  `character_idCharacter` INT NOT NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  PRIMARY KEY (`movie_idMovie`, `character_idCharacter`),
  INDEX `fk_movie_has_character_character1_idx` (`character_idCharacter` ASC) VISIBLE,
  INDEX `fk_movie_has_character_movie1_idx` (`movie_idMovie` ASC) VISIBLE,
  INDEX `fk_movie_has_character_timestamps1_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_character_movie1`
    FOREIGN KEY (`movie_idMovie`)
    REFERENCES `movies_db`.`movie` (`idMovie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_character_character1`
    FOREIGN KEY (`character_idCharacter`)
    REFERENCES `movies_db`.`character` (`idCharacter`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_character_timestamps1`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movies_db`.`favoriteMovies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movies_db`.`favoriteMovies` (
  `movie_idMovie` INT NOT NULL,
  `user_idUser` INT NOT NULL,
  `timestamps_idTimestamps` INT NOT NULL,
  PRIMARY KEY (`movie_idMovie`, `user_idUser`),
  INDEX `fk_movie_has_user_user1_idx` (`user_idUser` ASC) VISIBLE,
  INDEX `fk_movie_has_user_movie1_idx` (`movie_idMovie` ASC) VISIBLE,
  INDEX `fk_favoriteMovies_timestamps1_idx` (`timestamps_idTimestamps` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_user_movie1`
    FOREIGN KEY (`movie_idMovie`)
    REFERENCES `movies_db`.`movie` (`idMovie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_user_user1`
    FOREIGN KEY (`user_idUser`)
    REFERENCES `movies_db`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favoriteMovies_timestamps1`
    FOREIGN KEY (`timestamps_idTimestamps`)
    REFERENCES `movies_db`.`timestamps` (`idTimestamps`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
