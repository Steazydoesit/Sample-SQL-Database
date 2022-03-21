-- First we must create the actual database

CREATE DATABASE DenverFoodBank
GO

--Then we ensure we are using the correct DB we just made

USE DenverFoodBank;

--Will now create ALL tables required.  We will assign all keys in the table definitions at the same time, rather than adding constraints in a later step.

CREATE TABLE DenverFoodBank.dbo.Donor (
		DonorID				INT			IDENTITY(1,1) PRIMARY KEY,
		FirstName			VARCHAR(30)	NOT NULL,
		LastName			VARCHAR(50)	NOT NULL,
		PhoneNum			CHAR(12)	NOT NULL,
		Street				VARCHAR(30)	NOT NULL,
		City				VARCHAR(30)	NOT NULL,
		[State]				CHAR(2)		NOT NULL,
		ZipCode				CHAR(5)		NOT NULL,
		FirstDonationDate	DATE		DEFAULT NULL NULL
);

CREATE TABLE DenverFoodBank.dbo.Item (
		ItemNum		INT			IDENTITY(1,1) PRIMARY KEY,
		[Name]		VARCHAR(30)	NOT NULL,
		Category	VARCHAR(30)	NOT NULL,
		[Type]		VARCHAR(30)	NOT NULL
);

CREATE TABLE DenverFoodBank.dbo.Warehouse (
		WarehouseNum	INT			IDENTITY(1,1) PRIMARY KEY,
		Street			VARCHAR(30)	NOT NULL,
		City			VARCHAR(30)	NOT NULL,
		[State]			CHAR(2)		NOT NULL,
		ZipCode			CHAR(5)		NOT NULL,
);

CREATE TABLE DenverFoodBank.dbo.Donation (
		DonationNum		INT		IDENTITY(1,1) PRIMARY KEY,
		DonorID			INT		FOREIGN KEY REFERENCES Donor(DonorID) NOT NULL,
		ItemNum			INT		FOREIGN KEY REFERENCES Item(ItemNum) NOT NULL,
		Quantity		INT		NOT NULL,
		WarehouseNum	INT		FOREIGN KEY REFERENCES Warehouse(WarehouseNum),
		[Date]			DATE	NOT NULL
);



CREATE TABLE DenverFoodBank.dbo.WarehouseInventory (
		WarehouseNum	INT		NOT NULL,
		ItemNum			INT		NOT NULL,
		Quantity		INT		NOT NULL

		PRIMARY KEY(WarehouseNum, ItemNum),
		FOREIGN KEY(WarehouseNum) REFERENCES Warehouse(WarehouseNum),
		FOREIGN KEY(ItemNum) REFERENCES Item(ItemNum)
);

CREATE TABLE DenverFoodBank.dbo.Storefront (
		StoreNum	INT			IDENTITY(1,1) PRIMARY KEY,
		Street		VARCHAR(30)	NOT NULL,
		City		VARCHAR(30)	NOT NULL,
		[State]		CHAR(2)		NOT NULL,
		ZipCode		CHAR(5)		NOT NULL,
);

CREATE TABLE DenverFoodBank.dbo.StorefrontInventory (
		StoreNum	INT		NOT NULL,
		ItemNum		INT		NOT NULL,
		Quantity	INT		NOT NULL,

		PRIMARY KEY(StoreNum, ItemNum),
		FOREIGN KEY(StoreNum) REFERENCES Storefront(StoreNum),
		FOREIGN KEY(ItemNum) REFERENCES Item(ItemNum)
);

CREATE TABLE DenverFoodBank.dbo.InventoryTransferLog (
		TransactionID	INT		IDENTITY(1,1) PRIMARY KEY,
		WarehouseNum	INT		FOREIGN KEY REFERENCES Warehouse(WarehouseNum) NOT NULL,
		ItemNum			INT		FOREIGN KEY REFERENCES Item(ItemNum) NOT NULL,
		StoreNum		INT		FOREIGN KEY REFERENCES Storefront(StoreNum) NOT NULL,
		[Date]			DATE	NOT NULL
);

CREATE TABLE DenverFoodBank.dbo.Recipient (
		RecipientID		INT			IDENTITY(1,1) PRIMARY KEY,
		FirstName		VARCHAR(30)	NOT NULL,
		LastName		VARCHAR(50)	NOT NULL,
		Street			VARCHAR(30)	DEFAULT NULL NULL,
		City			VARCHAR(30)	DEFAULT NULL NULL,
		[State]			CHAR(2)		DEFAULT NULL NULL,
		ZipCode			CHAR(5)		DEFAULT NULL NULL,
		PhoneNum		CHAR(12)	DEFAULT NULL NULL
);

CREATE TABLE DenverFoodBank.dbo.Withdrawal (
		WithdrawalNum	INT		IDENTITY(1,1) PRIMARY KEY,
		RecipientID		INT		FOREIGN KEY REFERENCES Recipient(RecipientID) NOT NULL,
		ItemNum			INT		FOREIGN KEY REFERENCES Item(ItemNum) NOT NULL,
		[Date]			DATE	NOT NULL,
		StoreNum		INT		FOREIGN KEY REFERENCES Storefront(StoreNum) NOT NULL
);

CREATE TABLE DenverFoodBank.dbo.Employee (
		EmployeeID		INT			IDENTITY(1,1) PRIMARY KEY,
		FirstName		VARCHAR(30)	NOT NULL,
		LastName		VARCHAR(50)	NOT NULL,
		Position		VARCHAR(30)	NOT NULL,
		HourlyRate		SMALLMONEY	DEFAULT NULL NULL,
		SSN				CHAR(11)	NOT NULL,
		HireDate		DATE		NOT NULL,
		TerminationDate	DATE		DEFAULT NULL NULL,
		PhoneNum		CHAR(12)	NOT NULL,
		Email			VARCHAR(50)	NOT NULL,
		Street			VARCHAR(30)	NOT NULL,
		City			VARCHAR(30)	NOT NULL,
		[State]			CHAR(2)		NOT NULL,
		ZipCode			CHAR(5)		NOT NULL
);

CREATE TABLE DenverFoodBank.dbo.Timesheet (
		EmployeeID		INT			NOT NULL,
		[Date]			DATE		NOT NULL,
		HoursWorked		FLOAT(53)	NOT NULL,

		PRIMARY KEY(EmployeeID, Date),
		FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID)
);


-- Now we populate the fields with fictitious data courtesy of Mockaroo.

INSERT INTO DenverFoodBank.dbo.Donor
	(FirstName, LastName, PhoneNum, Street, City, [State], ZipCode, FirstDonationDate)
VALUES
	('Emyle','Couthard','202-237-7341','6106 Loftsgordon Street','Washington','DC','20380','7/6/2021'),
	('Peirce','McKeand','772-941-9035','59843 Vermont Street','West Palm Beach','FL','33405',''),
	('Maia','Piddick','305-652-6000','9862 Jackson Parkway','Miami','FL','33261','5/12/2020'),
	('Cyrill','Dronsfield','404-300-6350','5346 Blue Bill Park Road','Atlanta','GA','30343','4/28/2021'),
	('Pip','Clooney','706-472-5184','609 Holmberg Street','Cumming','GA','30130','7/5/2021'),
	('Hattie','Tuckett','206-391-2920','8 Delladonna Place','Seattle','WA','98158','8/27/2021'),
	('Austen','Anthony','217-392-4224','51805 Arizona Road','Springfield','IL','62705','8/5/2020'),
	('Lenna','Scupham','213-574-3593','897 Coolidge Way','Los Angeles','CA','90055','2/4/2020'),
	('Mireielle','Legrice','918-375-3891','85853 Daystar Avenue','Tulsa','OK','74108','7/24/2021'),
	('Marrilee','Dable','865-577-7234','72 Scoville Lane','Knoxville','TN','37924','1/19/2020'),
	('Ethelbert','People','702-265-6103','08079 Ridge Oak Road','Las Vegas','NV','89150','3/17/2020'),
	('Tracee','Trevers','303-394-8333','676 Bultman Court','Boulder','CO','80328','4/10/2020'),
	('Latrena','Dittson','843-345-8044','49506 Mallard Avenue','Florence','SC','29505','11/25/2021'),
	('Bartholomeus','Onians','310-935-5409','808 Tennessee Junction','Inglewood','CA','90310','6/8/2020'),
	('Ibby','Fritche','330-842-4839','72375 Luster Junction','Canton','OH','44710','5/20/2021'),
	('Wilie','Librey','602-685-7342','36635 Barby Trail','Scottsdale','AZ','85255','11/9/2021'),
	('Edgar','Butte','775-799-0803','0 Blue Bill Park Pass','Carson City','NV','89706',''),
	('Mignonne','Pucknell','702-618-5740','59227 Corben Trail','Las Vegas','NV','89125','5/7/2021'),
	('Jennine','Giblin','212-792-8406','84539 Ramsey Point','Brooklyn','NY','11247','8/3/2021'),
	('Maggie','Henriquet','253-987-4594','845 Corben Avenue','Tacoma','WA','98405','9/16/2021'),
	('Adi','Dellit','424-889-7872','187 Bunker Hill Avenue','Los Angeles','CA','90025','6/23/2021'),
	('Moll','Targe','561-195-7520','58406 Pierstorff Place','Delray Beach','FL','33448',''),
	('Burgess','Cisco','862-740-6171','2143 Lakewood Hill','Paterson','NJ','07544','10/20/2020'),
	('Greta','Dutnell','559-210-0534','1 Lillian Parkway','Fresno','CA','93794','9/29/2021'),
	('Tamera','Pallatina','423-133-2351','69 Packers Drive','Chattanooga','TN','37410','1/23/2020'),
	('Tobe','Blasing','216-716-7081','07 Crescent Oaks Plaza','Cleveland','OH','44191','3/15/2021'),
	('Mark','Barthrop','216-327-0463','10 Prairie Rose Lane','Cleveland','OH','44177',''),
	('Berti','Bryceson','573-351-5215','54 Grasskamp Alley','Jefferson City','MO','65105','10/15/2020'),
	('Meier','Aylett','704-935-4644','297 Sage Avenue','Charlotte','NC','28299','7/3/2021'),
	('Morey','Clack','706-830-6977','41 Eagle Crest Crossing','Augusta','GA','30905','2/26/2021'),
	('Lorianna','Sarch','757-345-2701','70 Schlimgen Road','Virginia Beach','VA','23471',''),
	('Felipe','Rabbe','330-559-2989','97539 Granby Pass','Canton','OH','44720','1/5/2020'),
	('Samuele','Eagle','202-916-2099','139 Grim Point','Washington','DC','20546','5/5/2020'),
	('Auroora','Cussen','512-632-4177','6577 Northport Circle','Austin','TX','78737','6/1/2021'),
	('Aluin','Moreby','520-747-1160','7 Bayside Court','Tucson','AZ','85754','6/24/2020'),
	('Merl','Hammel','208-838-2489','0 Monument Alley','Boise','ID','83757','11/28/2020'),
	('Cassandry','Pogue','404-912-1252','38795 Marquette Way','Atlanta','GA','31196','7/30/2020'),
	('Pier','Dagwell','859-623-2528','152 Michigan Parkway','Lexington','KY','40515',''),
	('Skippie','Krauze','330-482-2143','4 Sundown Point','Youngstown','OH','44511','11/29/2021'),
	('Christalle','Guillond','551-629-6614','227 Victoria Drive','Jersey City','NJ','07310','7/3/2020'),
	('Howie','Stokell','337-987-3588','44 Vahlen Avenue','Lafayette','LA','70505','12/10/2020'),
	('Sidoney','Dugald','757-153-5398','040 Evergreen Center','Newport News','VA','23612','3/23/2021'),
	('Guillemette','Enden','713-559-6046','9415 Pond Place','Houston','TX','77020','2/12/2022'),
	('Jo','Hemmingway','713-730-6745','8030 Amoth Crossing','Houston','TX','77240','12/28/2020'),
	('Neall','Robatham','816-635-9493','0538 Annamark Circle','Kansas City','KS','66112','3/27/2020'),
	('Joycelin','Waszczyk','423-826-2345','9178 Chinook Center','Kingsport','TN','37665','10/1/2021'),
	('Thoma','Housden','562-787-0664','9 Cherokee Drive','Long Beach','CA','90840','2/25/2021'),
	('Hyacintha','Lemonby','915-870-3612','02 Paget Court','El Paso','TX','88519','12/10/2020'),
	('Pebrook','Dethloff','719-817-5905','8 Erie Plaza','Pueblo','CO','81005',''),
	('Burke','Pilling','843-369-2696','15 Sunbrook Park','Beaufort','SC','29905','6/20/2021');





INSERT INTO DenverFoodBank.dbo.Item
	([Name], Category, [Type])
VALUES
	('Pepper - Green','Produce','Each'),
	('Bar - Granola Mix','Snack','Case'),
	('Crab - Dungeness, Whole','Meat','Raw'),
	('Bar Mix - Lemon','Snack','Case'),
	('Dc Hikiage Hira Huba','Produce','Each'),
	('Bread - White Baguette','Deli','Each'),
	('Nori Sea Weed - Gold','Snack','Package'),
	('Chocolate - Pistoles, White','Snack','Package'),
	('Lettuce - Organic','Produce','Each'),
	('Beans - Black Bean, Dry','Prepackaged','Each'),
	('Brocolinni - Gaylan, Chinese','Produce','Each'),
	('Miso - Soy Bean Paste','Prepackaged','Package'),
	('Potato - Sweet','Produce','Each'),
	('Red Pepper Paste','Prepackaged','Package'),
	('Fish - Scallops, Cold Smoked','Meat','Raw'),
	('Energy Drink Red Bull','Drink','Can'),
	('Veal - Kidney','Meat','Raw'),
	('Pepsi - Diet, 355 Ml','Drink','Can'),
	('Capers - Ox Eye Daisy','Prepackaged','Package'),
	('Radish','Produce','Each'),
	('7up Diet, 355 Ml','Drink','Can'),
	('Muffin Batt - Choc Chk','Snack','Package'),
	('Pasta - Orzo, Dry','Prepackaged','Package'),
	('Honey - Liquid','Prepackaged','Package'),
	('Cake - Choclate','Snack','Each'),
	('Pork - Belly Fresh','Meat','Raw'),
	('Kiwi','Produce','Each'),
	('Oven Mitt - 13 Inch','Tool','Each'),
	('Beef - Kindney, Whole','Meat','Raw'),
	('Puree - Guava','Prepackaged','Package'),
	('Wine - Cotes Du Rhone','Alcohol','Bottle'),
	('Wine - Beaujolais Villages','Alcohol','Bottle'),
	('Stock - Veal, White','Meat','Raw'),
	('Veal - Inside, Choice','Meat','Raw'),
	('Shrimp - 100 / 200 Cold Water','Meat','Raw'),
	('Venison - Boneless','Meat','Raw'),
	('Wine - Wyndham Estate Bin 777','Alcohol','Bottle'),
	('Lettuce - Radicchio','Produce','Each'),
	('Lobster - Cooked','Meat','Package'),
	('Sauce - Demi Glace','Prepackaged','Package'),
	('Assorted Desserts','Snack','Package'),
	('Appetizer - Brie','Snack','Package'),
	('Pie Filling - Cherry','Snack','Package'),
	('Barramundi','Meat','Raw'),
	('Fennel','Produce','Each'),
	('Pesto - Primerba, Paste','Prepackaged','Package'),
	('Berry Brulee','Prepackaged','Package'),
	('Puree - Kiwi','Prepackaged','Package'),
	('Oranges - Navel, 72','Produce','Each'),
	('Bananas','Produce','Each');


INSERT INTO DenverFoodBank.dbo.Warehouse
	(Street, City, [State], ZipCode)
VALUES
	('39 Logan Circle','Grand Junction','CO','81505'),
	('54860 Bartillon Trail','Denver','CO','80235'),
	('10 Raven Road','Aurora','CO','80045'),
	('6959 Huxley Terrace','Denver','CO','80279');

INSERT INTO DenverFoodBank.dbo.Donation
	(DonorID, ItemNum, Quantity, WarehouseNum, [Date])
VALUES
	('18','5','94','2','2/6/2022'),
	('40','23','11','4','5/25/2021'),
	('7','12','45','1','12/11/2021'),
	('13','47','86','2','1/3/2021'),
	('27','13','25','4','8/3/2021'),
	('47','50','80','2','11/29/2021'),
	('15','42','5','1','2/13/2021'),
	('45','17','80','3','9/25/2021'),
	('49','6','26','4','6/19/2021'),
	('30','8','7','2','2/16/2022'),
	('28','49','49','1','7/2/2021'),
	('35','39','97','2','2/13/2021'),
	('2','45','14','1','7/2/2021'),
	('18','5','39','2','5/3/2021'),
	('38','9','98','2','7/19/2021'),
	('16','18','45','4','1/16/2022'),
	('28','24','62','3','8/5/2021'),
	('34','15','59','2','2/7/2021'),
	('1','49','56','1','10/8/2021'),
	('37','15','23','2','3/11/2021'),
	('17','23','51','3','3/10/2021'),
	('6','9','56','1','1/25/2022'),
	('16','2','74','3','8/19/2021'),
	('50','45','82','1','2/1/2021'),
	('42','15','32','4','7/18/2021'),
	('12','8','33','3','2/14/2021'),
	('12','15','55','3','8/20/2021'),
	('37','26','14','1','7/9/2021'),
	('32','6','64','1','2/17/2021'),
	('43','42','15','3','7/19/2021'),
	('28','8','63','4','8/10/2021'),
	('44','4','24','3','3/3/2021'),
	('27','33','6','3','10/31/2021'),
	('21','35','74','4','10/25/2021'),
	('8','19','67','3','4/12/2021'),
	('26','29','40','2','7/27/2021'),
	('39','8','30','2','4/30/2021'),
	('35','49','68','1','4/9/2021'),
	('27','36','47','2','2/18/2022'),
	('24','44','95','1','7/3/2021'),
	('36','4','27','3','5/17/2021'),
	('40','31','35','4','6/7/2021'),
	('16','7','50','2','3/8/2021'),
	('8','11','25','4','12/28/2021'),
	('22','21','97','1','10/2/2021'),
	('44','22','44','3','4/21/2021'),
	('3','46','46','4','11/5/2021'),
	('28','23','16','2','2/7/2021'),
	('35','14','12','3','4/16/2021'),
	('1','17','70','1','11/25/2021');


INSERT INTO DenverFoodBank.dbo.WarehouseInventory
	(WarehouseNum, ItemNum, Quantity)
VALUES
	('3','37','23'),
	('2','45','47'),
	('4','10','82'),
	('3','45','45'),
	('3','42','83'),
	('4','13','32'),
	('4','11','63'),
	('2','26','12'),
	('1','41','67'),
	('3','10','30'),
	('4','20','99'),
	('2','2','85'),
	('2','8','34'),
	('1','20','2'),
	('4','31','81'),
	('2','41','65'),
	('4','38','71'),
	('1','44','77'),
	('2','11','77'),
	('4','12','64'),
	('2','32','76'),
	('3','35','93'),
	('1','27','33'),
	('2','6','27'),
	('3','38','16'),
	('2','39','12'),
	('4','43','46'),
	('2','42','96'),
	('3','43','48'),
	('4','8','24'),
	('1','42','95'),
	('4','35','89'),
	('3','17','57'),
	('2','27','99'),
	('1','45','80'),
	('2','24','47'),
	('1','5','91'),
	('4','1','37'),
	('4','50','14'),
	('3','11','2'),
	('1','4','79'),
	('2','12','35'),
	('4','16','48'),
	('1','14','37'),
	('3','40','43'),
	('2','18','14'),
	('4','36','83'),
	('2','31','95'),
	('1','13','32'),
	('3','1','2');


INSERT INTO DenverFoodBank.dbo.Storefront
	(Street, City, [State], ZipCode)
VALUES
	('13 North Drive','Greeley','CO','80638'),
	('6716 Porter Plaza','Colorado Springs','CO','80951'),
	('15 Meadow Valley Street','Denver','CO','80123'),
	('781 Mcbride Plaza','Boulder','CO','80328'),
	('25 Del Mar Trail','Arvada','CO','80005'),
	('71 Carey Street','Littleton','CO','80126');


INSERT INTO DenverFoodBank.dbo.StorefrontInventory
	(StoreNum, ItemNum, Quantity)
VALUES
	('1','1','64'),
	('2','2','58'),
	('3','3','9'),
	('4','4','25'),
	('5','5','39'),
	('6','6','1'),
	('1','7','70'),
	('2','8','51'),
	('3','9','40'),
	('4','10','90'),
	('5','11','73'),
	('6','12','52'),
	('1','13','26'),
	('2','14','46'),
	('3','15','14'),
	('4','16','73'),
	('5','17','3'),
	('6','18','68'),
	('1','19','27'),
	('2','20','17'),
	('3','21','80'),
	('4','22','45'),
	('5','23','34'),
	('6','24','21'),
	('1','25','55'),
	('2','26','12'),
	('3','27','93'),
	('4','28','72'),
	('5','29','3'),
	('6','30','48'),
	('1','31','73'),
	('2','32','2'),
	('3','33','52'),
	('4','34','77'),
	('5','35','51'),
	('6','36','22'),
	('1','37','8'),
	('2','38','18'),
	('3','39','25'),
	('4','40','23'),
	('5','41','38'),
	('6','42','41'),
	('1','43','89'),
	('2','44','92'),
	('3','45','53'),
	('4','46','82'),
	('5','47','41'),
	('6','48','2'),
	('1','49','37'),
	('2','50','23');


INSERT INTO DenverFoodBank.dbo.InventoryTransferLog
	(WarehouseNum, ItemNum, StoreNum, [Date])
VALUES
	('2','15','2','1/13/2022'),
	('3','29','5','5/28/2021'),
	('4','20','6','2/21/2022'),
	('1','48','3','11/18/2021'),
	('3','19','1','6/22/2021'),
	('4','32','4','11/5/2021'),
	('2','50','5','3/23/2021'),
	('1','1','4','4/15/2021'),
	('1','38','6','3/8/2021'),
	('2','24','3','12/30/2021'),
	('4','41','1','6/18/2021'),
	('3','44','2','2/27/2021'),
	('4','28','6','1/4/2021'),
	('1','10','2','4/8/2021'),
	('2','21','1','2/10/2022'),
	('3','6','5','9/12/2021'),
	('4','17','3','8/9/2021'),
	('1','14','4','11/18/2021'),
	('3','33','5','5/15/2021'),
	('2','26','1','1/16/2022'),
	('3','12','3','12/12/2021'),
	('1','25','6','12/2/2021'),
	('4','30','4','7/14/2021'),
	('2','8','2','11/15/2021'),
	('4','18','1','7/2/2021'),
	('2','49','4','2/21/2021'),
	('3','35','6','11/19/2021'),
	('1','9','2','8/24/2021'),
	('1','34','3','7/29/2021'),
	('2','11','5','5/22/2021'),
	('4','2','5','4/10/2021'),
	('3','27','2','9/17/2021'),
	('2','23','1','11/6/2021'),
	('1','40','6','2/11/2022'),
	('3','13','3','2/17/2022'),
	('4','7','4','9/21/2021'),
	('4','43','2','5/6/2021'),
	('1','5','4','2/23/2021'),
	('2','36','3','10/10/2021'),
	('3','37','1','1/31/2022'),
	('1','47','6','1/19/2021'),
	('3','3','5','2/10/2022'),
	('4','16','4','1/19/2022'),
	('2','46','3','9/6/2021'),
	('2','42','5','12/28/2021'),
	('4','31','6','5/11/2021'),
	('3','22','1','6/12/2021'),
	('1','45','2','2/24/2021'),
	('2','39','4','5/8/2021'),
	('1','4','3','9/21/2021');


INSERT INTO DenverFoodBank.dbo.Recipient
	(FirstName, LastName, Street, City, [State], ZipCode, PhoneNum)
VALUES
	('Franciska','McColgan','08 Hauk Trail','Aurora','CO','80015',''),
	('Glendon','Marle','1 Calypso Point','Boulder','CO','80328','303-719-7552'),
	('Helli','Monument','8038 Drewry Place','Denver','CO','80291','303-655-8554'),
	('Marlane','Forbes','48 Coleman Park','Colorado Springs','CO','80905',''),
	('Jorie','Echlin','774 Karstens Way','Boulder','CO','80305','303-483-1222'),
	('Sanderson','Crauford','00 Caliangt Trail','Colorado Springs','CO','80905','719-514-8765'),
	('Dorothy','MacCallester','05 Main Pass','Pueblo','CO','81005','719-467-8172'),
	('Marne','Christol','2 Lindbergh Trail','Aurora','CO','80044','303-724-8155'),
	('Beatrix','Bang','97 Bobwhite Way','Colorado Springs','CO','80925','719-855-6019'),
	('Noelle','Stollenberg','660 Barby Plaza','Denver','CO','80291','303-758-6741'),
	('Scott','Polley','056 Karstens Hill','Aurora','CO','80015','720-337-8429'),
	('Rollin','Birnie','5696 Dayton Court','Colorado Springs','CO','80940','719-664-4519'),
	('Prince','Gommey','7789 Artisan Court','Colorado Springs','CO','80915','719-818-3113'),
	('Janna','Dallmann','7 Truax Hill','Denver','CO','80255','303-730-1897'),
	('Wilfred','Georgeon','5 Cordelia Point','Arvada','CO','80005','303-331-2117'),
	('Minna','Brayford','81 Jenifer Avenue','Colorado Springs','CO','80951','719-929-7241'),
	('Saidee','Stobbie','7 Blackbird Pass','Denver','CO','80228','303-770-3992'),
	('Dede','Rosenzwig','12628 Dottie Court','Greeley','CO','80638','970-792-3561'),
	('Engelbert','Dielhenn','28890 Mendota Crossing','Denver','CO','80243','303-684-2912'),
	('Guenna','Busain','3170 Melrose Park','Boulder','CO','80310','303-533-6086'),
	('Theodosia','Gaynsford','089 Lakewood Gardens Alley','Denver','CO','80243','303-277-3961'),
	('Mercy','Wickmann','53 Killdeer Center','Denver','CO','80243','303-785-5221'),
	('Alyse','Lubomirski','20806 Larry Lane','Colorado Springs','CO','80945','719-872-3064'),
	('Brittni','Limpkin','90 Cottonwood Point','Denver','CO','80235','303-924-0451'),
	('Jefferson','Devenish','9428 Shasta Hill','Greeley','CO','80638','970-841-6701'),
	('Rogers','Tanton','73 Charing Cross Pass','Fort Collins','CO','80525','970-357-2326'),
	('Rriocard','Halloway','0040 Knutson Lane','Pueblo','CO','81010','719-596-9785'),
	('Marcile','Kerwen','1 Susan Center','Boulder','CO','80328','303-509-2707'),
	('Montague','Cheyney','0 Annamark Way','Colorado Springs','CO','80935','719-530-3845'),
	('Papageno','Yousef','298 Warrior Avenue','Fort Collins','CO','80525','970-723-9823'),
	('Brandy','Slaughter','331 Jenna Park','Denver','CO','80255',''),
	('Jerrilyn','Merrell','39 Thackeray Drive','Denver','CO','80279','303-735-4449'),
	('Regen','Stennes','0 Jenna Way','Littleton','CO','80126','720-192-4250'),
	('Gwenny','Lamminam','9 Randy Alley','Denver','CO','80291','303-437-3458'),
	('Kaye','Pailin','82267 La Follette Street','Denver','CO','80235','303-400-5360'),
	('Towney','Swaisland','9514 Kensington Center','Pueblo','CO','81010','719-237-3273'),
	('Idaline','Glenfield','9 Dryden Plaza','Colorado Springs','CO','80935','719-553-1899'),
	('Lacy','Alexsandrovich','7597 Sloan Lane','Boulder','CO','80328','303-912-7334'),
	('Aryn','Rapp','394 Saint Paul Terrace','Littleton','CO','80126','303-831-2661'),
	('Jarid','Haughton','2 Carpenter Parkway','Pueblo','CO','81015','719-425-5669'),
	('Shanan','Sammes','37465 Homewood Road','Denver','CO','80204','720-777-0205'),
	('Lothaire','Binnion','3423 Mockingbird Point','Arvada','CO','80005','303-356-9421'),
	('Danika','Simkin','476 Mifflin Lane','Littleton','CO','80126',''),
	('Nananne','Swindley','32769 Schlimgen Parkway','Denver','CO','80255','303-248-9242'),
	('Valeria','Cordle','53 Delaware Trail','Denver','CO','80279','303-927-4275'),
	('Sue','Leipnik','5 Lakewood Gardens Lane','Greeley','CO','80638','970-612-7794'),
	('Cyrus','Maylin','12133 Kinsman Terrace','Denver','CO','80299','720-753-5716'),
	('Abeu','Yea','105 Lawn Parkway','Fort Collins','CO','80525','970-728-3523'),
	('Tobin','Vallis','16171 Messerschmidt Place','Arvada','CO','80005','720-179-6014'),
	('Willy','Fassam','31 Havey Court','Denver','CO','80241','303-411-2599');


INSERT INTO DenverFoodBank.dbo.Withdrawal
	(RecipientID, ItemNum, [Date], StoreNum)
VALUES
	('30','41','1/30/2022','4'),
	('26','25','1/2/2022','2'),
	('12','35','10/15/2021','2'),
	('28','13','2/22/2021','3'),
	('9','46','3/6/2021','6'),
	('21','14','9/12/2021','4'),
	('46','20','9/11/2021','4'),
	('37','1','2/23/2021','1'),
	('23','44','5/27/2021','1'),
	('13','35','11/20/2021','5'),
	('41','6','12/16/2021','5'),
	('5','38','1/21/2022','2'),
	('13','39','7/20/2021','1'),
	('50','16','7/14/2021','5'),
	('47','3','6/1/2021','4'),
	('49','43','4/7/2021','5'),
	('30','47','9/11/2021','1'),
	('37','44','10/18/2021','3'),
	('49','44','2/12/2022','5'),
	('12','1','12/5/2021','1'),
	('47','10','10/30/2021','1'),
	('38','21','8/10/2021','5'),
	('7','35','1/19/2022','1'),
	('10','25','2/12/2022','2'),
	('36','28','5/7/2021','3'),
	('18','41','3/9/2021','4'),
	('47','5','6/29/2021','3'),
	('20','15','7/11/2021','4'),
	('32','48','6/1/2021','1'),
	('12','47','4/30/2021','3'),
	('17','12','6/16/2021','5'),
	('33','1','9/15/2021','2'),
	('2','15','12/19/2021','4'),
	('47','27','6/13/2021','2'),
	('23','12','10/29/2021','1'),
	('50','11','12/25/2021','4'),
	('30','8','12/2/2021','4'),
	('5','26','2/15/2022','3'),
	('4','30','6/17/2021','3'),
	('40','3','4/2/2021','4'),
	('47','27','7/10/2021','6'),
	('6','42','2/15/2022','5'),
	('25','1','6/20/2021','1'),
	('9','25','6/20/2021','2'),
	('38','36','11/9/2021','4'),
	('24','45','11/29/2021','6'),
	('49','46','5/11/2021','5'),
	('7','9','12/16/2021','2'),
	('37','41','12/7/2021','1'),
	('45','4','7/3/2021','3');


INSERT INTO DenverFoodBank.dbo.Employee
	(FirstName, LastName, Position, HourlyRate, SSN, HireDate, TerminationDate, PhoneNum, Email, Street, City, [State], ZipCode)
VALUES
	('Lincoln','Klimentyev','General Manager', 25.50, '382-29-3428','10/27/2021',NULL,'303-338-7661','lklimentyev0@hao123.com','989 Jenna Terrace','Aurora','CO','80044'),
	('Daria','Donnison','Administrative Assistant II', NULL,'152-93-4786','1/23/2019',NULL,'720-104-5535','ddonnison1@oakley.com','1 Meadow Vale Circle','Denver','CO','80235'),
	('Diego','Traviss','Recruiter', NULL,'848-10-6610','10/8/2021',NULL,'719-901-2853','dtraviss2@washingtonpost.com','29 Doe Crossing Plaza','Colorado Springs','CO','80951'),
	('Aurel','Jolliffe','Staff Accountant II', NULL,'857-82-1109','5/24/2020',NULL,'303-562-4220','ajolliffe3@blogtalkradio.com','434 Continental Alley','Denver','CO','80299'),
	('Elladine','Gerrels','Research Nurse', NULL,'474-07-5605','9/1/2020',NULL,'719-131-3636','egerrels4@altervista.org','5880 Dahle Lane','Pueblo','CO','81015'),
	('Wyatt','Sciusscietto','Biostatistician II', 15.00,'796-57-9406','10/20/2020',NULL,'303-148-5799','wsciusscietto5@statcounter.com','2624 Packers Crossing','Aurora','CO','80015'),
	('Tiffany','Withringten','Director of Sales', 17.25,'169-69-8802','5/5/2019',NULL,'719-786-1375','twithringten6@mozilla.com','5 Warner Lane','Colorado Springs','CO','80995'),
	('Wilma','Feasey','Quality Engineer', 15.00,'746-14-5824','3/20/2019',NULL,'720-897-6908','wfeasey7@altervista.org','810 Victoria Road','Littleton','CO','80126'),
	('Kimbell','Giraux','Project Manager', NULL,'420-79-6078','3/31/2020',NULL,'970-952-6454','kgiraux8@soundcloud.com','073 East Street','Fort Collins','CO','80525'),
	('Boyd','OCridigan','Civil Engineer', NULL,'403-42-0749','4/24/2021',NULL,'719-308-6073','bocridigan9@booking.com','44254 Valley Edge Alley','Pueblo','CO','81015'),
	('Leanna','Mallan','Physical Therapy Assistant', 16.25,'288-23-7377','5/8/2019',NULL,'303-179-5862','lmallana@lulu.com','87714 Gulseth Trail','Aurora','CO','80044'),
	('Corissa','Yanukhin','Automation Specialist II', NULL,'511-07-6163','6/4/2020','6/18/2020','719-815-9046','cyanukhinb@yahoo.co.jp','7 Logan Court','Colorado Springs','CO','80930'),
	('Krista','Mattheus','Assistant Manager', 17.00,'198-96-1218','8/19/2021',NULL,'720-147-5568','kmattheusc@theguardian.com','40060 Pleasure Avenue','Littleton','CO','80161'),
	('Vickie','Aspinall','Health Coach I', NULL,'855-67-7556','1/7/2020',NULL,'303-713-8652','vaspinalld@ftc.gov','857 Coolidge Center','Boulder','CO','80328'),
	('Maryl','Bridgeman','Teacher', NULL,'736-99-8290','5/8/2019',NULL,'719-999-3413','mbridgemane@last.fm','8492 Golf Course Lane','Colorado Springs','CO','80945'),
	('Myrwyn','Lillyman','Database Administrator IV', NULL,'234-81-2637','2/7/2019',NULL,'719-954-8875','mlillymanf@sogou.com','6 Westridge Place','Colorado Springs','CO','80925'),
	('Ardath','Notley','Account Executive', 19.50,'556-34-2759','7/18/2019','6/15/2021','303-771-5873','anotleyg@tripadvisor.com','96709 Kipling Center','Denver','CO','80279'),
	('Burtie','Hannigan','Assistant Manager', NULL,'108-03-2051','9/9/2021',NULL,'719-555-6550','bhanniganh@flavors.me','6023 Fulton Junction','Colorado Springs','CO','80940'),
	('Barron','Hedon','Account Executive', NULL,'417-03-7695','10/25/2019','9/25/2020','720-739-2978','bhedoni@army.mil','40933 Bluejay Crossing','Denver','CO','80209'),
	('Demeter','Jouanot','Database Administrator I', NULL,'345-49-1415','10/28/2021',NULL,'303-514-5241','djouanotj@noaa.gov','76357 Lawn Lane','Denver','CO','80235'),
	('Conroy','Nickerson','Junior Executive', 20.00,'749-01-4883','2/25/2021',NULL,'303-255-3148','cnickersonk@seesaa.net','8 Petterle Lane','Littleton','CO','80161'),
	('Jordanna','Baggelley','Paralegal', NULL,'796-23-0947','11/4/2020',NULL,'303-184-9010','jbaggelleyl@cdbaby.com','626 Arapahoe Street','Denver','CO','80299'),
	('Roddy','Alabaster','Web Developer II', NULL,'645-94-6079','6/11/2021',NULL,'303-858-7751','ralabasterm@newsvine.com','1 Springs Alley','Denver','CO','80217'),
	('Tarrah','Ceaser','Structural Engineer', 16.50,'521-14-0051','7/12/2020',NULL,'720-997-2051','tceasern@goo.gl','6311 Waywood Park','Aurora','CO','80015'),
	('Piotr','Doncom','Human Resources Manager', NULL,'515-58-4469','3/12/2020','11/11/2021','719-155-2166','pdoncomo@flickr.com','1990 Coleman Point','Colorado Springs','CO','80945');





INSERT INTO DenverFoodBank.dbo.Timesheet
	(EmployeeID, [Date], HoursWorked)
VALUES
	('25','12/6/2021','5.78'),
	('5','2/20/2021','3.53'),
	('7','12/4/2021','1.33'),
	('5','9/24/2021','6.14'),
	('13','6/21/2021','5.13'),
	('11','5/29/2021','6.33'),
	('23','1/4/2021','6.44'),
	('19','5/12/2021','4.68'),
	('13','11/13/2021','3.09'),
	('11','2/14/2021','0.78'),
	('6','3/31/2021','4.76'),
	('1','10/28/2021','7.59'),
	('6','3/8/2021','5.37'),
	('17','3/6/2021','4.43'),
	('5','9/3/2021','5.44'),
	('2','4/4/2021','5.6'),
	('19','10/11/2021','3.13'),
	('24','12/4/2021','0.61'),
	('25','4/26/2021','5.27'),
	('8','6/14/2021','4.08'),
	('8','7/16/2021','2.67'),
	('24','10/8/2021','6.82'),
	('6','4/27/2021','6.3'),
	('24','10/24/2021','4.33'),
	('13','6/19/2021','7.29'),
	('16','10/28/2021','6.33'),
	('21','9/10/2021','5.19'),
	('6','10/13/2021','0.62'),
	('13','4/28/2021','7.11'),
	('21','1/16/2021','2.56'),
	('4','6/12/2021','6.99'),
	('25','1/19/2021','7.6'),
	('13','6/15/2021','1.78'),
	('17','6/12/2021','6.23'),
	('12','10/29/2021','5.17'),
	('23','8/21/2021','1.16'),
	('12','7/30/2021','5.19'),
	('9','2/16/2021','3.54'),
	('21','10/10/2021','5.42'),
	('10','7/20/2021','6.24'),
	('20','4/3/2021','6.75'),
	('8','5/6/2021','7.64'),
	('5','3/22/2021','5.9'),
	('4','5/31/2021','7.49'),
	('13','9/13/2021','5.17'),
	('12','9/20/2021','4.32'),
	('7','8/19/2021','1.52'),
	('2','9/20/2021','5.2'),
	('16','12/9/2021','1.63'),
	('9','6/20/2021','7.23');
	



--Here is where we create the Stored Procedures the business will use to query the database.  
--Note, I am adding in sample usages of the SP afterword, commented out, that can be uncommented to test them quickly.

/*
Stored Procedure #1: Donations by Donor.  This will allow the user to query the database and see how many donations each donor has provided,
ranking the donors in descending order based on the amount of times they have donated.  Being a charity, relationships with those who support you
are incredibly valuable.  By tracking the larger donors, the organization will be able to continue to build and strengthen the relationships 
with those who help support them.
*/

CREATE PROCEDURE DonationsByDonor_sp
AS

/*----------------------------------------------------------------------
CREATED: February 27, 2022
AUTHOR: Matt Swann
DESCRIPTION: Used by The City of Denver Food Bank to list all the donations by each donor
and rank them based on total donation count.

Example: EXEC DonationsByDonor_sp

CHANGE HISTORY
Date				Modified By			Notes
2/27/2022			Matt Swann			Initial Creation
----------------------------------------------------------------------*/

SELECT		Dnr.DonorID, Dnr.FirstName, Dnr.LastName, COUNT(Dntn.DonationNum) AS TotalDonationCount
FROM		DenverFoodBank.dbo.Donation Dntn
INNER JOIN	DenverFoodBank.dbo.Donor Dnr
ON			Dnr.DonorID = Dntn.DonorID
GROUP BY	Dnr.DonorID, Dnr.FirstName, Dnr.LastName
ORDER BY	COUNT(Dntn.DonationNum) DESC;

GO

--EXEC DonationsByDonor_sp



/*
Stored Procedure #2: Withdrawal by Recipient.  Essentially the same as above but for recipients, we will allow users to track who is receiving the most amount
of food from the Food Bank
*/

CREATE PROCEDURE WithdrawalsByRecipient_sp
AS

/*----------------------------------------------------------------------
CREATED: February 27, 2022
AUTHOR: Matt Swann
DESCRIPTION: Used by The City of Denver Food Bank to list all the 
withdrawals taken out by each recipient, ranked from most to least.

Example: EXEC WithdrawalsByRecipient_sp

CHANGE HISTORY
Date				Modified By			Notes
2/27/2022			Matt Swann			Initial Creation
----------------------------------------------------------------------*/

SELECT		Rcp.RecipientID, Rcp.FirstName, Rcp.LastName, COUNT(Wtd.WithdrawalNum) AS TotalNumWithdrawals
FROM		DenverFoodBank.dbo.Withdrawal Wtd
INNER JOIN	DenverFoodBank.dbo.Recipient Rcp
ON			Wtd.RecipientID = Rcp.RecipientID
GROUP BY	Rcp.RecipientID, Rcp.FirstName, Rcp.LastName
ORDER BY	COUNT(Wtd.WithdrawalNum) DESC;

GO



--EXEC WithdrawalsByRecipient_sp


/*
Stored Procedure #3: Total Inventory.  This query will utilize a both a UNION and a sub-query to query both the Warehouse and Storefront Inventory tables,
and then combine them together to see the total inventory within the organization
*/

CREATE PROCEDURE TotalInventory_sp
AS

/*----------------------------------------------------------------------
CREATED: February 27, 2022
AUTHOR: Matt Swann
DESCRIPTION: Used by The City of Denver Food Bank to list all the total 
inventory count in it's combined warehouses and storefronts

Example: EXEC TotalInventory_sp

CHANGE HISTORY
Date				Modified By			Notes
2/27/2022			Matt Swann			Initial Creation
----------------------------------------------------------------------*/

SELECT			InvUnion.ItemNum, I.[Name], SUM(InvUnion.TotalInventoryCount) AS TotalQuantity
FROM			(SELECT		WI.ItemNum, SUM(WI.Quantity) AS TotalInventoryCount
					FROM		DenverFoodBank.dbo.WarehouseInventory WI
					GROUP BY	WI.ItemNum
					UNION
					SELECT		SI.ItemNum, SUM(SI.Quantity) AS TotalInventoryCount
					FROM		DenverFoodBank.dbo.StorefrontInventory SI
					GROUP BY	SI.ItemNum) AS InvUnion
LEFT OUTER JOIN	DenverFoodBank.dbo.Item I
ON				InvUnion.ItemNum = I.ItemNum
GROUP BY		InvUnion.ItemNum, I.[Name]
ORDER BY		InvUnion.ItemNum ASC;

GO

--EXEC TotalInventory_sp


/*
Stored Procedure #4: Insert new Donor into Donor Table.  Of course, businesses will always be adding new entries.  This allows the addition of a new Donor.
*/

CREATE PROCEDURE NewDonor_sp	@FirstName VARCHAR(30), @LastName VARCHAR(50), @PhoneNum CHAR(12), @Street VARCHAR(30), @City VARCHAR(30),
								@State CHAR(2), @ZipCode CHAR(5), @FirstDonationDate DATE
AS

/*----------------------------------------------------------------------
CREATED: February 27, 2022
AUTHOR: Matt Swann
DESCRIPTION: Used by The City of Denver Food Bank to add a new Donor
to its Donor table in the database.

Example: EXEC NewDonor_sp
			@FirstName = 'First Name',
			@LastName = 'Last Name',
			@PhoneNum = 'XXX-XXX-XXXX',
			@Street = '1234 Street Address',
			@City = 'City Name',
			@State = 'CO',
			@Zipcode = 'XXXXX',
			@FirstDonationDate = 'yyyy-mm-dd'
			--Note - If they have not donated yet, enter NULL

CHANGE HISTORY
Date				Modified By			Notes
2/27/2022			Matt Swann			Initial Creation
----------------------------------------------------------------------*/

INSERT INTO DenverFoodBank.dbo.Donor
			(FirstName,
			LastName,
			PhoneNum,
			Street,
			City,
			[State],
			ZipCode,
			FirstDonationDate)
VALUES
	(@FirstName,
	@LastName,
	@PhoneNum,
	@Street,
	@City,
	@State,
	@ZipCode,
	@FirstDonationDate);

GO

/*
EXEC NewDonor_sp
			@FirstName = 'First Name',
			@LastName = 'Last Name',
			@PhoneNum = '123-456-7890',
			@Street = '1234 Street Address',
			@City = 'City Name',
			@State = 'CO',
			@Zipcode = '12345',
			@FirstDonationDate = '2022-02-27';
*/

/* I Know using SELECT * is not allowed, but this is a simple statement I ran before / after this SP to ensure it works properly:

SELECT * FROM Donor
WHERE DonorID > 46
*/

/* Stored Procedure #5: Timesheet by Employee.  
This will allow the user to enter an EmployeeID and pull their Timesheet info */

CREATE PROCEDURE EmployeeTimesheet_sp @EID INT
AS

/*----------------------------------------------------------------------
CREATED: February 27, 2022
AUTHOR: Matt Swann
DESCRIPTION: Used by The City of Denver Food Bank to view the Timesheet
entries for an employee of their choosing.

Example: EXEC EmployeeTimesheet_sp
				@EID = EmployeeID

CHANGE HISTORY
Date				Modified By			Notes
2/27/2022			Matt Swann			Initial Creation
----------------------------------------------------------------------*/

SELECT		E.EmployeeID, E.FirstName, E.LastName, T.[Date], T.Hoursworked
FROM		DenverFoodBank.dbo.Employee E
INNER JOIN	DenverFoodBank.dbo.Timesheet T
ON			E.EmployeeID = T.EmployeeID
WHERE		E.EmployeeID = @EID;

GO

--EXEC EmployeeTimesheet_sp @EID = 11

/* Stored Procedure #6: Withdrawal by Storefront.  This will allow the user to pull up the total withdrawals by storefront in order to
see which storefront is receiving the most traffic, and which the least.
*/


CREATE PROCEDURE WithdrawalByStorefront_sp
AS
/*----------------------------------------------------------------------
CREATED: February 27, 2022
AUTHOR: Matt Swann
DESCRIPTION: Used by The City of Denver Food Bank to track total withdrawals
by Storefront.  It will also pull up the Store Number, as well as it's street 
address, city, and state for easier reference to location.

Example: EXEC WithdrawalByStorefront_sp

CHANGE HISTORY
Date				Modified By			Notes
2/27/2022			Matt Swann			Initial Creation
----------------------------------------------------------------------*/

SELECT		W.StoreNum, COUNT(W.StoreNum) AS TotalWithdrawalCount, SF.Street, SF.City, SF.[State]
FROM		DenverFoodBank.dbo.Withdrawal W
INNER JOIN	DenverFoodBank.dbo.Storefront SF
ON			W.StoreNum = SF.StoreNum
GROUP BY	W.StoreNum, SF.Street, SF.City, SF.[State];

GO

--EXEC WithdrawalByStorefront_sp


/* Stored Procedure #7: NewRecipient_sp
This SP functions similarly to the NewDonor_sp, but for adding new recipients instead
*/

CREATE PROCEDURE NewRecipient_sp	@FirstName VARCHAR(30), @LastName VARCHAR(50), @Street VARCHAR(30), @City VARCHAR(30),
									@State CHAR(2), @ZipCode CHAR(5), @PhoneNum CHAR(12)
AS

/*----------------------------------------------------------------------
CREATED: February 27, 2022
AUTHOR: Matt Swann
DESCRIPTION: Used by The City of Denver Food Bank to add a new Recipient
to its Recipient table in the database.

Example: EXEC NewDonor_sp
			@FirstName = 'First Name',
			@LastName = 'Last Name',
			@Street = '1234 Street Address',
			@City = 'City Name',
			@State = 'CO',
			@Zipcode = 'XXXXX',
			@PhoneNum = 'XXX-XXX-XXXX'
			--Note - NULL values may be enetered for all address and phone number information

CHANGE HISTORY
Date				Modified By			Notes
2/27/2022			Matt Swann			Initial Creation
----------------------------------------------------------------------*/

INSERT INTO DenverFoodBank.dbo.Recipient
			(FirstName,
			LastName,
			Street,
			City,
			[State],
			ZipCode,
			PhoneNum)
VALUES
	(@FirstName,
	@LastName,
	@Street,
	@City,
	@State,
	@ZipCode,
	@PhoneNum);

GO

/*
EXEC NewRecipient_sp
			@FirstName = 'First Name',
			@LastName = 'Last Name',
			@Street = '1234 Street Address',
			@City = 'City Name',
			@State = 'CO',
			@Zipcode = '12345',
			@PhoneNum = NULL;
*/

/*
SELECT	*
FROM	DenverFoodBank.dbo.Recipient
WHERE	RecipientID > 48
*/


/* Stored Procedure #8: EmployeeTotalHoursWorked_sp
This Stored Procedure will list the total hours worked by each employee.  This can be used for workload planning and employee appreciation.
*/

CREATE PROCEDURE EmployeeTotalHoursWorked_sp
AS

/*----------------------------------------------------------------------
CREATED: February 27, 2022
AUTHOR: Matt Swann
DESCRIPTION: Used by The City of Denver Food Bank list the total hours worked
by each employee in a summed value.

Example: EXEC EmployeeTotalHoursWorked_sp

CHANGE HISTORY
Date				Modified By			Notes
2/27/2022			Matt Swann			Initial Creation
----------------------------------------------------------------------*/

SELECT		E.EmployeeID, CONCAT(E.FirstName, ' ', E.LastName) AS EmploeeName, SUM(TS.HoursWorked) AS TotalHoursWorked
FROM		DenverFoodBank.dbo.Employee E
INNER JOIN	DenverFoodBank.dbo.Timesheet TS
ON			E.EmployeeID = TS.EmployeeID
GROUP BY	E.FirstName, E.LastName, E.EmployeeID;

GO

--EXEC EmployeeTotalHoursWorked_sp


--Now, User Defined Functions

/* UDF #1: Are employees paid or volunteers?
Being a non-profit, the Food Bank has primarily volunteers as employees.  However, some people are paid.  
This function will allow users to determine whether an employee is paid or a volunteer.
This function will also be used in a view later in order for other employees to not be able to see their coworkers pay, where applicable
*/

CREATE FUNCTION	 dbo.fnEmployeeType
				 (@HourlyRate SMALLMONEY)
RETURNS VARCHAR(50)
AS

BEGIN
	DECLARE @Answer VARCHAR(50);

	SELECT	@Answer = CASE
					WHEN @HourlyRate IS NOT NULL THEN 'This employee is a paid employee'
					ELSE 'This is a volunteer employee'
					END
	FROM	DenverFoodBank.dbo.Employee
	RETURN @Answer
END


/* 
Now we create views 
*/

/*
View #1: CurrentEmployeeList_vw

This provides an employee list providing all the necesarry information about a current employee that other employees may need in order to know that employees info.
However, it protects sensitive information such as SSN, hourly rate and street address and keeps that confidential. 
*/

CREATE VIEW dbo.CurrentEmployeeList_vw

AS

SELECT		E.EmployeeID, E.FirstName, E.LastName, E.Position, E.HireDate, E.PhoneNum, E.Email, dbo.fnEmployeeType(HourlyRate) AS EmployeeType
FROM		DenverFoodBank.dbo.Employee E
WHERE		E.TerminationDate IS NULL;

/*
SELECT	*
FROM	dbo.CurrentEmployeeList_vw
*/

/*
View #2: PastEmployeeList_vw

This provides an employee list providing all the necesarry information about a past employee that other employees may need in order to know that employees info.
However, it protects sensitive information such as SSN, hourly rate and street address and keeps that confidential. 
*/

CREATE VIEW dbo.PastEmployeeList_vw

AS

SELECT		E.EmployeeID, E.FirstName, E.LastName, E.Position, E.HireDate, E.TerminationDate, E.PhoneNum, E.Email, dbo.fnEmployeeType(HourlyRate) AS EmployeeType
FROM		DenverFoodBank.dbo.Employee E
WHERE		E.TerminationDate IS NOT NULL;

/*
SELECT	* 
FROM	dbo.PastEmployeeList_vw
*/




/*
View #3: Donation View by Donor
This provides an itemized list into each donation by each donor, ordered by donor.
This allows to see multiple donations by each donor
*/

CREATE VIEW dbo.DonationsByDonor_vw
AS

SELECT			Dn.ItemNum, Dn.Quantity, I.[Type], I.[Name] AS ItemName, D.FirstName, D.LastName
FROM			DenverFoodBank.dbo.Donation Dn
LEFT OUTER JOIN	DenverFoodBank.dbo.Item I
ON				Dn.ItemNum = I.ItemNum
LEFT OUTER JOIN	DenverFoodBank.dbo.Donor D
ON				Dn.DonorID = D.DonorID;

/*
SELECT		* 
FROM		DonationsByDonor_vw 
ORDER BY	FirstName, LastName
*/

