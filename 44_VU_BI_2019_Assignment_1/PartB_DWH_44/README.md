# OLT Setup

## Getting Started

After having mysql installed, you should have a mysql server running usually on port 3306. If my mysql is in your path access it with:

```bash
mysql -u root
```

```sql
create user 'admin'@'localhost' identified by '12345678';
```

**Execute all tools from the `tools` folder in our repository. Each tool has it's own subdirectory where it subsides.**

Create a new file repository in Spoon, name it `BI_44` and set the location to:

```
/business-intelligence/44_VU_BI_2019_Assignment_1/PartB_DWH_44/task1/
```

## Task 1

```sql
CREATE DATABASE BI_OLTP_44;
GRANT ALL PRIVILEGES ON BI_OLTP_44.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;
```

Open `OLTP create`, you'll have to change the `HOME` variable inside of `OLTP create` to your `task1` directory e.g.:
```
PARAMETER=HOME
Default Value=C:\Users\z0043cyc\Google Drive\TU Wien\Semester 3 Projects\Business Intelligence\business-intelligence\44_VU_BI_2019_Assignment_1\PartB_DWH_44\task1
```
and run it.

Open `OLTP load`, you'll have to change the `DATAPATH` variable inside of `OLTP load` to your `task1` directory e.g.:
```
PARAMETER=DATAPATH
Default Value=C:\Users\z0043cyc\Google Drive\TU Wien\Semester 3 Projects\Business Intelligence\business-intelligence\44_VU_BI_2019_Assignment_1\PartB_DWH_44\data
```
and run it.

## Task 2

```sql
CREATE DATABASE BI_OLAP_44;
```

## FAQ

"For the Bulk Load Error try executing in mysql:

```sql
SHOW VARIABLES LIKE 'local_infile';
```

it will probably be set at 0/OFF. You have to set it to 1, like this:

```sql
SET GLOBAL local_infile = 1;
```

see here: https://bugs.mysql.com/bug.php?id=72220"