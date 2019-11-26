CREATE TABLE `TB_Product` (
	`ProductID` INT,
	`Name` VARCHAR NOT NULL,
	`ProductNumber` INT NOT NULL,
	`StandardCost` DECIMAL NOT NULL,
	`ListPrice` DECIMAL NOT NULL,
	`Size` DECIMAL,
	`Weight` DECIMAL,
	`ProductCategoryID` INT NOT NULL,
	`ProductModelName` VARCHAR,
	`SellStartDate` DATE NOT NULL,
	`SellEndDate` DATE,
	`DiscontinuedDate` DATE,
	CONSTRAINT PK_Product PRIMARY KEY (`ProductID`),
	CONSTRAINT FK_ProductCategoryID_ProductCategory FOREIGN KEY (`ProductCategoryID`) 
	REFERENCES TB_ProductCategory(`ProductCategoryID`)
);