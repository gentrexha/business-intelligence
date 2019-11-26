CREATE TABLE `TB_Address` (
	`AddressID` INT NOT NULL,
	`AddressLine` TEXT NOT NULL,
	`City` TEXT NOT NULL,
	`PostalCode` INT NOT NULL,
	`CountryRegion` TEXT NOT NULL,
	`StateProvince` TEXT,
	CONSTRAINT PK_Address PRIMARY KEY (`AddressID`)
);