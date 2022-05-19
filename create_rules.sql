/* Authors - Leonid Tsirunov,
		Leonid Bezvershenko */
USE [Rental_2022]
GO

-- Creating rule that Quantity of films in Catalog table cannot be less than zero
IF OBJECT_ID('R_Quantity') IS NOT NULL
BEGIN
    EXEC sp_unbindrule 'dbo.Catalog.Quantity'
    DROP RULE [R_Quantity]
END
GO

CREATE RULE [R_Quantity]
    AS @Quantity >= 0
GO
EXEC sp_bindrule R_Quantity, 'dbo.Catalog.Quantity'
GO

-- Creating rule that RentCost of films in Catalog table cannot be less than zero
IF OBJECT_ID('R_RentCost') IS NOT NULL
BEGIN
    EXEC sp_unbindrule 'dbo.Catalog.RentCost'
    DROP RULE [R_RentCost]
END
GO

CREATE RULE [R_RentCost]
    AS @RentCost >= $0
GO
EXEC sp_bindrule R_RentCost, 'dbo.Catalog.RentCost'
GO

-- Creating rule that RentTime in RentalList table cannot be less than one
IF OBJECT_ID('R_RentTime') IS NOT NULL
BEGIN
    EXEC sp_unbindrule 'dbo.RentalList.RentTime'
    DROP RULE [R_RentTime]
END
GO

CREATE RULE [R_RentTime]
    AS @RentTime >= 1
GO
EXEC sp_bindrule R_RentTime, 'dbo.RentalList.RentTime'
GO