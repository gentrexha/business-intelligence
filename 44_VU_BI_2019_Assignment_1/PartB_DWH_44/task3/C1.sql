(SELECT fs.ShipmentMethod, l.CountryRegion, COUNT(*) as TotalShipments
FROM DM_FactSales fs
LEFT JOIN DM_Location l
ON fs.ShipToAddressID = l.AddressID
GROUP BY fs.ShipmentMethod, l.CountryRegion)t1;

(SELECT fs.ShipmentMethod, l.CountryRegion, COUNT(*) as LateShipments
FROM DM_FactSales fs
LEFT JOIN DM_Location l
ON fs.ShipToAddressID = l.AddressID
WHERE fs.IsLateShipment = 1
GROUP BY fs.ShipmentMethod, l.CountryRegion)t2;


SELECT t1.ShipmentMethod, t1.CountryRegion, t2.LateShipments / t1.TotalShipments as `% of Late Shipments`
FROM (
	SELECT fs.ShipmentMethod, l.CountryRegion, COUNT(*) as TotalShipments
	FROM DM_FactSales fs
	LEFT JOIN DM_Location l
	ON fs.ShipToAddressID = l.AddressID
	GROUP BY fs.ShipmentMethod, l.CountryRegion
)t1
LEFT JOIN (
	SELECT fs.ShipmentMethod, l.CountryRegion, COUNT(*) as LateShipments
	FROM DM_FactSales fs
	LEFT JOIN DM_Location l
	ON fs.ShipToAddressID = l.AddressID
	WHERE fs.IsLateShipment = 1
	GROUP BY fs.ShipmentMethod, l.CountryRegion
)t2 ON t1.ShipmentMethod = t2.ShipmentMethod AND t1.CountryRegion = t2.CountryRegion;