SELECT l.CountryRegion, SUM(fs.OrderLineTotal) as Revenue
FROM DM_FactSales fs
LEFT JOIN DM_Location l
ON fs.ShipToAddressID = l.AddressID
WHERE OrderDate >= Date("2014-01-01") AND OrderDate <= Date("2014-12-31")
GROUP BY l.CountryRegion ORDER BY Revenue DESC;