SELECT ProductTopCategory, COUNT() as ProductRank, ProductName
FROM DM_FactSales fs
LEFT JOIN DM_Product p
ON fs.ProductID = p.ProductID;



WHERE
(
	SELECT DISTINCT ProductTopCategory
	from DM_FactSales fs
);

SELECT COUNT(*) as timesPurchased
RANK() OVER (PARTITION BY
                     p.ProductTopCategory
                 ORDER BY
                     COUNT(*)
                ) ProductRank
FROM DM_FactSales fs
LEFT JOIN DM_Product p
ON fs.ProductID = p.ProductID;