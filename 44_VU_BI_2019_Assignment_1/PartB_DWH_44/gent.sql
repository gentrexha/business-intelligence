CREATE TABLE `TB_CustomerAddress` (
	`CustomerID` INT NOT NULL,
	`AddressID` INT NOT NULL,
	`AddressType` INT NOT NULL,
	PRIMARY KEY (`CustomerID`,`AddressID`),
	FOREIGN KEY (`AddressID`) REFERENCES TB_Address(`AddressID`)
	FOREIGN KEY (`CustomerID`) REFERENCES TB_Customer(`CustomerID`)
);


CREATE TABLE `TB_Address` (
	`AddressID` INT NOT NULL,
	`AddressLine` VARCHAR NOT NULL,
	`City` VARCHAR NOT NULL,
	`PostalCode` INT NOT NULL,
	`CountryRegion` VARCHAR NOT NULL,
	`StateProvince` VARCHAR,
	PRIMARY KEY (`AddressID`)
);

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
	PRIMARY KEY (`ProductID`)
	FOREIGN KEY (`ProductCategoryID`) REFERENCES TB_ProductCategory(`ProductCategoryID`)
);