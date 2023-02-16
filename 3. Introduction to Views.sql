-- What are Views?
		-- A view is like a virtul table in the databse.
		-- A view is a database object referenced in the same way as a table.
		-- We can use the 'CREATE' statement with the view name instead the table name.
		-- So that a view is essentially a named SELECT query. 
		-- A view does not persist the data unless you have an indexed view.

		-- WITH SCHEMABINDING statement prevents schema changes to the underlying table. 
		-- Meaning if someone is triying to remove a column from the dependent table of the view, 
		-- which will lead to break the view, the SCHEMABINDING will prevent schema changes 
		-- to the underlying table in order to prevent the view break. It's very common to use SCHEMABINDING
		-- with important views.

		-- Adding a UNIQUE CLUSTERED INDEX to a view makes it an INDEXED VIEW and it makes the 
		-- data persisted to disk in its own right, imroving performance by creating a new physical table.

		-- Inserts and updates to views can only affect one underlying table.



-- Demonstration 3 - Introduction to views

-- Step 1 - Open a new query window to the AdventureWorks database 

USE AdventureWorks;
GO

-- Step 2 - Create a new view.

CREATE VIEW Person.IndividualsWithEmail
AS 
SELECT p.BusinessEntityID, Title, FirstName, MiddleName, LastName, EmailAddress
FROM Person.Person AS p
JOIN Person.EmailAddress as e
ON p.BusinessEntityID=e.BusinessEntityID
GO

-- Step 3 - Query the view
 
SELECT * FROM Person.IndividualsWithEmail;
GO

-- Step 4 - Again query the view and order the results

SELECT * FROM Person.IndividualsWithEmail
ORDER BY LastName;
GO

-- Step 5 - Query the view definition via OBJECT_DEFINITION

SELECT OBJECT_DEFINITION(OBJECT_ID(N'Person.IndividualsWithEmail', N'V'));
GO

		-- The OBJECT_DEFINITION statement is showing the construct of the underlying table.
		-- How the view has been created.

-- Step 6 - Alter the view to use WITH ENCRYPTION
		-- WITH ENCRYPTION will hide the view's definition to scripting it out. 
		-- This will only encrypt the definition of the view not the data.
		-- When troubleshooting the encruption should be disabled.

ALTER VIEW Person.IndividualsWithEmail
WITH ENCRYPTION
AS
SELECT p.BusinessEntityID, Title, FirstName, MiddleName, LastName, EmailAddress
FROM Person.Person AS p
JOIN Person.EmailAddress AS e
on p.BusinessEntityID=e.BusinessEntityID

-- Step 7 - Requery the view definition via OBJECT_DEFINITION

SELECT OBJECT_DEFINITION(OBJECT_ID(N'Person.IndividualsWithEmail', N'V'));
GO

-- Step 8 - Drop the view

DROP VIEW Person.IndividualsWithEmail;
GO

-- Step 9 - Script the existing HumanResources.vEmployee view to
--		    a new query window and review it's definition.

