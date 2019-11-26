CREATE TABLE `TB_SalesOrderDetail` (
	`SalesOrderID` INT NOT NULL,
	`SalesOrderDetailID` INT NOT NULL,
	`OrderQty` INT NOT NULL,
	`ProductID` INT NOT NULL,
	`UnitPrice` INT NOT NULL,
	CONSTRAINT PK_SalesOrderDetail PRIMARY KEY (`SalesOrderID`,`SalesOrderDetailID`),
	CONSTRAINT FK_SalesOrderID_SalesOrderHeader FOREIGN KEY (SalesOrderID) REFERENCES TB_SalesOrderHeader(SalesOrderID),
    CONSTRAINT FK_OrderQty_Product FOREIGN KEY (OrderQty) REFERENCES TB_Product(ProductID),
    CONSTRAINT FK_ProductID_Product FOREIGN KEY (ProductID) REFERENCES TB_Product(ProductID),
    CONSTRAINT FK_UnitPrice_Product FOREIGN KEY (UnitPrice) REFERENCES TB_Product(ProductID)
);