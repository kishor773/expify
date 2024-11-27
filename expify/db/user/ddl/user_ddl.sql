-- MySQL Script generated by MySQL Workbench
-- Thu Nov 28 00:17:38 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema expify
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `expify` ;

-- -----------------------------------------------------
-- Schema expify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `expify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
SHOW WARNINGS;
USE `expify` ;

-- -----------------------------------------------------
-- Table `expify`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `expify`.`user` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `expify`.`user` (
  `user_id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NULL,
  `full_name` VARCHAR(500) NULL,
  `gender` VARCHAR(10) NULL,
  `dob` VARCHAR(10) NULL,
  `country_code` VARCHAR(3) NULL DEFAULT '+91',
  `last_login` VARCHAR(45) NULL,
  `image_url` VARCHAR(100) NULL,
  `status` TINYINT NOT NULL DEFAULT 1,
  `created_id` BIGINT NOT NULL,
  `created_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_id` BIGINT NOT NULL,
  `modified_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uk_email_phone` ON `expify`.`user` (`email` ASC, `phone` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `expify`.`transaction_category_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `expify`.`transaction_category_type` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `expify`.`transaction_category_type` (
  `transaction_category_type_id` BIGINT NOT NULL AUTO_INCREMENT,
  `transaction_category_type_alias` VARCHAR(100) NOT NULL,
  `transaction_category_type_name` VARCHAR(100) NOT NULL,
  `transaction_category_icon` VARCHAR(45) NULL,
  `status` TINYINT NOT NULL DEFAULT 1,
  `created_id` BIGINT NOT NULL,
  `created_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_id` BIGINT NOT NULL,
  `modified_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_category_type_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `expify`.`user_kyc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `expify`.`user_kyc` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `expify`.`user_kyc` (
  `user_kyc_id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL,
  `pan` VARCHAR(15) NOT NULL,
  `aadhar` VARCHAR(12) NOT NULL,
  `kyc_status` CHAR(1) NOT NULL DEFAULT 'N',
  `status` TINYINT NOT NULL DEFAULT 1,
  `created_id` BIGINT NOT NULL,
  `created_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_id` BIGINT NOT NULL,
  `modified_dtm` TIMESTAMP NOT NULL,
  PRIMARY KEY (`user_kyc_id`),
  CONSTRAINT `fk_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `expify`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uk_pan` ON `expify`.`user_kyc` (`pan` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `uk_aadhar` ON `expify`.`user_kyc` (`aadhar` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_user_id_idx` ON `expify`.`user_kyc` (`user_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `expify`.`user_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `expify`.`user_address` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `expify`.`user_address` (
  `user_address_id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL,
  `address_name` VARCHAR(255) NULL,
  `address_line_1` VARCHAR(255) NULL,
  `address_line_2` VARCHAR(255) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `pincode` VARCHAR(6) NULL,
  `is_primary` TINYINT NULL,
  `status` TINYINT NOT NULL DEFAULT 1,
  `created_id` BIGINT NOT NULL,
  `created_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_id` BIGINT NOT NULL,
  `modified_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_address_id`),
  CONSTRAINT `fk_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `expify`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_user_id_idx` ON `expify`.`user_address` (`user_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `expify`.`bank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `expify`.`bank` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `expify`.`bank` (
  `bank_id` BIGINT NOT NULL AUTO_INCREMENT,
  `bank_name` VARCHAR(45) NOT NULL,
  `bank_code` VARCHAR(45) NOT NULL,
  `bank_branch` VARCHAR(100) NOT NULL,
  `bank_ifsc` VARCHAR(20) NOT NULL,
  `bank_micr` VARCHAR(45) NOT NULL,
  `bank_phone_no` VARCHAR(45) NOT NULL,
  `status` TINYINT NOT NULL DEFAULT 1,
  `created_id` BIGINT NOT NULL,
  `created_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_id` BIGINT NOT NULL,
  `modified_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bank_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `expify`.`transaction_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `expify`.`transaction_type` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `expify`.`transaction_type` (
  `transaction_type_id` BIGINT NOT NULL AUTO_INCREMENT,
  `transaction_type_name` VARCHAR(45) NOT NULL,
  `transaction_type_alias` VARCHAR(45) NULL,
  `transaction_type_desc` VARCHAR(100) NOT NULL,
  `status` TINYINT NOT NULL DEFAULT 1,
  `created_id` BIGINT NOT NULL,
  `created_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_id` BIGINT NOT NULL,
  `modified_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_type_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `expify`.`transaction_ledger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `expify`.`transaction_ledger` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `expify`.`transaction_ledger` (
  `transaction_ledger_id` BIGINT NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL,
  `transaction_category_type_id` BIGINT NULL,
  `transaction_type_id` BIGINT NOT NULL,
  `transaction_date` DATE NOT NULL,
  `transaction_amount` FLOAT NOT NULL,
  `transaction_details` VARCHAR(255) NOT NULL,
  `transaction_status` VARCHAR(45) NOT NULL COMMENT 'SUCCESS, FAILED, FAILED DUE TO INSUFFICIENT BALANCE etc',
  `status` TINYINT NOT NULL DEFAULT 1,
  `created_id` BIGINT NOT NULL,
  `created_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_id` BIGINT NOT NULL,
  `modified_dtm` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_ledger_id`),
  CONSTRAINT `fk_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `expify`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_txn_cat_type_id`
    FOREIGN KEY (`transaction_category_type_id`)
    REFERENCES `expify`.`transaction_category_type` (`transaction_category_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_txn_type_id`
    FOREIGN KEY (`transaction_type_id`)
    REFERENCES `expify`.`transaction_type` (`transaction_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_user_id_idx` ON `expify`.`transaction_ledger` (`user_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_txn_cat_type_id_idx` ON `expify`.`transaction_ledger` (`transaction_category_type_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_txn_type_id_idx` ON `expify`.`transaction_ledger` (`transaction_type_id` ASC) VISIBLE;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `expify`.`transaction_category_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `expify`;
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (1, 'FOOD AND DRINKS', 'Food and Drinks', 'restaurant', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (2, 'GROCERIES', 'Groceries', 'shopping_cart', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (3, 'SHOPPING', 'Shopping', 'shopping_bag', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (4, 'ENTERTAINMENT', 'Entertainment', 'sports_esports', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (5, 'FUEL', 'Fuel', 'local_gas_station', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (6, 'COMMUTE', 'Commute', 'directions_car', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (7, 'TRAVEL', 'Travel', 'travel_explore', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (8, 'PERSONAL CARE', 'Personal Care', 'self_care', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (9, 'BILLS AND UTILITIES', 'Bills and Utilities', 'receipt_long', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (10, 'RENT', 'Rent', 'home', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (11, 'HOUSEHOLD', 'Household', 'construction', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (12, 'INSURANCE', 'Insurance', 'health_and_safety', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (13, 'EDUCATION', 'Education', 'school', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (14, 'MEDICAL', 'Medical', 'medical_services', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (15, 'FITNESS', 'Fitness', 'fitness_center', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (16, 'FAMILY', 'Family', 'group', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (17, 'INVESTMENTS', 'Investments', 'finance_mode', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (18, 'CREDIT BILLS', 'Credit bills', 'credit_card', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (19, 'EMI AND LOANS', 'EMI and Loans', 'money_bag', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (20, 'FINANCE', 'Finance', 'account_balance', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (21, 'ATM', 'ATM', 'atm', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (22, 'WALLETS', 'Wallets', 'wallet', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (23, 'CHARITY', 'Charity', 'volunteer_activism', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (24, 'SELF TRANSFERS', 'Self transfers', 'sync', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (25, 'MONEY TRANSFERS', 'Money Transfers', 'send_money', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_category_type` (`transaction_category_type_id`, `transaction_category_type_alias`, `transaction_category_type_name`, `transaction_category_icon`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (26, 'MISCELLANEOUS', 'Miscellaneous', 'bottom_drawer', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');

COMMIT;


-- -----------------------------------------------------
-- Data for table `expify`.`transaction_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `expify`;
INSERT INTO `expify`.`transaction_type` (`transaction_type_id`, `transaction_type_name`, `transaction_type_alias`, `transaction_type_desc`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (1, 'CREDIT', 'Money In', 'Money received in bank account', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_type` (`transaction_type_id`, `transaction_type_name`, `transaction_type_alias`, `transaction_type_desc`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (2, 'DEBIT', 'Money Out', 'Money sent from bank account', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_type` (`transaction_type_id`, `transaction_type_name`, `transaction_type_alias`, `transaction_type_desc`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (3, 'ON HOLD', 'Money on hold', 'Money is kept on hold by bank', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_type` (`transaction_type_id`, `transaction_type_name`, `transaction_type_alias`, `transaction_type_desc`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (4, 'UPI IN', 'UPI In', 'Money received through UPI', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');
INSERT INTO `expify`.`transaction_type` (`transaction_type_id`, `transaction_type_name`, `transaction_type_alias`, `transaction_type_desc`, `status`, `created_id`, `created_dtm`, `modified_id`, `modified_dtm`) VALUES (5, 'UPI OUT', 'UPI Out', 'Money sent trhough UPI', 1, 1, '2024-11-27 22:04:18', 1, '2024-11-27 22:04:18');

COMMIT;

