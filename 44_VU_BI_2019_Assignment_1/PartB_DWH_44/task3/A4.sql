SELECT
	CustomerRank,
	tm.`Name` CustomerName,
	ProductRank,
	dm_p.Name ProductName
FROM
(
	SELECT
		CustomerRank,
		c.Name,
		ROW_NUMBER() OVER (PARTITION BY c.CustomerID ORDER BY p.timesPurchased) ProductRank,
		p.ProductID
	FROM
	(
		SELECT t.CustomerID, RANK() OVER (ORDER BY t.Profit DESC) CustomerRank, t.Profit, t.Name
		FROM (
			SELECT c.Name, c.CustomerID, SUM(fs.OrderLineProfit) AS Profit
			FROM DM_FactSales fs
			LEFT JOIN DM_Customer c
			ON fs.CustomerID = c.CustomerID
			GROUP BY fs.CustomerID ORDER BY Profit DESC LIMIT 5
		) as t
	) c
	LEFT JOIN
	(
		SELECT COUNT(*) AS timesPurchased, fs.customerID, fs.ProductID
		FROM DM_FactSales fs
		GROUP BY fs.CustomerID, fs.ProductID
	) p
	ON c.CustomerID = p.CustomerID
) tm
LEFT JOIN DM_Product dm_p
ON tm.ProductID = dm_p.ProductID
WHERE ProductRank <=4
ORDER BY CustomerRank, ProductRank;
