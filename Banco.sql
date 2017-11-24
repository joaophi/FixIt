-- MySQL Script generated by MySQL Workbench
-- Fri Nov 24 13:41:23 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema fixit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fixit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fixit` DEFAULT CHARACTER SET utf8 ;
USE `fixit` ;

-- -----------------------------------------------------
-- Table `fixit`.`Salas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fixit`.`Salas` (
  `ID_Sala` SMALLINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Sala`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fixit`.`Computadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fixit`.`Computadores` (
  `ID_Computador` SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Numero` TINYINT(2) UNSIGNED NOT NULL,
  `ID_Sala` SMALLINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Computador`),
  INDEX `fk_Computadores_Salas_idx` (`ID_Sala` ASC),
  UNIQUE INDEX `Computador_UNIQUE` (`Numero` ASC, `ID_Sala` ASC),
  CONSTRAINT `fk_Computadores_Salas`
    FOREIGN KEY (`ID_Sala`)
    REFERENCES `fixit`.`Salas` (`ID_Sala`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fixit`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fixit`.`Usuarios` (
  `ID_Usuario` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(140) NOT NULL,
  `Senha` VARCHAR(20) NOT NULL,
  `isAdministrador` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID_Usuario`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fixit`.`Problemas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fixit`.`Problemas` (
  `ID_Problema` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(255) NOT NULL,
  `Tipo` TINYINT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID_Problema`),
  UNIQUE INDEX `Problema_UNIQUE` (`Descricao` ASC, `Tipo` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fixit`.`Chamados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fixit`.`Chamados` (
  `ID_Chamado` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ID_Usuario` TINYINT(3) UNSIGNED NOT NULL,
  `ID_Usuario_Administrador` TINYINT(3) UNSIGNED NULL,
  `Data_Inicial` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Data_Final` DATETIME NULL,
  `ID_Computador` SMALLINT(4) UNSIGNED NOT NULL,
  `ID_Problema` TINYINT(1) UNSIGNED NOT NULL,
  `Observacao` VARCHAR(255) NULL,
  `Status` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  INDEX `fk_Chamados_Usuarios1_idx` (`ID_Usuario` ASC),
  INDEX `fk_Chamados_Usuarios2_idx` (`ID_Usuario_Administrador` ASC),
  INDEX `fk_Chamados_Computadores1_idx` (`ID_Computador` ASC),
  INDEX `fk_Chamados_Problemas1_idx` (`ID_Problema` ASC),
  PRIMARY KEY (`ID_Chamado`),
  CONSTRAINT `fk_Chamados_Usuarios1`
    FOREIGN KEY (`ID_Usuario`)
    REFERENCES `fixit`.`Usuarios` (`ID_Usuario`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Chamados_Usuarios2`
    FOREIGN KEY (`ID_Usuario_Administrador`)
    REFERENCES `fixit`.`Usuarios` (`ID_Usuario`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Chamados_Computadores1`
    FOREIGN KEY (`ID_Computador`)
    REFERENCES `fixit`.`Computadores` (`ID_Computador`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Chamados_Problemas1`
    FOREIGN KEY (`ID_Problema`)
    REFERENCES `fixit`.`Problemas` (`ID_Problema`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `fixit`.`Salas`
-- -----------------------------------------------------
START TRANSACTION;
USE `fixit`;
INSERT INTO `fixit`.`Salas` (`ID_Sala`) VALUES (101);
INSERT INTO `fixit`.`Salas` (`ID_Sala`) VALUES (202);
INSERT INTO `fixit`.`Salas` (`ID_Sala`) VALUES (303);

COMMIT;


-- -----------------------------------------------------
-- Data for table `fixit`.`Computadores`
-- -----------------------------------------------------
START TRANSACTION;
USE `fixit`;
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (1, 1, 101);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (2, 1, 202);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (3, 1, 303);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (4, 2, 101);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (5, 2, 202);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (6, 2, 303);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (7, 3, 101);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (8, 3, 202);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (9, 3, 303);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (10, 4, 101);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (11, 4, 202);
INSERT INTO `fixit`.`Computadores` (`ID_Computador`, `Numero`, `ID_Sala`) VALUES (12, 4, 303);

COMMIT;


-- -----------------------------------------------------
-- Data for table `fixit`.`Usuarios`
-- -----------------------------------------------------
START TRANSACTION;
USE `fixit`;
INSERT INTO `fixit`.`Usuarios` (`ID_Usuario`, `Nome`, `Email`, `Senha`, `isAdministrador`) VALUES (1, 'João', 'joaophickmann@outlook.com', '0rJ-DbXrcj@xm-dS#', 0);
INSERT INTO `fixit`.`Usuarios` (`ID_Usuario`, `Nome`, `Email`, `Senha`, `isAdministrador`) VALUES (2, 'Teste', 'a@a.a', 'OM#90o', 1);
INSERT INTO `fixit`.`Usuarios` (`ID_Usuario`, `Nome`, `Email`, `Senha`, `isAdministrador`) VALUES (3, 'Guilherme', 'guikipper1@gmail.com', '+@Yw9L', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `fixit`.`Problemas`
-- -----------------------------------------------------
START TRANSACTION;
USE `fixit`;
INSERT INTO `fixit`.`Problemas` (`ID_Problema`, `Descricao`, `Tipo`) VALUES (1, 'Mouse', 1);
INSERT INTO `fixit`.`Problemas` (`ID_Problema`, `Descricao`, `Tipo`) VALUES (2, 'Netbeans', 2);
INSERT INTO `fixit`.`Problemas` (`ID_Problema`, `Descricao`, `Tipo`) VALUES (3, 'Outros', 1);
INSERT INTO `fixit`.`Problemas` (`ID_Problema`, `Descricao`, `Tipo`) VALUES (4, 'Outros', 2);
INSERT INTO `fixit`.`Problemas` (`ID_Problema`, `Descricao`, `Tipo`) VALUES (5, 'Teclado', 1);
INSERT INTO `fixit`.`Problemas` (`ID_Problema`, `Descricao`, `Tipo`) VALUES (6, 'Android Studio', 2);
INSERT INTO `fixit`.`Problemas` (`ID_Problema`, `Descricao`, `Tipo`) VALUES (7, 'Xampp', 2);
INSERT INTO `fixit`.`Problemas` (`ID_Problema`, `Descricao`, `Tipo`) VALUES (8, 'Monitor', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `fixit`.`Chamados`
-- -----------------------------------------------------
START TRANSACTION;
USE `fixit`;
INSERT INTO `fixit`.`Chamados` (`ID_Chamado`, `ID_Usuario`, `ID_Usuario_Administrador`, `Data_Inicial`, `Data_Final`, `ID_Computador`, `ID_Problema`, `Observacao`, `Status`) VALUES (1, 1, NULL, '2017-11-24 13:17:48', NULL, 1, 1, 'pc explodiu', 1);
INSERT INTO `fixit`.`Chamados` (`ID_Chamado`, `ID_Usuario`, `ID_Usuario_Administrador`, `Data_Inicial`, `Data_Final`, `ID_Computador`, `ID_Problema`, `Observacao`, `Status`) VALUES (2, 3, NULL, '2017-11-24 13:17:48', NULL, 6, 2, 'ta pegando fogo', 2);
INSERT INTO `fixit`.`Chamados` (`ID_Chamado`, `ID_Usuario`, `ID_Usuario_Administrador`, `Data_Inicial`, `Data_Final`, `ID_Computador`, `ID_Problema`, `Observacao`, `Status`) VALUES (3, 3, 2, '2017-11-24 13:17:48', '2017-11-24 13:25:48', 7, 3, 'nao sei', 3);
INSERT INTO `fixit`.`Chamados` (`ID_Chamado`, `ID_Usuario`, `ID_Usuario_Administrador`, `Data_Inicial`, `Data_Final`, `ID_Computador`, `ID_Problema`, `Observacao`, `Status`) VALUES (4, 1, 2, '2017-11-24 13:17:48', '2017-11-24 13:25:48', 9, 4, 'oi', 3);

COMMIT;

