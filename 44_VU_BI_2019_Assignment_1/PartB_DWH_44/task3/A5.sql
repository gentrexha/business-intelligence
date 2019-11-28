SELECT c.Name, SUM(fs.OrderLineProfit) as Profit
FROM DM_FactSales fs
LEFT JOIN DM_Customer c
ON fs.CustomerID = c.CustomerID
WHERE OrderDate >= Date("2015-01-01") AND OrderDate <= Date("2015-06-30")
GROUP BY fs.CustomerID ORDER BY Profit DESC LIMIT 10;