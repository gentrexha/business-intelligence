SELECT p.ProductTopCategory, SUM(fs.OrderLineProfit) as Profit
FROM DM_FactSales fs
LEFT JOIN DM_Product p
ON fs.ProductID = p.ProductID
WHERE OrderDate >= Date("2015-01-01") AND OrderDate <= Date("2015-12-31")
GROUP BY p.ProductTopCategory ORDER BY Profit DESC;