# Create database
CREATE DATABASE testDB

# Show databases
SHOW DATABASES

# Drop database
DROP DATABASE testDB

## Note: Be careful before dropping a database. Deleting a database will result in loss of complete information stored in the database!

# Backup full database
BACKUP DATABASE testDB
TO DISK = 'D:\backups\testDB.bak'

# Backup with differential
BACKUP DATABASE testDB
TO DISK = 'D:\backups\testDB.bak'
WITH DIFFERENTIAL

## Note: Only the changes are backed up

# Create table
CREATE TABLE Persons (
	PersonID int,
	LastName varchar(255),
	FirstName varchar(255),
	Address varchar(255),
	City varchar(255)
)

# Create table using another table
CREATE TABLE TestTable AS
    SELECT column1, column2,...
    FROM existing_table_name
    WHERE ....;

## Like CTEs

# Drop table
DROP TABLE Shippers

# Truncate table
TRUNCATE TABLE table_name

## Note: The TRUNCATE TABLE statement is used to delete the data inside a table, but not the table itself.

# Alter table
## Add a column
ALTER TABLE Persons
ADD DateiOfBirth date

## Change data type
ALTER TABLE Persons
ALTER COLUMN DateOfBirth year

## Drop a column
ALTER TABLE Persons
DROP COLUMN DateOfBirth

# Constraint

The following constraints are commonly used in SQL:

NOT NULL
UNIQUE
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Prevents actions that would destroy links between tables
CHECK - Ensures that the values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column if no value is specified
CREATE INDEX
