CREATE TABLE `TB_Product` (
	`ProductID` INT,
	`Name` TEXT NOT NULL,
	`ProductNumber` INT NOT NULL,
	`StandardCost` DECIMAL NOT NULL,
	`ListPrice` DECIMAL NOT NULL,
	`Size` DECIMAL,
	`Weight` DECIMAL,
	`ProductCategoryID` INT NOT NULL,
	`ProductModelName` TEXT,
	`SellStartDate` DATE NOT NULL,
	`SellEndDate` DATE,
	`DiscontinuedDate` DATE,
	CONSTRAINT PK_Product PRIMARY KEY (`ProductID`),
	CONSTRAINT FK_ProductCategoryID_Product FOREIGN KEY (`ProductCategoryID`) REFERENCES TB_ProductCategory(`ProductCategoryID`)
);