SELECT t.CustomerID, RANK() OVER (ORDER BY t.Profit DESC) CustomerRank, t.Profit
FROM (
	SELECT c.Name, c.CustomerID, SUM(fs.OrderLineProfit) AS Profit
	FROM DM_FactSales fs
	LEFT JOIN DM_Customer c
	ON fs.CustomerID = c.CustomerID
	GROUP BY fs.CustomerID ORDER BY Profit DESC LIMIT 5
) AS t;

SELECT COUNT(*) AS timesPurchased, fs.customerID, fs.ProductID
FROM DM_FactSales fs
GROUP BY fs.CustomerID, fs.ProductID ORDER BY timesPurchased DESC LIMIT 4;


