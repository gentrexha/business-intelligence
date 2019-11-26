CREATE TABLE `TB_SalesOrderHeader` (
	`SalesOrderID` INT NOT NULL,
	`RevisionNumber` INT NOT NULL,
	`OrderDate` DATE NOT NULL,
	`DueDate` DATE NOT NULL,
	`ShipDate` DATE,
	`SalesOrderNumber` INT NOT NULL,
	`CustomerID` INT NOT NULL,
	`ShipToAddressID` INT NOT NULL,
	`BillToAddressID` INT NOT NULL,
	`ShipMethodID` INT NOT NULL,
	CONSTRAINT PK_SalesOrderHeader PRIMARY KEY (`SalesOrderID`),
	CONSTRAINT FK_ShipToAddressID_Address FOREIGN KEY (ShipToAddressID) REFERENCES TB_Address(AddressID),
    CONSTRAINT FK_CustomerID_Customer FOREIGN KEY (CustomerID) REFERENCES TB_Customer(CustomerID),
    CONSTRAINT FK_BillToAddressID_Address FOREIGN KEY (BillToAddressID) REFERENCES TB_Address(AddressID),
    CONSTRAINT FK_ShipMethodID_ShipMethod FOREIGN KEY (ShipMethodID) REFERENCES TB_ShipMethod(ShipMethodID)
);