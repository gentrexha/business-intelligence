
CREATE TABLE `DM_Location` (
	`AddressID` INT NOT NULL,
	`PostalCode` TEXT NOT NULL,
	`City` TEXT NOT NULL,
	`StateProvince` TEXT,
	`CountryRegion` TEXT NOT NULL,
	CONSTRAINT PK_Location PRIMARY KEY (`AddressID`)
);

