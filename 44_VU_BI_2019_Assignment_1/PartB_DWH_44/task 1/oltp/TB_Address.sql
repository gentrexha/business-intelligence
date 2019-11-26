CREATE TABLE `TB_Address` (
	`AddressID` INT NOT NULL,
	`AddressLine` VARCHAR NOT NULL,
	`City` VARCHAR NOT NULL,
	`PostalCode` INT NOT NULL,
	`CountryRegion` VARCHAR NOT NULL,
	`StateProvince` VARCHAR,
	CONSTRAINT PK_Address PRIMARY KEY (`AddressID`)
);