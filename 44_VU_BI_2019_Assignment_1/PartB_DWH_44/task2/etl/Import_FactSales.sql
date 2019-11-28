INSERT INTO BI_OLAP_44.DM_FactSales
SELECT h.SalesOrderNumber,
CONCAT("SOL", h.SalesOrderID, "-", d.SalesOrderDetailID) AS SalesOrderLineNumber,
h.CustomerID,
d.ProductID,
h.ShipToAddressID,
h.BillToAddressID,
sm.Name as ShipMethod,
d.UnitPrice,
case 
	WHEN d.OrderQty >= 10 AND pc.ParentCategoryID = 3 THEN 10 * d.UnitPrice * d.OrderQty
	WHEN d.OrderQty >= 5 AND pc.ParentCategoryID = 3 THEN 5 * d.UnitPrice * d.OrderQty
	WHEN d.OrderQty >= 10 AND pc.ParentCategoryID = 4 THEN 11 * d.UnitPrice * d.OrderQty
	WHEN d.OrderQty >= 5 AND pc.ParentCategoryID = 4 THEN 4 * d.UnitPrice * d.OrderQty
	ELSE 0
END AS Discount,
d.OrderQty
FROM TB_SalesOrderHeader h
LEFT JOIN TB_SalesOrderDetail d
ON h.SalesOrderID = d.SalesOrderID 
LEFT JOIN TB_ShipMethod sm
ON h.ShipMethodID = sm.ShipMethodID
LEFT JOIN TB_Product p
ON d.ProductID = p.ProductID
LEFT JOIN TB_ProductCategory pc
ON p.ProductCategoryID = pc.ProductCategoryID;