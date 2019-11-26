CREATE TABLE `TB_Customer` (
	`CustomerID` INT NOT NULL,
	`Title` VARCHAR,
	`FirstName` VARCHAR NOT NULL,
	`MiddleName` VARCHAR,
	`LastName` VARCHAR NOT NULL,
	`EmailAddress` VARCHAR,
	`Phone` INT,
	`Suffix` VARCHAR,
	`Gender` VARCHAR NOT NULL,
	`Birthdate` DATE NOT NULL,
	CONSTRAINT PK_Customer PRIMARY KEY (`CustomerID`)
);
