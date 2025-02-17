CREATE TABLE `DM_Product` (
	`ProductID` INT NOT NULL,
	`ProductNumber` TEXT NOT NULL,
	`Name` TEXT NOT NULL,
	`ModelName` TEXT,
	`StandardCost` DECIMAL NOT NULL,
	`ListPrice` DECIMAL NOT NULL,
	`ProductSubCategory` TEXT,
	`ProductTopCategory` TEXT NOT NULL,
	`SellStartDate` DATE NOT NULL,
	`SellEndDate` DATE,
	`DiscontinuedDate` DATE,
	`Size` TEXT,
	`Weight` DECIMAL,
	`IsBulkyItem` INT NOT NULL,
	CONSTRAINT PK_Product PRIMARY KEY (`ProductID`),
	CONSTRAINT FK_SellStartDate_Product FOREIGN KEY (`SellStartDate`) REFERENCES DM_Time(`Date`),
	CONSTRAINT FK_SellEndDate_Product FOREIGN KEY (`SellEndDate`) REFERENCES DM_Time(`Date`),
	CONSTRAINT FK_DiscontinuedDate_Product FOREIGN KEY (`DiscontinuedDate`) REFERENCES DM_Time(`Date`)
);