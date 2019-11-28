SELECT ProductTopCategory, COUNT() as ProductRank, ProductName
FROM DM_FactSales fs
LEFT JOIN DM_Product p
ON fs.ProductID = p.ProductID
