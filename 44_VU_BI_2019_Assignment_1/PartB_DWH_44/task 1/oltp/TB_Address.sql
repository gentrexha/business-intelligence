CREATE TABLE `TB_Address` (
	`AddressID` INT NOT NULL,
	`AddressLine` TEXT NOT NULL,
	`City` TEXT NOT NULL,
	`StateProvince` TEXT,
	`CountryRegion` TEXT NOT NULL,
	`PostalCode` TEXT NOT NULL,
	CONSTRAINT PK_Address PRIMARY KEY (`AddressID`)
);