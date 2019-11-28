INSERT INTO BI_OLAP_44.DM_Customer
SELECT CustomerID, 
CONCAT_WS(" ", COALESCE(FirstName, ''), COALESCE(MiddleName, ''), COALESCE(LastName, '')) AS Name, 
BirthDate,
YEAR('2016-01-01') - YEAR(BirthDate) AS Age,
IF(gender='M','Male', 'Female') AS Gender,
EmailAddress AS Email, 
Phone
FROM BI_OLTP_44.TB_Customer;