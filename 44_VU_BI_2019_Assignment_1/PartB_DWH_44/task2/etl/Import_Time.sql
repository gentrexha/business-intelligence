INSERT INTO BI_OLAP_44.DM_Time
SELECT `Date`, 
EXTRACT(DAY FROM `Date`) as DayNumberofMonth, 
EXTRACT(MONTH FROM `Date`) as MonthNumberofYear,
EXTRACT(YEAR FROM `Date`) as CalendarYear
FROM (SELECT SellStartDate as `Date` FROM BI_OLTP_44.TB_Product
UNION SELECT SellEndDate FROM BI_OLTP_44.TB_Product
UNION SELECT DiscontinuedDate FROM BI_OLTP_44.TB_Product) as tmp;