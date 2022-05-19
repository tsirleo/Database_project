/* Authors - Leonid Tsirunov,
		Leonid Bezvershenko */
USE [Rental_2022]
GO

-- Creating view for Clients table where clients, who have used the rental more than 5 times
IF EXISTS
   (SELECT * FROM information_schema.views
    WHERE  [table_schema] = 'dbo' AND [table_name] = 'VIPClients')
  DROP VIEW [dbo].[VIPClients]
GO

CREATE VIEW [dbo].[VIPClients] AS
	SELECT 
		c.[Client ID],
		c.[Client Firstname],
		c.[Client Lastname],
		c.[Client Address],
		c.[Telephone Number],
		c.[Discount],
		c.[HireNum]
	FROM
		[dbo].[Clients] AS c
	WHERE
		c.[HireNum] >= 5
GO

-- Creating view for Applications table where are applications from VIPClients
IF EXISTS
   (SELECT * FROM information_schema.views
    WHERE  [table_schema] = 'dbo' AND [table_name] = 'VIPClientsApplications')
  DROP VIEW [dbo].[VIPClientsApplications]
GO

CREATE VIEW [dbo].[VIPClientsApplications] AS
	SELECT 
		a.[App ID],
		a.[Film Genre],
		a.[Film Name], 
		a.[Film Director],
		a.[Year] 
	FROM
		[dbo].[Applications] AS a
	INNER JOIN [dbo].[Clients] AS c ON a.[Client ID] = c.[Client ID]
	WHERE c.[HireNum] >= 5
GO		  

-- Creating view to visualize the return date of issued cassetes
IF EXISTS
   (SELECT * FROM information_schema.views
    WHERE  [table_schema] = 'dbo' AND [table_name] = 'ReturnDate')
  DROP VIEW [dbo].[ReturnDate]
GO

CREATE VIEW [dbo].[ReturnDate] AS
	SELECT 
		c.[Film ID],
		c.[Film Genre],
		c.[Film Name], 
		c.[Film Director],
		c.[Year], 
		DATEADD(day, r.[RentTime], r.[Issue date]) AS [Return date]
	FROM
		[dbo].[Catalog] AS c
	INNER JOIN [dbo].[RentalList] AS r ON c.[Film ID] = r.[Film ID]
GO	

