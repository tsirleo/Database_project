/* Authors - Leonid Tsirunov,
		Leonid Bezvershenko */
USE [Rental_2022]
GO

-- Checking if tables already exist, if so drop them
IF OBJECT_ID('dbo.Catalog') IS NOT NULL
    DROP TABLE [dbo].[Catalog]
IF OBJECT_ID('dbo.Client') IS NOT NULL
    DROP TABLE [dbo].[Clients]
IF OBJECT_ID('dbo.Applications') IS NOT NULL
    DROP TABLE [dbo].[Applications]
IF OBJECT_ID('dbo.RentalList') IS NOT NULL
    DROP TABLE [dbo].[RentalList]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Creating Clients table
CREATE TABLE [dbo].[Clients](
	[Client ID] [int] NOT NULL IDENTITY(1,1),
	[Client Firstname] [nvarchar](max) NOT NULL,
	[Client Lastname] [nvarchar](max) NOT NULL,
	[Client Country] [nvarchar](max) NULL,
	[Client Address] [varchar](max) NOT NULL,
	[Telephone Number] [dbo].[telephone] NULL,
	[Discount] [float] NULL,
	[HireNum] [int] NULL,
	CONSTRAINT [PK_Clients] PRIMARY KEY ([Client ID])
) ON [PRIMARY]
GO

-- Creating Applications table
CREATE TABLE [dbo].[Applications](
	[App ID] [int] NOT NULL IDENTITY(1,1),
	[Client ID] [int] NOT NULL,
	[Film Genre] [nvarchar](max) NOT NULL,
	[Film Name] [nvarchar](max) NOT NULL,
	[Film Director] [nvarchar](max) NOT NULL,
	[Year] [nvarchar](5) NOT NULL,
	CONSTRAINT [PK_Applications] PRIMARY KEY ([App ID]),
	CONSTRAINT [FK_Applications_Clients] FOREIGN KEY ([Client ID])
		REFERENCES [dbo].[Clients]([Client ID])
			ON DELETE CASCADE
) ON [PRIMARY]
GO

-- Creating Films catalog table
CREATE TABLE [dbo].[Catalog](
	[Film ID] [int] NOT NULL IDENTITY(1,1),
	[Film Genre] [nvarchar](max) NOT NULL,
	[Film Name] [nvarchar](max) NOT NULL,
	[Film Director] [nvarchar](max) NOT NULL,
	[Year] [nvarchar](5) NOT NULL,
	[RentCost] [money] NOT NULL,
	[Quantity] [int] NOT NULL,
	CONSTRAINT [PK_Catalog] PRIMARY KEY ([Film ID])
) ON [PRIMARY]
GO

-- Creating RentalList junction table
CREATE TABLE [dbo].[RentalList](
	[Rent ID] [int] NOT NULL IDENTITY(1,1),
	[Client ID] [int] NOT NULL,
	[Film ID] [int] NOT NULL,
	[Total Price] [money] NOT NULL,
	[RentTime] [int] NOT NULL,
	[Issue date] [date] NOT NULL,
	[Pledge] [bit] NOT NULL,
	CONSTRAINT [PK_RentalList] PRIMARY KEY ([Rent ID]),
	CONSTRAINT [FK_RentalList_Clients] FOREIGN KEY ([Client ID])
		REFERENCES [dbo].[Clients]([Client ID])
			ON DELETE CASCADE,
	CONSTRAINT [FK_RentalList_Films] FOREIGN KEY ([Film ID])
		REFERENCES [dbo].[Catalog]([Film ID])
			ON DELETE CASCADE
) ON [PRIMARY]
GO
