SELECT EXTRACT(Month FROM fs.OrderDate) as Month, 
SUM(fs.TaxAmount) as `Tax Payments`
FROM DM_FactSales fs
WHERE fs.OrderDate >= Date("2014-01-11") AND fs.OrderDate <= Date("2014-07-31")
GROUP BY Month ORDER BY Month;