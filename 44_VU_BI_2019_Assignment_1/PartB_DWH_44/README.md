# OLT Setup

## Getting Started

After having mysql installed, you should have a mysql server running usually on port 3306. If my mysql is in your path access it with:

```bash
mysql -u root
```

```sql
create user 'admin'@'localhost' identified by '<your_password>';
```

```sql
CREATE DATABASE BI_OLTP_44;
GRANT ALL PRIVILEGES ON BI_OLTP_44.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;
```

## Ordering of creation

All tables without FK references first:

* TB_Customer
* TB_Address
* TB_ShipMethod
* TB_ProductCategory

Now you can create:

* TB_SalesOrderHeader
* TB_CustomerAddress
* TB_Product

After that you can also create:

* TB_SalesOrderDetail