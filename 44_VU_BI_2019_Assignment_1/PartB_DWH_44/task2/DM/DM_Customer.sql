CREATE TABLE `DM_Customer` (
	`CustomerID` INT NOT NULL,
	`Name` TEXT(150) NOT NULL,
	`BirthDate` DATE NOT NULL,
	`Age` INT NOT NULL,
	`Gender` TEXT(10) NOT NULL,
	`Email` TEXT NOT NULL,
	`Phone` TEXT NOT NULL,
	CONSTRAINT PK_Customer PRIMARY KEY (`CustomerID`)
);