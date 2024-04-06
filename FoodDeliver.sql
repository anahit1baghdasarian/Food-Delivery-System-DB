-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FoodDeliverySystem
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FoodDeliverySystem
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FoodDeliverySystem` DEFAULT CHARACTER SET utf8 ;
USE `FoodDeliverySystem` ;

-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Restaurant` (
  `restaurant_id` INT NOT NULL AUTO_INCREMENT,
  `restaurantName` VARCHAR(45) NOT NULL,
  `openingTime` TIME NOT NULL,
  `closingTime` TIME NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `streetName` VARCHAR(45) NOT NULL,
  `streetNumber` INT NOT NULL,
  `buildingNumber` INT NOT NULL,
  `zipcode` INT NULL,
  PRIMARY KEY (`restaurant_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`RestaurantDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`RestaurantDetails` (
  `restType_id` INT NOT NULL AUTO_INCREMENT,
  `restTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`restType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NOT NULL,
  PRIMARY KEY (`menu_id`, `restaurant_id`),
  INDEX `fk_Menu_Restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_Restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `FoodDeliverySystem`.`Restaurant` (`restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`MenuDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`MenuDetails` (
  `menuType_id` INT NOT NULL AUTO_INCREMENT,
  `menuTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menuType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`MealsDrinksDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`MealsDrinksDetail` (
  `mdType_id` INT NOT NULL AUTO_INCREMENT,
  `mdTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mdType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`MealsDrinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`MealsDrinks` (
  `mealsDrinks_id` INT NOT NULL AUTO_INCREMENT,
  `mealsDrinksName` VARCHAR(45) NOT NULL,
  `mdType_id` INT NOT NULL,
  PRIMARY KEY (`mealsDrinks_id`, `mdType_id`),
  INDEX `fk_MealsDrinks_MealsDrinksDetail1_idx` (`mdType_id` ASC) VISIBLE,
  CONSTRAINT `fk_MealsDrinks_MealsDrinksDetail1`
    FOREIGN KEY (`mdType_id`)
    REFERENCES `FoodDeliverySystem`.`MealsDrinksDetail` (`mdType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Ingredients` (
  `ingredient_id` INT NOT NULL AUTO_INCREMENT,
  `ingredientName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ingredient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Deliveryman`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Deliveryman` (
  `deliveryman_id` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `middleName` VARCHAR(45) NULL,
  `DOB` DATE NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `streetName` VARCHAR(45) NOT NULL,
  `streetNumber` INT NOT NULL,
  `buildingNumber` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deliveryman_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `middleName` VARCHAR(45) NULL,
  `DOB` DATETIME NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `streetName` VARCHAR(45) NOT NULL,
  `streetNumber` INT NOT NULL,
  `buildingNumber` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `orderDate` DATE NOT NULL,
  `orderStatus` VARCHAR(45) NOT NULL,
  `deliveryTime` TIME NOT NULL,
  `deliveryman_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `deliveryman_id`, `customer_id`),
  INDEX `fk_Order_Deliveryman1_idx` (`deliveryman_id` ASC) VISIBLE,
  INDEX `fk_Order_Customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Deliveryman1`
    FOREIGN KEY (`deliveryman_id`)
    REFERENCES `FoodDeliverySystem`.`Deliveryman` (`deliveryman_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `FoodDeliverySystem`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`RestaurantPhoneNumber`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`RestaurantPhoneNumber` (
  `phoneNumber` INT NOT NULL AUTO_INCREMENT,
  `restaurant_id` INT NOT NULL,
  PRIMARY KEY (`phoneNumber`, `restaurant_id`),
  INDEX `fk_RestaurantPhoneNumber_Restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_RestaurantPhoneNumber_Restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `FoodDeliverySystem`.`Restaurant` (`restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`DeliverymanPhoneNumber`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`DeliverymanPhoneNumber` (
  `phoneNumber` INT NOT NULL AUTO_INCREMENT,
  `deliveryman_id` INT NOT NULL,
  PRIMARY KEY (`phoneNumber`, `deliveryman_id`),
  INDEX `fk_DeliverymanPhoneNumber_Deliveryman1_idx` (`deliveryman_id` ASC) VISIBLE,
  CONSTRAINT `fk_DeliverymanPhoneNumber_Deliveryman1`
    FOREIGN KEY (`deliveryman_id`)
    REFERENCES `FoodDeliverySystem`.`Deliveryman` (`deliveryman_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Vehicle` (
  `vehicle_id` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(45) NULL,
  `type` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  `productionYear` INT NULL,
  PRIMARY KEY (`vehicle_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`CustomerPhoneNumber`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`CustomerPhoneNumber` (
  `phoneNumber` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`phoneNumber`, `customer_id`),
  INDEX `fk_CustomerPhoneNumber_Customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_CustomerPhoneNumber_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `FoodDeliverySystem`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`PaymentDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`PaymentDetails` (
  `pType_id` INT NOT NULL AUTO_INCREMENT,
  `pTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `amount` INT NOT NULL,
  `currency` VARCHAR(20) NOT NULL,
  `customer_id` INT NOT NULL,
  `pType_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`, `customer_id`, `pType_id`),
  INDEX `fk_Payment_Customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Payment_PaymentType1_idx` (`pType_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `FoodDeliverySystem`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_PaymentType1`
    FOREIGN KEY (`pType_id`)
    REFERENCES `FoodDeliverySystem`.`PaymentDetails` (`pType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Restaurant_has_RestaurantDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Restaurant_has_RestaurantDetails` (
  `restaurant_id` INT NOT NULL AUTO_INCREMENT,
  `restType_id` INT NOT NULL,
  `restaurantName` VARCHAR(45) NOT NULL,
  `restTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`restaurant_id`, `restType_id`),
  INDEX `fk_Restaurant_has_RestaurantDetails_RestaurantDetails1_idx` (`restType_id` ASC) VISIBLE,
  INDEX `fk_Restaurant_has_RestaurantDetails_Restaurant_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_Restaurant_has_RestaurantDetails_Restaurant`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `FoodDeliverySystem`.`Restaurant` (`restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Restaurant_has_RestaurantDetails_RestaurantDetails1`
    FOREIGN KEY (`restType_id`)
    REFERENCES `FoodDeliverySystem`.`RestaurantDetails` (`restType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Restaurant_has_Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Restaurant_has_Order` (
  `restaurant_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`restaurant_id`, `order_id`),
  INDEX `fk_Restaurant_has_Order_Order1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_Restaurant_has_Order_Restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_Restaurant_has_Order_Restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `FoodDeliverySystem`.`Restaurant` (`restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Restaurant_has_Order_Order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `FoodDeliverySystem`.`Order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Menu_has_MenuType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Menu_has_MenuType` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `menuType_id` INT NOT NULL,
  PRIMARY KEY (`menu_id`, `menuType_id`),
  INDEX `fk_Menu_has_MenuType_MenuType1_idx` (`menuType_id` ASC) VISIBLE,
  INDEX `fk_Menu_has_MenuType_Menu1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_has_MenuType_Menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `FoodDeliverySystem`.`Menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Menu_has_MenuType_MenuType1`
    FOREIGN KEY (`menuType_id`)
    REFERENCES `FoodDeliverySystem`.`MenuDetails` (`menuType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Menu_has_MealsDrinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Menu_has_MealsDrinks` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `mealsDrinks_id` INT NOT NULL,
  PRIMARY KEY (`menu_id`, `mealsDrinks_id`),
  INDEX `fk_Menu_has_MealsDrinks_MealsDrinks1_idx` (`mealsDrinks_id` ASC) VISIBLE,
  INDEX `fk_Menu_has_MealsDrinks_Menu1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_has_MealsDrinks_Menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `FoodDeliverySystem`.`Menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Menu_has_MealsDrinks_MealsDrinks1`
    FOREIGN KEY (`mealsDrinks_id`)
    REFERENCES `FoodDeliverySystem`.`MealsDrinks` (`mealsDrinks_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Order_has_MealsDrinks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Order_has_MealsDrinks` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `mealsDrinks_id` INT NOT NULL,
  `mdType_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `mealsDrinks_id`, `mdType_id`),
  INDEX `fk_Order_has_MealsDrinks_MealsDrinks1_idx` (`mealsDrinks_id` ASC, `mdType_id` ASC) VISIBLE,
  INDEX `fk_Order_has_MealsDrinks_Order1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_has_MealsDrinks_Order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `FoodDeliverySystem`.`Order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_has_MealsDrinks_MealsDrinks1`
    FOREIGN KEY (`mealsDrinks_id` , `mdType_id`)
    REFERENCES `FoodDeliverySystem`.`MealsDrinks` (`mealsDrinks_id` , `mdType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`Deliveryman_has_Vehicle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`Deliveryman_has_Vehicle` (
  `deliveryman_id` INT NOT NULL AUTO_INCREMENT,
  `vehicle_id` INT NOT NULL,
  `drivingDate` DATETIME NOT NULL,
  PRIMARY KEY (`deliveryman_id`, `vehicle_id`),
  INDEX `fk_Deliveryman_has_Vehicle_Vehicle1_idx` (`vehicle_id` ASC) VISIBLE,
  INDEX `fk_Deliveryman_has_Vehicle_Deliveryman1_idx` (`deliveryman_id` ASC) VISIBLE,
  CONSTRAINT `fk_Deliveryman_has_Vehicle_Deliveryman1`
    FOREIGN KEY (`deliveryman_id`)
    REFERENCES `FoodDeliverySystem`.`Deliveryman` (`deliveryman_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Deliveryman_has_Vehicle_Vehicle1`
    FOREIGN KEY (`vehicle_id`)
    REFERENCES `FoodDeliverySystem`.`Vehicle` (`vehicle_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`DeliverymanRating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`DeliverymanRating` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `deliveryman_id` INT NOT NULL,
  `rating` INT NOT NULL,
  PRIMARY KEY (`customer_id`, `deliveryman_id`),
  INDEX `fk_Customer_has_Deliveryman_Deliveryman1_idx` (`deliveryman_id` ASC) VISIBLE,
  INDEX `fk_Customer_has_Deliveryman_Customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_has_Deliveryman_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `FoodDeliverySystem`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_Deliveryman_Deliveryman1`
    FOREIGN KEY (`deliveryman_id`)
    REFERENCES `FoodDeliverySystem`.`Deliveryman` (`deliveryman_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`RestaurantRating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`RestaurantRating` (
  `restaurant_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `rating` INT NOT NULL,
  PRIMARY KEY (`restaurant_id`, `customer_id`),
  INDEX `fk_Restaurant_has_Customer_Customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Restaurant_has_Customer_Restaurant1_idx` (`restaurant_id` ASC) VISIBLE,
  CONSTRAINT `fk_Restaurant_has_Customer_Restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `FoodDeliverySystem`.`Restaurant` (`restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Restaurant_has_Customer_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `FoodDeliverySystem`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodDeliverySystem`.`MealsDrinks_has_Ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FoodDeliverySystem`.`MealsDrinks_has_Ingredients` (
  `mealsDrinks_id` INT NOT NULL AUTO_INCREMENT,
  `mdType_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  PRIMARY KEY (`mealsDrinks_id`, `mdType_id`, `ingredient_id`),
  INDEX `fk_MealsDrinks_has_Ingredients_Ingredients1_idx` (`ingredient_id` ASC) VISIBLE,
  INDEX `fk_MealsDrinks_has_Ingredients_MealsDrinks1_idx` (`mealsDrinks_id` ASC, `mdType_id` ASC) VISIBLE,
  CONSTRAINT `fk_MealsDrinks_has_Ingredients_MealsDrinks1`
    FOREIGN KEY (`mealsDrinks_id` , `mdType_id`)
    REFERENCES `FoodDeliverySystem`.`MealsDrinks` (`mealsDrinks_id` , `mdType_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MealsDrinks_has_Ingredients_Ingredients1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `FoodDeliverySystem`.`Ingredients` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
