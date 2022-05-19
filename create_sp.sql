/* Authors - Leonid Tsirunov,
		Leonid Bezvershenko */
USE [Rental_2022]
GO

-- Checking if stored procedures already exist, if so drop them
IF OBJECT_ID('ClearTables') IS NOT NULL
	DROP PROCEDURE [ClearTables]
IF OBJECT_ID('FindFilm') IS NOT NULL
	DROP PROCEDURE [FindFilm]
IF OBJECT_ID('CheckVIPClient') IS NOT NULL
	DROP PROCEDURE [CheckVIPClient]
IF OBJECT_ID('ShowReturnDate') IS NOT NULL
	DROP PROCEDURE [ShowReturnDate]
IF OBJECT_ID('ShowAllApplications') IS NOT NULL
	DROP PROCEDURE [ShowAllApplications]
IF OBJECT_ID('ShowAllVIP') IS NOT NULL
	DROP PROCEDURE [ShowAllVIP]
IF OBJECT_ID('IncFilmNum') IS NOT NULL
	DROP PROCEDURE [IncFilmNum]
IF OBJECT_ID('DecFilmNum') IS NOT NULL
	DROP PROCEDURE [DecFilmNum]
IF OBJECT_ID('RentCassette') IS NOT NULL
	DROP PROCEDURE [RentCassette]
IF OBJECT_ID('ReturnCassette') IS NOT NULL
	DROP PROCEDURE [ReturnCassette]
IF OBJECT_ID('NewApplication') IS NOT NULL
	DROP PROCEDURE [NewApplication]
IF OBJECT_ID('UpdateApplication') IS NOT NULL
	DROP PROCEDURE [UpdateApplication]
IF OBJECT_ID('RemoveApplication') IS NOT NULL
	DROP PROCEDURE [RemoveApplication]
IF OBJECT_ID('NewClient') IS NOT NULL
	DROP PROCEDURE [NewClient]
IF OBJECT_ID('UpdateClient') IS NOT NULL
	DROP PROCEDURE [UpdateClient]
IF OBJECT_ID('RemoveClient') IS NOT NULL
	DROP PROCEDURE [RemoveClient]
IF OBJECT_ID('NewFilm') IS NOT NULL
	DROP PROCEDURE [NewFilm]
IF OBJECT_ID('UpdateFilm') IS NOT NULL
	DROP PROCEDURE [UpdateFilm]
IF OBJECT_ID('RemoveFilm') IS NOT NULL
	DROP PROCEDURE [RemoveFilm]
GO

-- Creating stored procedure ClearTables
--		This stored procedure simply clears all the tables from loaded date
CREATE PROCEDURE [ClearTables]
AS
BEGIN
	IF EXISTS 
       (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
        WHERE [CONSTRAINT_SCHEMA] = 'dbo' AND [CONSTRAINT_NAME] = 'FK_Applications_Clients'
				                          AND [CONSTRAINT_TYPE] = 'FOREIGN KEY')
	  ALTER TABLE [dbo].[Applications] DROP CONSTRAINT [FK_Applications_Clients]
	IF EXISTS 
       (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
        WHERE [CONSTRAINT_SCHEMA] = 'dbo' AND [CONSTRAINT_NAME] = 'FK_RentalList_Clients'
				                          AND [CONSTRAINT_TYPE] = 'FOREIGN KEY')
	  ALTER TABLE [dbo].[RentalList] DROP CONSTRAINT [FK_RentalList_Clients]
	IF EXISTS 
       (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
        WHERE [CONSTRAINT_SCHEMA] = 'dbo' AND [CONSTRAINT_NAME] = 'FK_RentalList_Films'
				                          AND [CONSTRAINT_TYPE] = 'FOREIGN KEY')
	  ALTER TABLE [dbo].[RentalList] DROP CONSTRAINT [FK_RentalList_Films]

	TRUNCATE TABLE [dbo].[Clients]
	TRUNCATE TABLE [dbo].[Applications]
	TRUNCATE TABLE [dbo].[Catalog]
	TRUNCATE TABLE [dbo].[RentalList]

	ALTER TABLE [dbo].[Applications]
		ADD CONSTRAINT [FK_Applications_Clients]
			FOREIGN KEY([Client ID]) REFERENCES [dbo].[Clients]([Client ID])
	ALTER TABLE [dbo].[RentalList]
		ADD CONSTRAINT [FK_RentalList_Clients]
			FOREIGN KEY ([Client ID]) REFERENCES [dbo].[Clients]([Client ID])
	ALTER TABLE [dbo].[RentalList]
		ADD CONSTRAINT [FK_RentalList_Films]
			FOREIGN KEY ([Film ID]) REFERENCES [dbo].[Catalog]([Film ID])
END
GO

-- Creating stored procedure FindFilm
--		This stored procedure takes the name of the film, director and year of release as an input
--		and checks if the cassette is available.
CREATE PROCEDURE [FindFilm]
(
	@filmname [nvarchar](max),
	@filmdirector [nvarchar](max),
	@relyear [nvarchar](5),
	@errormsg [nvarchar](64) = NULL OUTPUT
)
AS
BEGIN
	IF EXISTS(
		SELECT 
			c.[Film Name],
			c.[Film Genre],
			c.[Film Director],
			c.[Year],
			c.[RentCost],
			c.[Quantity]
		FROM
			[dbo].[Catalog] AS c
		WHERE 
			c.[Film Name] = @filmname AND c.[Film Director] = @filmdirector AND c.[Year] = @relyear AND c.[Quantity] > 0)
	  BEGIN
		SET @errormsg = NULL 
		SELECT 
			c.[Film Name],
			c.[Film Genre],
			c.[Film Director],
			c.[Year],
			c.[RentCost],
			c.[Quantity]
		FROM
			[dbo].[Catalog] AS c
		WHERE 
			c.[Film Name] = @filmname AND c.[Film Director] = @filmdirector AND c.[Year] = @relyear AND c.[Quantity] > 0
	  END
	ELSE
		SET @errormsg = 'There is no such film in the catalog'
END
GO

-- Creating stored procedure CheckVIPClient
--		This stored procedure takes the firstnamename, lastname and telephone number of the client
--		and checks if this client has VIP status.
CREATE PROCEDURE [CheckVIPClient]
(
	@firstname [nvarchar](max),
	@lastname [nvarchar](max),
	@telephone [dbo].[telephone],
	@errormsg [nvarchar](64) = NULL OUTPUT
)
AS
BEGIN
	IF EXISTS(
		SELECT *
		FROM
			[dbo].[VIPClients] AS c
		WHERE 
			c.[Client Firstname] = @firstname AND c.[Client Lastname] = @lastname AND c.[Telephone Number] = @telephone AND c.[HireNum] >= 5)
	  BEGIN
		SET @errormsg = NULL 
		SELECT *
		FROM
			[dbo].[VIPClients] AS c
		WHERE 
			c.[Client Firstname] = @firstname AND c.[Client Lastname] = @lastname AND c.[Telephone Number] = @telephone AND c.[HireNum] >= 5		
	  END
	ELSE
		SET @errormsg = 'This client has not VIP status'
END
GO

-- Creating stored procedure ShowReturnDate
--		This stored procedure simply returns information about the return date of issued cassetes.
CREATE PROCEDURE [ShowReturnDate]
(
	@errormsg [nvarchar](64) = NULL OUTPUT
)
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[ReturnDate])
	  BEGIN
		SET @errormsg = NULL 
		SELECT * FROM [dbo].[ReturnDate]
	  END
	ELSE
		SET @errormsg = 'There is no rented cassettes'
END
GO

-- Creating stored procedure ShowAllApplications
--		This stored procedure simply returns information applications from the VIP clients.
CREATE PROCEDURE [ShowAllApplications]
(
	@errormsg [nvarchar](64) = NULL OUTPUT
)
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[VIPClientsApplications])
	  BEGIN
		SET @errormsg = NULL 
		SELECT * FROM [dbo].[VIPClientsApplications]
	  END
	ELSE
		SET @errormsg = 'There is no applications from VIP clients'
END
GO

-- Creating stored procedure ShowAllVIP
--		This stored procedure simply returns information about the VIP clients.
CREATE PROCEDURE [ShowAllVIP]
(
	@errormsg [nvarchar](64) = NULL OUTPUT
)
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[VIPClients])
	  BEGIN
		SET @errormsg = NULL 
		SELECT * FROM [dbo].[VIPClients]
	  END
	ELSE
		SET @errormsg = 'There is no VIP clients'
END
GO

CREATE PROCEDURE [IncFilmNum]
(
	@film [int],
	@errormsg [nvarchar](64) = NULL OUTPUT
)
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[Catalog] AS ct
	    	WHERE ct.[Film ID] = @film)
	  BEGIN
		SET @errormsg = NULL 
		UPDATE
			[dbo].[Catalog]
		SET
			[dbo].[Catalog].[Quantity] += 1
		WHERE
			[dbo].[Catalog].[Film ID] = @film	
	  END
	ELSE 
		SET @errormsg = 'No such film in catalog'
END
GO

CREATE PROCEDURE [DecFilmNum]
(
	@film [int],
	@errormsg [nvarchar](64) = NULL OUTPUT
)
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[Catalog] AS ct
	    	WHERE ct.[Film ID] = @film)
	  BEGIN
	    SET @errormsg = NULL 
	    UPDATE
			[dbo].[Catalog]
		SET
			[dbo].[Catalog].[Quantity] -= 1
		WHERE
			[dbo].[Catalog].[Film ID] = @film		
	  END
	ELSE 
		SET @errormsg = 'No such film in catalog'
END
GO

CREATE PROCEDURE [RentCassette]
(
	@client [int],
	@film [int],
	@renttime [int],
	@issuedate [date],
	@pledge [bit],
	@errormsg [nvarchar](64) = NULL OUTPUT
)
AS
BEGIN
	IF (EXISTS(SELECT * FROM [dbo].[Clients] AS cl
	    	WHERE cl.[Client ID] = @client) AND
		EXISTS(SELECT * FROM [dbo].[Catalog] AS ct
	    	WHERE ct.[Film ID] = @film))
	  BEGIN
		SET @errormsg = NULL 
		EXEC DecFilmNum @film, @errormsg OUTPUT

		DECLARE @price [money];
		SELECT 
			@price = c.[RentCost]
		FROM 
			[dbo].[Catalog] AS c
		WHERE
			c.[Film ID] = @film

		DECLARE @discount [float];
		SELECT 
			@discount = c.[Discount]
		FROM 
			[dbo].[Clients] AS c
		WHERE
			c.[Client ID] = @client
		
		DECLARE @total [money];
		SET @total = @renttime * (1 - @discount) * @price

		INSERT INTO [dbo].[RentalList] VALUES (@client, @film, @total, @renttime, @issuedate, @pledge)
		RETURN SCOPE_IDENTITY()
	  END
	ELSE
		SET @errormsg = 'There is no such client in base or film in catalog'
END
GO

CREATE PROCEDURE [ReturnCassette]
(
	@rentID [int],
	@errormsg [nvarchar](64) = NULL OUTPUT
)
AS
BEGIN
	DECLARE @film INT;
	SET @errormsg = NULL 
	SELECT 
		@film = r.[Film ID]
	FROM 
		[dbo].[RentalList] AS r
	WHERE
		r.[Rent ID] = @rentID

	EXEC IncFilmNum @film, @errormsg OUTPUT

	DELETE FROM
		[dbo].[RentalList]
	WHERE
		[Rent ID] = @rentID 
END
GO

CREATE PROCEDURE [NewApplication]
(
	@client [int],
	@genre [nvarchar](max),
	@name [nvarchar](max),
	@director [nvarchar](max),
	@year [nvarchar](5),
	@errormsg [nvarchar](64) = NULL OUTPUT
)
AS
BEGIN
	IF EXISTS(SELECT*FROM [dbo].[VIPClients] AS vc WHERE vc.[Client ID] = @client)
	  BEGIN
		SET @errormsg = NULL
		INSERT INTO [dbo].[Applications] VALUES (@client, @genre, @name, @director, @year)
		RETURN SCOPE_IDENTITY()
	  END
	ELSE 
		SET @errormsg = 'It is not allowed to accept an application not from a VIP client'
END
GO

CREATE PROCEDURE [UpdateApplication]
(
	@id [int],
	@client [int],
	@genre [nvarchar](max),
	@name [nvarchar](max),
	@director [nvarchar](max),
	@year [nvarchar](5)
)
AS
BEGIN
	UPDATE
		[dbo].[Applications]
	SET
		[Client ID] = CASE
			WHEN @client IS NOT NULL THEN @client
			ELSE [Client ID]
		END,
	    [Film Genre] = CASE
			WHEN @genre IS NOT NULL THEN @genre
			ELSE [Film Genre]
		END,
	    [Film Name] = CASE
			WHEN @name IS NOT NULL THEN @name
			ELSE [Film Name]
		END,
	    [Film Director] = CASE
			WHEN @director IS NOT NULL THEN @director
			ELSE [Film Director]
		END,
	    [Year] = CASE
			WHEN @year IS NOT NULL THEN @year
			ELSE [Year]
		END
	WHERE
		[App ID] = @id
END
GO

CREATE PROCEDURE [RemoveApplication]
(
	@id [int]
)
AS
BEGIN
	DELETE FROM
		[dbo].[Applications]
	WHERE
		[App ID] = @id
END
GO

CREATE PROCEDURE [NewClient]
(
	@firstname [nvarchar](max),
	@lastname [nvarchar](max),
	@country [nvarchar](max),
	@address [nvarchar](max),
	@telephone [dbo].[telephone]
)
AS
BEGIN
	INSERT INTO [dbo].[Clients] VALUES (@firstname, @lastname, @country, @address, @telephone, 0.0, 0)
	RETURN SCOPE_IDENTITY()
END
GO

CREATE PROCEDURE [UpdateClient]
(
	@id [int],
	@firstname [nvarchar](max),
	@lastname [nvarchar](max),
	@country [nvarchar](max),
	@address [nvarchar](max),
	@telephone [dbo].[telephone],
	@discount [float],
	@hirenum [int]
)
AS
BEGIN
	UPDATE
		[dbo].[Clients]
	SET
		[Client Firstname] = CASE
			WHEN @firstname IS NOT NULL THEN @firstname
			ELSE [Client Firstname]
		END,
		[Client Lastname] = CASE
			WHEN @lastname IS NOT NULL THEN @lastname
			ELSE [Client Lastname]
		END,
	   	[Client Country] = CASE
			WHEN @country IS NOT NULL THEN @country
			ELSE [Client Country]
		END,
	    	[Client Address] = CASE
			WHEN @address IS NOT NULL THEN @country
			ELSE [Client Address]
		END,
	    	[Telephone Number] = CASE
			WHEN @telephone IS NOT NULL THEN @telephone
			ELSE [Telephone Number]
		END,
	   	[Discount] = CASE
			WHEN @discount IS NOT NULL THEN @discount
			ELSE [Discount]
		END,
	   	[HireNum] = CASE
			WHEN @hirenum IS NOT NULL THEN @hirenum 
			ELSE [HireNum] 
		END
	WHERE
		[Client ID] = @id
END
GO

CREATE PROCEDURE [RemoveClient]
(
	@id [int]
)
AS
BEGIN
	DELETE FROM
		[dbo].[Clients]
	WHERE
		[Client ID] = @id
END
GO

CREATE PROCEDURE [NewFilm]
(
	@genre [nvarchar](max),
	@name [nvarchar](max),
	@director [nvarchar](max),
	@year [nvarchar](5),
	@rent [money],
	@quantity [int]
)
AS
BEGIN
	INSERT INTO [dbo].[Catalog] VALUES (@genre, @name, @director, @year, @rent, @quantity)
	RETURN SCOPE_IDENTITY()
END
GO

CREATE PROCEDURE [UpdateFilm]
(
	@id [int],
	@genre [nvarchar](max),
	@name [nvarchar](max),
	@director [nvarchar](max),
	@year [nvarchar](5),
	@rent [money],
	@quantity [int]
)
AS
BEGIN
	UPDATE
		[dbo].[Catalog]
	SET
		[Film Genre] = CASE
			WHEN @genre IS NOT NULL THEN @genre
			ELSE [Film Genre]
		END,
		[Film Name] = CASE
			WHEN @name IS NOT NULL THEN @name
			ELSE [Film Name]
		END,
	   	[Film Director] = CASE
			WHEN @director IS NOT NULL THEN @director
			ELSE [Film Director]
		END,
	    	[Year] = CASE
			WHEN @year IS NOT NULL THEN @year
			ELSE [Year]
		END,
	    	[RentCost] = CASE
			WHEN @rent IS NOT NULL THEN @rent
			ELSE [RentCost]
		END,
	   	[Quantity] = CASE
			WHEN @quantity IS NOT NULL THEN @quantity
			ELSE [Quantity]
		END
	WHERE
		[Film ID] = @id
END
GO

CREATE PROCEDURE [RemoveFilm]
(
	@id [int]
)
AS
BEGIN
	DELETE FROM
		[dbo].[Catalog]
	WHERE
		[Film ID] = @id
END
GO

