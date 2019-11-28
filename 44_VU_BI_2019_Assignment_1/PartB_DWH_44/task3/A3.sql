SELECT EXTRACT(Year FROM fs.OrderDate) as Year, 
EXTRACT(Month FROM fs.OrderDate) as Month, 
p.ProductTopCategory, 
SUM(fs.OrderLineTotal) as `Monthly Revenue`
FROM DM_FactSales fs
LEFT JOIN DM_Product p
ON fs.ProductID = p.ProductID
WHERE OrderDate >= Date("2013-08-13")
GROUP BY Year, Month, p.ProductTopCategory ORDER BY Year, Month, `Monthly Revenue` DESC;