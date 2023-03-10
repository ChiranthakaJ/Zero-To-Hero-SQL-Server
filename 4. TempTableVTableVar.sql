-- Temporary Tables --
		-- Temporary tables are used to hold temporary result sets within a user's session.
		-- Effectively, if you want to create a loading table, we create a 'Temporary' table.
		-- This 'Temp' table will be a scratched version of the respective main table.
		-- Temp table will be created when the user session started and deleted once the session ended.
		-- Declared with a # prefix.
		-- Global temporary tables are created with ## prefix.