/* Authors - Leonid Tsirunov,
		Leonid Bezvershenko */
USE [Rental_2022]
GO

-- 'telephone' is an alphanumeric code, that can be nvarchar(15)
IF EXISTS
   (SELECT [DOMAIN_NAME] FROM INFORMATION_SCHEMA.DOMAINS
    WHERE [DOMAIN_SCHEMA] = 'dbo' AND [DOMAIN_NAME] = 'telephone')
  EXEC sp_droptype [telephone]
GO

EXEC sp_addtype [telephone], 'nvarchar(15)'
GO

