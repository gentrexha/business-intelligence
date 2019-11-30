DROP TABLE IF EXISTS tmp_date;
CREATE TEMPORARY TABLE tmp_date as SELECT DISTINCT SellStartDate as `Date`
FROM BI_OLTP_44.TB_Product WHERE SellStartDate IS NOT NULL;

INSERT INTO tmp_date SELECT DISTINCT SellEndDate as `Date`
FROM BI_OLTP_44.TB_Product WHERE SellEndDate IS NOT NULL;

INSERT INTO tmp_date SELECT DISTINCT DiscontinuedDate as `Date`
FROM BI_OLTP_44.TB_Product WHERE DiscontinuedDate IS NOT NULL;

INSERT INTO tmp_date SELECT DISTINCT OrderDate as `Date`
FROM BI_OLTP_44.TB_SalesOrderHeader WHERE OrderDate IS NOT NULL;

INSERT INTO tmp_date SELECT DISTINCT ShipDate as `Date`
FROM BI_OLTP_44.TB_SalesOrderHeader WHERE ShipDate IS NOT NULL;

INSERT INTO tmp_date SELECT DISTINCT DueDate as `Date`
FROM BI_OLTP_44.TB_SalesOrderHeader WHERE DueDate IS NOT NULL;

INSERT INTO BI_OLAP_44.DM_Time
SELECT DISTINCT `Date`,
EXTRACT(DAY FROM `Date`) as DayNumberofMonth,
EXTRACT(MONTH FROM `Date`) as MonthNumberofYear,
EXTRACT(YEAR FROM `Date`) as CalendarYear
FROM tmp_date
WHERE `Date` IS NOT NULL;