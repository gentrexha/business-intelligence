# OLT Setup

## Getting Started

After having mysql installed, you should have a mysql server running usually on port 3306. If my mysql is in your path access it with:

```bash
mysql -u root
```

```sql
create user 'admin'@'localhost' identified by '<your_password>';
```

## Task 1

```sql
CREATE DATABASE BI_OLTP_44;
GRANT ALL PRIVILEGES ON BI_OLTP_44.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;
```

## Task 2

```sql
CREATE DATABASE BI_OLAP_44;
```
