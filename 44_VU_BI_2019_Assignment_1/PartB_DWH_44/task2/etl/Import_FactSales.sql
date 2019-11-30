DROP TABLE IF EXISTS tmp;
CREATE TEMPORARY TABLE tmp AS
SELECT h.SalesOrderNumber,
CONCAT("SOL", h.SalesOrderID, "-", d.SalesOrderDetailID) AS SalesOrderLineNumber,
h.CustomerID,
d.ProductID,
h.ShipToAddressID,
h.BillToAddressID,
sm.Name as ShipmentMethod,
d.UnitPrice,
case
	WHEN d.OrderQty >= 10 AND pc.ParentCategoryID = 3 THEN 10 * d.UnitPrice * d.OrderQty
	WHEN d.OrderQty >= 5 AND pc.ParentCategoryID = 3 THEN 5 * d.UnitPrice * d.OrderQty
	WHEN d.OrderQty >= 10 AND pc.ParentCategoryID = 4 THEN 11 * d.UnitPrice * d.OrderQty
	WHEN d.OrderQty >= 5 AND pc.ParentCategoryID = 4 THEN 4 * d.UnitPrice * d.OrderQty
	ELSE 0
END AS Discount,
d.OrderQty as OrderQuantity,
# OrderLineTotal is generated on insert
# OrderLineProfit is missing
case
	WHEN a.CountryRegion = "United States" THEN 8
	WHEN a.CountryRegion = "Canada" THEN 13
	WHEN a.CountryRegion = "United Kingdom" THEN 17.5
	WHEN a.CountryRegion = "Australia" THEN 10
	ELSE 0
END AS Tax,
# TaxAmount is generated later through Tax^
case
	WHEN sm.Name = "Standard Ground" THEN (d.OrderQty * 2) + 5 * prod.IsBulkyItem
	WHEN sm.Name = "Cargo International" THEN (d.OrderQty * 6) + 10 * prod.IsBulkyItem
	WHEN sm.Name = "Oversea Deluxe" THEN (d.OrderQty * 7) + 12 * prod.IsBulkyItem
	ELSE 0
END AS OrderLineFreightCost,
h.Status as OrderStatus,
h.OrderDate,
h.DueDate,
h.ShipDate,
# IsLateShipment
h.ShipDate > h.DueDate as IsLateShipment,
# StandardCost for calc OrderLineProfit
p.StandardCost
FROM BI_OLTP_44.TB_SalesOrderHeader h
LEFT JOIN BI_OLTP_44.TB_SalesOrderDetail d
ON h.SalesOrderID = d.SalesOrderID
LEFT JOIN BI_OLTP_44.TB_ShipMethod sm
ON h.ShipMethodID = sm.ShipMethodID
LEFT JOIN BI_OLTP_44.TB_Product p
ON d.ProductID = p.ProductID
LEFT JOIN BI_OLTP_44.TB_ProductCategory pc
ON p.ProductCategoryID = pc.ProductCategoryID
LEFT JOIN BI_OLTP_44.TB_Address a
ON a.AddressID = h.ShipToAddressID
LEFT JOIN BI_OLAP_44.DM_Product prod
ON d.ProductID = prod.ProductID;

ALTER TABLE tmp ADD COLUMN OrderLineTotal DECIMAL GENERATED ALWAYS
AS (`OrderQuantity` * `UnitPrice` - `Discount`) STORED;

ALTER TABLE tmp ADD COLUMN TaxAmount DECIMAL GENERATED ALWAYS 
AS (`Tax` / 100 * `OrderLineTotal`) STORED;

ALTER TABLE tmp ADD COLUMN OrderLineProfit DECIMAL GENERATED ALWAYS
AS (`OrderLineTotal` - `OrderQuantity` * `StandardCost`) STORED;

INSERT INTO BI_OLAP_44.DM_FactSales
SELECT     `SalesOrderNumber`,
    `SalesOrderLineNumber`,
    `CustomerID`,
    `ProductID`,
    `ShipToAddressID`,
    `BillToAddressID`,
    `ShipmentMethod`,
    `UnitPrice`,
    `Discount`,
    `OrderQuantity`,
    `OrderLineTotal`,
    `OrderLineProfit`,
    `TaxAmount`,
    `OrderLineFreightCost`,
    `OrderStatus`,
    `OrderDate`,
    `DueDate`,
    `ShipDate`,
    `IsLateShipment` FROM tmp;