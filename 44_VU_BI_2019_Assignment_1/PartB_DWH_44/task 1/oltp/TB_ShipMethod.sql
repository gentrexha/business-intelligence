CREATE TABLE `TB_ShipMethod` (
	`ShipMethodId` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`CostPerShipment` DECIMAL NOT NULL,
	`CostPerUnit` DECIMAL NOT NULL,
	`BulkyItemSurcharge` DECIMAL NOT NULL,
	CONSTRAINT PK_ShipMethod PRIMARY KEY (`ShipMethodId`)
);
