
-- Step 1: Creating the Databse named 'DEMODB --
CREATE DATABASE DEMODB
GO



-- Step 2: Instructing the Database Engine to use the DEMODB from now onwards --
USE DEMODB
GO



-- Step 3: Creating the Customer table and populate it --
CREATE TABLE dbo.Customer
(
	CustomerID int IDENTITY(1,1) PRIMARY KEY,
	CustomerFirstName nvarchar(50) NOT NULL,
	CustomerLastName nvarchar(50) NOT NULL
);
GO


-- Inserting data to the Customer table --
INSERT INTO DBO.Customer
	VALUES ('Marcin', 'Jankowski'),('Darcy', 'Jayne')
GO


-- Querying all the data records in the Customer table --
SELECT * FROM Customer



-- Step 4: Creating the CustomerOrder table and populate it --
CREATE TABLE dbo.CustomerOrder
(
	CustomerOrderID int IDENTITY(1000001,1) PRIMARY KEY,
	CustomerID int NOT NULL 
		FOREIGN KEY REFERENCES dbo.Customer (CustomerID),
	OrderAmount decimal(18,2) NOT NULL
);
-- FOREIGN KEY REFERENCE mean that the 'CustomerOrder' table's 'CustomerID' has a RELATIONSHIP 
-- with the 'Customer' table's CustomerID column. By using the FKs and PKs the DBMS can maintain
-- the referential integrity easily.

-- Inserting data to the CustomerOrder table --
INSERT INTO DBO.CustomerOrder (CustomerID, OrderAmount)
	VALUES (1, 12.50), (2, 14.70);
GO


-- Querying all the data records in the CustomerOrder table --
SELECT * FROM CustomerOrder



-- Step 5: Try to insert a CustomerOrder record for an invalid CustomerID. 
--		   Note that the ERROR messages look difficult to understand as the constraints
--         are not named properly.

INSERT INTO dbo.CustomerOrder (CustomerID, OrderAmount)
	VALUES (3, 15.50)
GO

-- ERROR MESSAGE: The INSERT statement conflicted with the FOREIGN KEY constraint "FK__CustomerO__Custo__398D8EEE". The conflict occurred in database "DEMODB", 
-- table "dbo.Customer", column 'CustomerID'.

-- This error occurs when a user tried to INSERT a CUSTOMERID that is not in the 'CUSTOMER' table. This vialtes the 'FOREIGN KEY CONSTRAINT'.



-- Step 6: Try to remove a Customer that has an order. This will trigger an ERROR 
--         similar to the above but with a different explanation.
--	       Again note how the poor naming doesn't help much.

DELETE FROM dbo.Customer WHERE  CustomerID = 1;
GO

-- ERROR MESSAGE: The DELETE statement conflicted with the REFERENCE constraint "FK__CustomerO__Custo__398D8EEE". The conflict occurred in database "DEMODB", 
-- table "dbo.CustomerOrder", column 'CustomerID'.

-- This error occurs when the 'CUSTOMERID' in the 'CUSTOMER' table that we are trying to remove, still has orders in the 'CUSTOMERORDER' table and
-- by removing the 'CUSTOMER' there will be 'ORPHAN' data records in the 'CUSTOMERORDER' table that cannot be trackback to a 'Customer' who ordered the items. 
-- This prevents from the 'FOREIGN KEY CONSTRAINT'.



-- Step 7: Remove the foreign key constraints and Replace it with a named constraint with CASCADE
--		   Note that you will need to copy into this code the name of the constraint returned in the 
--         error from the previous statement. This is part of the problem
--         when constraints are not named.

-- Deleting the existing CONSTRAINT
ALTER TABLE DBO.CustomerOrder 
   DROP CONSTRAINT FK__CustomerO__Custo__398D8EEE;
GO

-- Adding the new CONSTRAINT by naming properly and with DELETE CASCADE
-- By using DELETE CASCADE, we will be able to DELETE records b  
ALTER TABLE DBO.CustomerOrder 
   ADD CONSTRAINT FK__CustomerO__CustOmer
   FOREIGN KEY(CustomerID)
   REFERENCES DBO.Customer (CustomerID)
   ON DELETE CASCADE
GO

-- Querying all the data records in the Customer & CustomerOrder tables --
SELECT * FROM Customer
SELECT * FROM CustomerOrder

-- Step 8: Select the list of Customer orders, try a DELETE again
--		   and note that the DELETE is now possible.

SELECT * FROM DBO.CustomerOrder
GO
DELETE FROM DBO.Customer WHERE CustomerID = 1;
GO

-- Step 9: Note how the CASCADE option declared within the FOREIGN KEY constraint caused the
--		   orders in the CUSTOMERORDER TABLE to also be deleted.
--         This CASCADE option will delete the data record in the main table and the related records in the
--         other referenced tables.

SELECT * FROM DBO.Customer;
SELECT * FROM DBO.CustomerOrder;
GO


-- Similar to DELETE CASCADE, UPDATE CASCADE updates the data record along with the referenced data records that
-- are in the other tables as well.

-- However both DELETE CASCADE and UPDATE CASCADE features are used in slightly bizzare scenarios as in the DB design and developemt
-- we are trying to mitigate such occurrences in real life.



-- Step 10:Try to drop the referenced table and note the error:
DROP TABLE DBO.Customer

-- ERROR MESSAGE: Could not drop object 'DBO.Customer' because it is referenced by a FOREIGN KEY constraint.
-- As per the error message, we are unable to delete the table 'CUSTOMER' because it's being referenced from the CUSTOMERORDER 
-- table with the 'CustomerID' column.






