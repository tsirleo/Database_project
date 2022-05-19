/* Authors - Leonid Tsirunov,
		Leonid Bezvershenko */
USE Rental_2022

-- Deleting all old data
EXEC [dbo].[ClearTables]

SET NOCOUNT ON
GO

SET DATEFORMAT dmy
GO

INSERT INTO [dbo].[Clients] VALUES('Guillermo', 'Ward', 'Holland', 'Oen Building, 671-SW Road, Eindhoven', '+31-981-972-121', 0.0, 1)
INSERT INTO [dbo].[Clients] VALUES('Brinley', 'Coleman', 'UK', 'SW-Avenue 58, Queens Cross, London', '+2-211-232-190', 0.0, 3)
INSERT INTO [dbo].[Clients] VALUES('Braden', 'Clark', 'Russia', '90/12 Ak. Vernadskii street, Moscow', '+7-988-100-1230', 0.10, 6)
INSERT INTO [dbo].[Clients] VALUES('Alina', 'Taylor', 'USA', '11/21 Dell Road, Los Angeles, CA', '+1-945-122-122', 0.2, 10)
INSERT INTO [dbo].[Clients] VALUES('Karla', 'Ramirez', 'USA', 'South Manhattan, NY', '+1-988-100-1230', 0.0, 1)
INSERT INTO [dbo].[Clients] VALUES('Evelynn', 'Rivera', 'USA', 'Apple Street, CA', '+1-211-120-1230', 0.0, 2)
INSERT INTO [dbo].[Clients] VALUES('Nora', 'Patterson', 'USA', '21/190 Apple Street, CA', '+1-987-100-1230', 0.0, 4)
INSERT INTO [dbo].[Clients] VALUES('Nikolas', 'Garcia', 'UK', '12 Orange Road, New Hampshire', '+2-978-100-1230', 0.10, 5)
INSERT INTO [dbo].[Clients] VALUES('Layton', 'Williams', 'USA', '129/12 Apple Street, CA', '+1-958-100-1432', 0.0, 1)
INSERT INTO [dbo].[Clients] VALUES('Yousef', 'Rogers', 'UK', 'Lord. Snowdown Road, Eastern County, Wales', '+21-218-112-887', 0.0, 4)
INSERT INTO [dbo].[Clients] VALUES('Gianni', 'White', 'USA', '5 Broadway Avenure, NY', '+1-148-170-2138', 0.10, 5)


INSERT INTO [dbo].[Catalog] VALUES('Dramas', 'Lucknow Central', 'Ranjit Tiwari', '2017', $1.50, 5)
INSERT INTO [dbo].[Catalog] VALUES('Comedies', 'Oh! Baby', 'B. V. Nandini Reddy', '2019', $1.50, 5)
INSERT INTO [dbo].[Catalog] VALUES('Action', 'Anjaan', 'N. Linguswamy', '2014', $1.50, 6)
INSERT INTO [dbo].[Catalog] VALUES('Comedies', 'Hot Bot', 'Michael Polish', '2016', $2, 2)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'I Lost My Body', 'Jérémy Clapin', '2019', $3, 3)
INSERT INTO [dbo].[Catalog] VALUES('Stand-Up', 'Miranda Sings Live…Your Welcome', 'Marcus Raboy', '2019', $4, 1)
INSERT INTO [dbo].[Catalog] VALUES('Comedies,', 'Solo Con Tu Pareja', 'Alfonso Cuarón', '1991', $4, 3)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Zindagi Kitni Haseen Hay', 'Anjum Shahzad', '2016', $3, 4)
INSERT INTO [dbo].[Catalog] VALUES('Documentaries', 'American Anarchist', 'Charlie Siskel', '2016', $1, 3)
INSERT INTO [dbo].[Catalog] VALUES('Comedies,', 'Hunterrr', 'Harshavardhan Kulkarni', '2015', $4, 1)
INSERT INTO [dbo].[Catalog] VALUES('Comedies,', 'Grandmother’s Farm', 'Ahmed Zein', '2014', $2, 4)
INSERT INTO [dbo].[Catalog] VALUES('Comedies,', 'Can’t Complain', 'Ahmed Nader Galal', '2007', $1, 3)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Hunter in the Blue Side of Manchester', 'Rako Prijanto', '2020', $3, 2)
INSERT INTO [dbo].[Catalog] VALUES('Horror', 'The Diabolical', 'Alistair Legrand', '2015', $3, 4)
INSERT INTO [dbo].[Catalog] VALUES('Comedies,', 'Whipped', 'Chandra Liow', '2020', $2, 4)
INSERT INTO [dbo].[Catalog] VALUES('Stand-Up', 'Brad Paisley’s Comedy Rodeo', 'Jay Chapman', '2017', $3, 3)
INSERT INTO [dbo].[Catalog] VALUES('Dramas', 'American Son', 'Kenny Leon', '2019', $4, 4)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Una', 'Benedict Andrews', '2016', $3, 3)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Semana Santa', 'Alejandra Márquez Abella', '2015', $2, 1)
INSERT INTO [dbo].[Catalog] VALUES('Documentaries', 'Merata: How Mum Decolonised the Screen', 'Hepi Mita', '2018', $4, 2)
INSERT INTO [dbo].[Catalog] VALUES('Movies', 'Marco Polo: One Hundred Eyes', 'Alik Sakharov', '2015', $4, 4)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Sunrise', 'Partho Sen-Gupta', '2014', $2, 3)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Badha', 'Sumitra Bhave', '2006', $3, 1)
INSERT INTO [dbo].[Catalog] VALUES('Comedies,', 'Beynelmilel', 'Muharrem Gülmez', '2006', $3, 1)
INSERT INTO [dbo].[Catalog] VALUES('Horror', '14 Cameras', 'Scott Hussion', '2018', $3, 4)
INSERT INTO [dbo].[Catalog] VALUES('International', 'Puriyatha Puthir', 'Ranjit Jeyakodi', '2017', $3, 2)
INSERT INTO [dbo].[Catalog] VALUES('Action', 'The Beast', 'Ludovico Di Martino', '2020', $4, 3)
INSERT INTO [dbo].[Catalog] VALUES('Action', 'Five Elements Ninjas', 'Cheh Chang', '1982', $4, 3)
INSERT INTO [dbo].[Catalog] VALUES('Comedies,', 'Professor', 'Lekh Tandon', '1962', $3, 2)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'The Dreamer', 'Riri Riza', '2009', $4, 2)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Entanglement', 'Jason James', '2018', $4, 2)
INSERT INTO [dbo].[Catalog] VALUES('Children', 'An American Tail: Fievel Goes West', 'Phil Nibbelink', '1991', $2, 2)
INSERT INTO [dbo].[Catalog] VALUES('Comedies', 'Anger Management', 'Peter Segal', '2003', $3, 3)
INSERT INTO [dbo].[Catalog] VALUES('Action', 'Crouching Tiger, Hidden Dragon: Sword of Destiny', 'Yuen Wo-Ping', '2016', $2, 3)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Mom', 'Ravi Udyawar', '2017', $1, 4)
INSERT INTO [dbo].[Catalog] VALUES('Children', 'A Christmas Prince: The Royal Wedding', 'John Schultz', '2018', $3, 2)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Furthest Witness', 'Adam Del Giudice', '2017', $1, 1)
INSERT INTO [dbo].[Catalog] VALUES('Stand-Up', 'Marc Maron: End Times Fun', 'Lynn Shelton', '2020', $4, 4)
INSERT INTO [dbo].[Catalog] VALUES('Action', 'Dum', 'Eeshwar Nivas', '2003', $4, 3)
INSERT INTO [dbo].[Catalog] VALUES('Action', 'Double World', 'Teddy Chan', '2020', $4, 1)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Rezeta', 'Fernando Frías De La Parra', '2012', $2, 3)
INSERT INTO [dbo].[Catalog] VALUES('Dramas,', 'Ten Years', 'Jevons Au', '2015', $3, 3)
INSERT INTO [dbo].[Catalog] VALUES('Children', 'Stuart Little', 'Rob Minkoff', '1999', $1, 1)


SET NOCOUNT OFF
GO
