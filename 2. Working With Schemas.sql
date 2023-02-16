-- A schema is a logical collection of database objects such as 
-- tables, views, stored procedures, indexes, triggers, functions.

-- It can be thought of as a container, created by a database user. 
-- The database user who creates a schema is the schema owner.

-- When working with Schemas the following advantages can be achieved.

-- 1. Naming boundary
	-- Logically group database objects.
	-- Use the schema name when referencing database objects to aid 
	-- name resolution.
	-- Syntax: ===> [Server].[Database]Schema.Object 
	-- (This is also called 4 part naming convention)
	-- Ex: dbo.Products and sales.Products are two different object.

-- 2. Security boundary
	-- Simplify security configuration
	-- Database objects inherit permissions set at the schema level.
	-- Syntax: ===> GRANT EXECUTE ON SCHEMA::Sales


USE DEMODB;
GO



-- Step 1: Create a schema

CREATE SCHEMA Reporting AUTHORIZATION dbo;	-- This means the 'REPORTING' schema's owner is dbo.
GO
-- In here dbo is the user DBO(Database Owner) not the default schema dbo.
-- In a database both the user dbo and schema dbo exists and MSSQL SERVER can identify them both independently.



-- Step 2: Create a schema with an included object
CREATE SCHEMA Operations AUTHORIZATION dbo
	CREATE TABLE Flights (FlightID int IDENTITY(1,1) PRIMARY KEY,
						  Origin nvarchar(3),
						  Destination nvarchar(3));
GO

-- Since we executed these two as a single statement, the Flights table 
-- will be within the OPEARTIONS schema.



-- Step 3: Use Object Explorer to work out which schema
--		   the table has been created in.



-- Step 4: Drop the table
DROP TABLE Operations.Flights;
GO



-- Step 5: Drop the schema
DROP SCHEMA Operations;
GO



-- Step 6: Use the same syntax but execute each part of
--		   the statement separately.
CREATE SCHEMA Operations AUTHORIZATION dbo
CREATE TABLE Flights (FlightID int IDENTITY(1,1) PRIMARY KEY,
						  Origin nvarchar(3),
						  Destination nvarchar(3));
GO



-- Step 7: Again, use Object Explorer to work out which schema
--         the table has been created in.



-- Step 8: Create the same table in a different schema.
CREATE TABLE Reporting.Flights (FlightID int IDENTITY(1,1) PRIMARY KEY,
						  Origin nvarchar(3),
						  Destination nvarchar(3));
GO



-- Step 9: Again, use Object Explorer to work out which schema
--         the table has been created in.
