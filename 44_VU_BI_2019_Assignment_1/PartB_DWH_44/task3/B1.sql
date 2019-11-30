SELECT
    ProductTopCategory,
    max_ranks - inv_rank rank,
    sub.Name
FROM
(
    SELECT
        p.ProductTopCategory,
        p.Name,
        COUNT(*) sales,
        ROW_NUMBER() OVER (PARTITION BY p.ProductTopCategory ORDER BY sales) inv_rank,
        COUNT(*) OVER (PARTITION BY p.ProductTopCategory) max_ranks
    FROM DM_FactSales fs
    LEFT JOIN DM_Product p
    ON fs.ProductID = p.ProductID
    GROUP BY p.ProductID
) sub
WHERE sub.inv_rank <= 3
ORDER BY ProductTopCategory, rank;
