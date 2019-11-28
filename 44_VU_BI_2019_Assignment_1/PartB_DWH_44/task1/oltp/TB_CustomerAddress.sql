CREATE TABLE `TB_CustomerAddress` (
	`CustomerID` INT NOT NULL,
	`AddressID` INT NOT NULL,
	`AddressType` TEXT NOT NULL,
	CONSTRAINT PK_CustomerAddress PRIMARY KEY (`CustomerID`,`AddressID`),
	CONSTRAINT FK_AddressID_CustomerAddress FOREIGN KEY (`AddressID`) REFERENCES TB_Address(`AddressID`),
	CONSTRAINT FK_CustomerID_CustomerAddress FOREIGN KEY (`CustomerID`) REFERENCES TB_Customer(`CustomerID`)
);