CREATE TABLE `TB_SalesOrderDetail` (
	`SalesOrderID` INT NOT NULL,
	`SalesOrderDetailID` INT NOT NULL,
	`OrderQty` INT NOT NULL,
	`ProductID` INT NOT NULL,
	`UnitPrice` DECIMAL NOT NULL,
	CONSTRAINT PK_SalesOrderDetail PRIMARY KEY (`SalesOrderID`,`SalesOrderDetailID`),
	CONSTRAINT FK_SalesOrderID_SalesOrderDetail FOREIGN KEY (SalesOrderID) REFERENCES TB_SalesOrderHeader(SalesOrderID),
    CONSTRAINT FK_ProductID_SalesOrderDetail FOREIGN KEY (ProductID) REFERENCES TB_Product(ProductID)
);