INSERT INTO BI_OLAP_44.DM_Product
SELECT p.ProductID,
p.ProductNumber,
p.Name,
p.ProductModelName as ModelName,
p.StandardCost,
p.ListPrice,
pc.Name as ProductSubCategory, 
ppc.Name as ProductTopCategory,
p.SellStartDate,
p.SellEndDate,
p.DiscontinuedDate,
p.Size,
p.Weight,
IF(p.ProductCategoryID = 16 OR p.ProductCategoryID = 18 OR p.ProductCategoryID = 20, 1, 0) AS IsBulkyItem
FROM BI_OLTP_44.TB_Product p
LEFT JOIN BI_OLTP_44.TB_ProductCategory pc
ON p.ProductCategoryID = pc.ProductCategoryID
LEFT JOIN BI_OLTP_44.TB_ProductCategory ppc
ON ppc.ProductCategoryID = pc.ParentCategoryID;