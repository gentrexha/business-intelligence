CREATE TABLE `TB_ProductCategory` (
	`ProductCategoryID` INT NOT NULL,
	`ParentCategoryID` INT,
	`Name` TEXT NOT NULL,
	CONSTRAINT PK_ProductCategory PRIMARY KEY (`ProductCategoryID`),
	CONSTRAINT FK_ParentCategoryID_ProductCategory FOREIGN KEY (`ParentCategoryID`) REFERENCES TB_ProductCategory(`ProductCategoryId`)
);
