CREATE TABLE `DM_FactSales` (
    `SalesOrderNumber` INT NOT NULL,
    `SalesOrderLineNumber` INT NOT NULL,
    `CustomerID` INT,
    `ProductID` INT,
    `ShipToAddressID` INT,
    `BillToAddressID` INT,
    `ShipmentMethod` TEXT,
    `UnitPrice` DECIMAL,
    `Discount` DECIMAL,
    `OrderQuantity` INT,
    `OrderLineTotal` DECIMAL AS (`OrderQuantity` * `UnitPrice` - `Discount`),
    `OrderLineProfit` DECIMAL,
    `TaxAmount` DECIMAL,
    `OrderLineFreightCost` DECIMAL,
    `OrderStatus` INT,
    `OrderDate` Date,
    `DueDate` Date,
    `ShipDate` Date,
    `IsLateShipment` INT,
    CONSTRAINT PK_FactSales PRIMARY KEY (`SalesOrderNumber`, `SalesOrderLineNumber`),
	CONSTRAINT FK_CustomerID_FactSales FOREIGN KEY (`CustomerID`) REFERENCES DM_Customer(`CustomerID`),
	CONSTRAINT FK_ProductID_FactSales FOREIGN KEY (`ProductID`) REFERENCES DM_Product(`ProductID`),
	CONSTRAINT FK_ShipToAddressID_FactSales FOREIGN KEY (`ShipToAddressID`) REFERENCES DM_Location(`AddressID`),
	CONSTRAINT FK_BillToAddressID_FactSales FOREIGN KEY (`BillToAddressID`) REFERENCES DM_Location(`AddressID`),
	CONSTRAINT FK_OrderDate_FactSales FOREIGN KEY (`OrderDate`) REFERENCES DM_Time(`Date`),
	CONSTRAINT FK_DueDate_FactSales FOREIGN KEY (`DueDate`) REFERENCES DM_Time(`Date`),
	CONSTRAINT FK_ShipDate_FactSales FOREIGN KEY (`ShipDate`) REFERENCES DM_Time(`Date`)
);
