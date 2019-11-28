INSERT INTO BI_OLAP_44.DM_Time
SELECT AddressID,
PostalCode,
City,
StateProvince,
CountryRegion
FROM BI_OLTP_44.TB_Address;