/* Authors - Leonid Tsirunov,
		Leonid Bezvershenko */
USE [Rental_2022]
GO

BEGIN TRY
    BEGIN TRAN
    -----------
	DECLARE @time DATETIME
	DECLARE @errormsg NVARCHAR(64)

	EXEC ShowAllVIP @errormsg OUTPUT
	print(@errormsg)

	EXEC FindFilm 'American Anarchist', 'Charlie Siskel', '2016', @errormsg OUTPUT
	print(@errormsg)

	EXEC CheckVIPClient 'Alina', 'Taylor', '+1-945-122-122', @errormsg OUTPUT
	print(@errormsg)
	EXEC CheckVIPClient 'Yousef', 'Rogers', '+21-218-112-887', @errormsg OUTPUT
	print(@errormsg)

	SET @time = GETDATE()
	EXEC RentCassette 5, 2, 3, @time, 1, @errormsg OUTPUT
	print(@errormsg)
	EXEC RentCassette 9, 20, 4, @time, 1, @errormsg OUTPUT
	print(@errormsg)
	EXEC ShowReturnDate @errormsg OUTPUT
	print(@errormsg)
	
	EXEC ReturnCassette 1, @errormsg OUTPUT
	print(@errormsg)
	EXEC ShowReturnDate @errormsg OUTPUT
	print(@errormsg)

	EXEC NewApplication 11, 'Triller', 'Through The Night', 'Alonso Capriocci', '1972', @errormsg OUTPUT
	print(@errormsg)
	EXEC NewApplication 1, 'Romance', 'Upper than clouds', 'Mira Dirt', '2019', @errormsg OUTPUT
	print(@errormsg)
	EXEC ShowAllApplications @errormsg OUTPUT
	print(@errormsg)

	EXEC RemoveApplication 1
	EXEC ShowAllApplications @errormsg OUTPUT
	print(@errormsg)

	EXEC RemoveClient 8
	EXEC ShowAllVIP @errormsg OUTPUT
	print(@errormsg)

	EXEC RemoveFilm 4 
	-----------
    COMMIT TRAN
END TRY
BEGIN CATCH
    ROLLBACK TRAN
END CATCH 

