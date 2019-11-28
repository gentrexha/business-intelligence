CREATE TABLE `TB_Customer` (
	`CustomerID` INT NOT NULL,
	`Title` TEXT,
	`FirstName` TEXT NOT NULL,
	`MiddleName` TEXT,
	`LastName` TEXT NOT NULL,
	`Suffix` TEXT,
	`EmailAddress` TEXT,
	`Phone` TEXT,
	`Gender` TEXT NOT NULL,
	`Birthdate` DATE NOT NULL,
	CONSTRAINT PK_Customer PRIMARY KEY (`CustomerID`)
);
