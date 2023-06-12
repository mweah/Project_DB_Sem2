CREATE DATABASE VadidasDB
GO
USE VadidasDB
GO

-- Create database system (no 2)
-- Table MsStaff 
CREATE TABLE MsStaff (
    StaffID CHAR (5) PRIMARY KEY CHECK (StaffID LIKE 'ST[0-9][0-9][0-9]') NOT NULL,
    StaffName VARCHAR (50) NOT NULL,
    StaffGender VARCHAR (10) NOT NULL,
    StaffEmail VARCHAR (50) NOT NULL,
    StaffAddress VARCHAR (50) NOT NULL,
    StaffSalary INT NOT NULL,
)

-- Table MsVendor
CREATE TABLE MsVendor (
    VendorID CHAR (5) PRIMARY KEY CHECK (VendorID LIKE 'VE[0-9][0-9][0-9]') NOT NULL,
    VendorName VARCHAR (50) NOT NULL,
    VendorEmail VARCHAR (50) NOT NULL,
    VendorAddress VARCHAR (50) NOT NULL,
    VendorPhoneNumber INT NOT NULL,
)

-- Table MsCustomer
CREATE TABLE MsCustomer (
    CustomerID CHAR (5) PRIMARY KEY CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]') NOT NULL,
    CustomerName VARCHAR (50) NOT NULL,
    CustomerGender VARCHAR (10) NOT NULL,
    CustomerDOB DATE NOT NULL,
    CustomerAddress VARCHAR (50) NOT NULL,
    CustomerEmail VARCHAR(50) NOT NULL,
)

-- Table MsShoes
CREATE TABLE MsShoes (
	ShoesID CHAR(5) PRIMARY KEY CHECK (ShoesID LIKE 'SH[0-9][0-9][0-9]') NOT NULL,
	ShoesName VARCHAR(50) NOT NULL,
	ShoesPrice INT NOT NULL,
	ShoesDescription VARCHAR (255) NOT NULL
)

-- PurchaseHeader
CREATE TABLE PurchaseHeader (
	PurchaseID CHAR(5) PRIMARY KEY CHECK (PurchaseID LIKE 'PU[0-9][0-9][0-9]') NOT NULL,
	StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	VendorID CHAR(5) FOREIGN KEY REFERENCES MsVendor(VendorID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	PurchaseDate DATE NOT NULL
)

-- PurchaseDetail
CREATE TABLE PurchaseDetail(
	PurchaseID CHAR(5) FOREIGN KEY REFERENCES PurchaseHeader(PurchaseID)  ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	ShoesID CHAR(5) FOREIGN KEY REFERENCES MsShoes(ShoesID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	Quantity INT NOT NULL
	PRIMARY KEY(PurchaseID, ShoesID)
)

-- TransactionHeader
CREATE TABLE Transactionheader (
	TransactionID CHAR(5) PRIMARY KEY CHECK(TransactionID LIKE 'TR[0-9][0-9][0-9]') NOT NULL,
	StaffID CHAR(5) FOREIGN KEY REFERENCES MsStaff(StaffID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	CustomerID CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	TransactionDate DATE NOT NULL
)

-- TransactionDetail
CREATE TABLE TransactionDetail (
	TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	ShoesID CHAR(5) FOREIGN KEY REFERENCES MsShoes(ShoesID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	Quantity INT NOT NULL,
	PRIMARY KEY (TransactionID, ShoesID)
)

-- CONSTRAINTS (no 2)

ALTER TABLE MsVendor
ADD CONSTRAINT Check_Email CHECK(VendorEmail LIKE '%@gmail.com')

ALTER TABLE MsStaff
ADD CONSTRAINT Check_LEN CHECK(LEN(StaffName) > 10)

ALTER TABLE MsStaff
ADD CONSTRAINT Check_Gender CHECK(StaffGender IN ('Male', 'Female'))

ALTER TABLE MsStaff
ADD CONSTRAINT Check_Salary CHECK(StaffSalary BETWEEN 120000 AND 500000)

ALTER TABLE MsCustomer
ADD CONSTRAINT Check_Cust_LEN CHECK (LEN(CustomerName) > 10)

ALTER TABLE MsCustomer
ADD CONSTRAINT Check_Cust_Gender CHECK (CustomerGender IN('Male', 'Female'))

ALTER TABLE MsCustomer
ADD CONSTRAINT Check_Cust_Email CHECK(CustomerEmail LIKE '%@gmail.com')

ALTER TABLE MsCustomer
ADD CONSTRAINT Check_Cust_Age CHECK(DATEDIFF(YEAR, CustomerDOB, GETDATE()) >=17)
-- INSERT DATA (no 3)

-- MsTable
-- MsCustomer
INSERT INTO MsCustomer VALUES
('CU001','Andika Teriawan','Male','1997-04-11','Jl KH Fachrudin 4, Dki Jakarta','andikat97@gmail.com'),
('CU002','Matthew Saputra','Male','2000-01-22',' Jl Letjen Jamin Ginting 96','ucoks01@gmail.com'),
('CU003','Josap Airlangga','Male','1999-03-04','Jl Jeruk Nipis 8','josair96@gmail.com'),
('CU004','Yohana Hasanah','Female','2001-09-12','Jl Daan Mogot I 25','yohahaha1@gmail.com'),
('CU005','Vivi Wulandari','Female','1993-08-17','Jl R Suprapto/21 A','wulan93@gmail.com'),
('CU006','Baktiadi Sirait','Male','1988-02-27','Jl Mangga II 8 M','baktiadab@gmail.com'),
('CU007','Danu Thamrin','Male','2000-04-13','Jl H Naim/24 B','thamrindan@gmail.com'),
('CU008','Ucok Zulkarnain','Male','1997-05-22','Jl Panti Wreda Kel Ceger','ucokzul97@gmail.com'),
('CU009','Anastasia Susanti','Female','2002-04-12','Jl Anggrek Cendrawasih Bl K/21','susan0204@gmail.com'),
('CU010','Yani Suartini','Female','1996-11-28','Jl Kayu Putih 6B/11','suarmercon30@gmail.com')

--MsStaff
INSERT INTO MsStaff VALUES
('ST001','Diah Rahayu','Female','diahrayu@gmail.com','Jl Pemuda Asli/11','320000'),
('ST002','Kenari Ardianto','Male','kenArokardianto@gmail.com','Jl Penataran 9','295000'),
('ST003','Nardi Budiyanto','Male','nardi.lega@gmail.com','Jl Ki. Raden No 83','315000'),
('ST004','Lalita Rahmawati','Female','laras.kusma04@gmail.com','Jl Raya Bekasi Km22/58','270000'),
('ST005','Daryani Wahyudi','Male','darwayudi@gmail.com','Jl Minangkabau Dlm, II 21','410000'),
('ST006','Puji Nurdiyanti','Female','punurdiyanti@gmail.com','Jl Kecubung RT002/09 No 3','300000'),
('ST007','Azalea Zulaika','Female','azapradipta@gmail.com','Komplek Roxy Max B E-2/48','475000'),
('ST008','Salsabila Namaga','Female','salnamaga20@gmail.com','Jl Hayam Wuruk 108','400000'),
('ST009','Perkasa Saputra','Male','poetraperkasa@gmail.com','Jl Hayam Wuruk Glodok B No 62','480000'),
('ST010','Rizki Hidayat','Male','riskihidayat72@gmail.com','Jl Empu Sendok 30','350000')

--MsVendor
INSERT INTO MsVendor VALUES
('VE001','Bakti Wacana','wacanaandri123@gmail.com','Jl Surya Kencana 24','089670301'),
('VE002','Prayoga Kurniawan','prakurni2021@gmail.com','Jl Cendrawasih 23','0852173230'),
('VE003','Daniswara Halim','danisbijak04@gmail.com','Gg.Yohanes No. 378','0812954566'),
('VE004','Klarita Nasyiah','klaritanasyiah03@gmail.com','Jl Bukit Duri Tanjakan 53','081375087'),
('VE005','Leonard Yaputro','leonardtar@gmail.com','Jl Agus Salim No. 532','0811861689'),
('VE006','Novena Halimah','novenalim96@gmail.com','Jl Warakas 5','0812130175'),
('VE007','Fitri Anggriani','Fitrianggrek@gmail.com','Jl Kwitang Raya 8','0878827453'),
('VE008','Markus Widodo','markuswodo@gmail.com','Jl Medan Merdeka Slt 12','0852710064'),
('VE009','Eko Setiawan','ekoekoeko4@gmail.com','Jl Mayjen Dl Panjaitan 45','0821705560'),
('VE010','Bagas Simbolon','simbolonbagas88@gmail.com','Jl KH Wahi Hasyim 89','0855720042')

-- MsShoes
INSERT INTO MsShoes VALUES
('SH001','Naiki Peels','959000','size: 41 - 44. Color: all available except purple'),
('SH002','Idadis Ultra','1600000','size: 38 - 44. Color: red & blue'),
('SH003','EsrevnoC','799000','size: 35 - 46. Color: white, gray, blue'),
('SH004','Puma Tiger','800100','size: 38 only. Color: purple'),
('SH005','Gussi Air','1400000','size: 42 - 45. Color: blue, white, gray, red'),
('SH006','Homey Ped','350000','size: 14 - 24 (kid shoes). Color: red, green, yellow, blue'),
('SH007','Jordan Ground','1200000','size: 35 - 48. Color: white, gray, blue, yellow'),
('SH008','Roobek','999900','size: 35 - 43. Color: magenta, pink, yellow, purple'),
('SH009','Ketchers','1150000','size: 42 - 48. Color: white, black'),
('SH010','Treewater','699000','size: 36 - 41. Color: black, gray, brown')

--PurchaseHeader
INSERT INTO PurchaseHeader VALUES
('PU001','ST002','VE001','2019-12-31'),
('PU002','ST002','VE003','2020-01-03'),
('PU003','ST010','VE009','2020-01-18'),
('PU004','ST001','VE003','2020-02-12'),
('PU005','ST003','VE002','2020-03-28'),
('PU006','ST004','VE007','2020-04-10'),
('PU007','ST001','VE010','2020-04-22'),
('PU008','ST005','VE006','2020-05-22'),
('PU009','ST007','VE004','2020-06-18'),
('PU010','ST004','VE010','2020-07-21'),
('PU011','ST006','VE008','2020-08-17'),
('PU012','ST004','VE001','2020-09-29'),
('PU013','ST002','VE007','2020-10-28'),
('PU014','ST010','VE005','2020-11-11'),
('PU015','ST003','VE005','2020-12-25')

--PurchaseDetail
-- ('PurchaseID', 'ShoesID', 'Quantity')
INSERT INTO PurchaseDetail VALUES
('PU001','SH003','30'),
('PU001','SH001','35'),
('PU002','SH010','64'),
('PU002','SH003','30'),
('PU002','SH009','50'),
('PU003','SH005','15'),
('PU003','SH002','16'),
('PU004','SH007','24'),
('PU004','SH004','6'),
('PU005','SH006','5'),
('PU005','SH005','10'),
('PU005','SH010','12'),
('PU006','SH008','42'),
('PU007','SH008','18'),
('PU008','SH001','35'),
('PU008','SH009','15'),
('PU009','SH010','10'),
('PU010','SH006','20'),
('PU010','SH004','9'),
('PU011','SH006','25'),
('PU011','SH003','36'),
('PU012','SH007','12'),
('PU012','SH002','18'),
('PU013','SH001','15'),
('PU014','SH008','30'),
('PU014','SH004','19'),
('PU015','SH005','20')

--TransactionHeader
INSERT INTO Transactionheader VALUES
('TR001','ST001','CU002','2020-01-02'),
('TR002','ST002','CU003','2020-02-01'),
('TR003','ST003','CU005','2020-03-27'),
('TR004','ST004','CU002','2020-04-13'),
('TR005','ST005','CU001','2020-05-08'),
('TR006','ST008','CU006','2020-06-09'),
('TR007','ST009','CU003','2021-02-28'),
('TR008','ST006','CU004','2021-04-29'),
('TR009','ST008','CU010','2021-06-01'),
('TR010','ST001','CU008','2021-07-09'),
('TR011','ST002','CU007','2021-08-23'),
('TR012','ST004','CU004','2022-05-04'),
('TR013','ST005','CU010','2022-07-20'),
('TR014','ST002','CU001','2022-09-05'),
('TR015','ST010','CU005','2022-11-08')
 
 --TransactionDetail
INSERT INTO TransactionDetail VALUES
('TR001','SH002','3'),
('TR002','SH004','1'),
('TR003','SH005','3'),
('TR004','SH003','5'),
('TR005','SH007','7'),
('TR006','SH010','6'),
('TR007','SH001','9'),
('TR008','SH006','10'),
('TR009','SH008','12'),
('TR010','SH009','15'),
('TR011','SH005','26'),
('TR012','SH007','17'),
('TR013','SH008','18'),
('TR014','SH002','9'),
('TR015','SH005','3'),
('TR012','SH010','5'),
('TR013','SH006','27'),
('TR014','SH004','25'),
('TR015','SH009','21'),
('TR001','SH003','4'),
('TR002','SH002','21'),
('TR003','SH004','16'),
('TR004','SH001','12'),
('TR005','SH008','14'),
('TR006','SH006','17')

-- No 4 Simulate Transaction Process

-- simulate purchase process
-- Purchasing new type of shoes
INSERT INTO PurchaseHeader VALUES
('PU016','ST003','VE004','2021-01-15'),
('PU017','ST006','VE010','2021-02-20')
INSERT INTO PurchaseDetail VALUES
('PU016','SH011','40'),
('PU017','SH012','50')

INSERT INTO MsShoes VALUES
('SH011','Fanz','1400000','size: 40 - 48. Color: White & Black, Gray'),
('SH012','Old Imbalance','1100000','size: 35 - 48. Color: White & Blue, Black')

-- simulate transactions process
-- 1st part new customer
INSERT INTO MsCustomer VALUES 
('CU011','Totong Hulan','Male','1997-08-11','Jl Sunter Utara 5','Totongghulan12@gmail.com'),
('CU012','Mei Xiao Bao','Female','2000-02-12','Jl Asia Mega 6','Meixiao234@Gmail.com')

-- 2nd part the transaction process
INSERT INTO Transactionheader VALUES
('TR016','ST003','CU011','2022-11-28'),
('TR017','ST007','CU012','2022-12-25')
INSERT INTO TransactionDetail VALUES
('TR016','SH011','10'),
('TR017','SH012','15')

-- No 5 answer of 10 cases

-- No 1 
SELECT mc.CustomerID, LEFT(CustomerName, CHARINDEX(' ', CustomerName)-1) AS 'CustomerName',
CustomerGender, SUM(Quantity) AS 'Total Item Purchased'
FROM MsCustomer mc JOIN
TransactionHeader th
ON mc.CustomerID = th.CustomerID
JOIN TransactionDetail td
ON td.TransactionID = th.TransactionID
WHERE CustomerGender = 'Male' AND
Quantity >= 1
GROUP BY mc.CustomerID, mc.CustomerName, CustomerGender


-- No 2
SELECT STUFF(ms.ShoesID, 1, 2, 'Shoes ') AS 'Shoes ID', 
StaffID, ShoesPrice,
DATENAME(WEEKDAY, TransactionDate) AS Day, 
ShoesName, 
SUM(Quantity) AS 'Total Sold'
FROM MsShoes ms
JOIN TransactionDetail td
ON ms.ShoesID = td.ShoesID
JOIN Transactionheader th
ON th.TransactionID = td.TransactionID
GROUP BY ms.ShoesID, StaffID, ShoesName, TransactionDate, ShoesPrice
HAVING ShoesPrice > 120000 AND SUM(Quantity) % 2 = 0;
-- no 3
SELECT CAST(RIGHT(ms.StaffID,3) AS INTEGER) AS 'StaffNumber',
UPPER(StaffName) AS 'StaffName',
StaffSalary,
COUNT(ph.PurchaseID) AS 'Total Purchase Made',
MAX(Quantity) AS 'Max Shoes Purchased'
FROM MsStaff ms JOIN PurchaseHeader ph
ON ms.StaffID = ph.StaffID
JOIN PurchaseDetail pd 
ON ph.PurchaseID = pd.PurchaseID
WHERE StaffSalary > 150000
GROUP BY ms.StaffID, StaffSalary, StaffName
HAVING COUNT(ph.PurchaseID) > 2
--no 4
SELECT mv.VendorID, 
CONCAT(VendorName, ' Vendor') AS 'Vendor Name',
UPPER(REPLACE(VendorEmail, '@gmail.com', '@mail.co.id')) AS 'Vendor Mail',
SUM(Quantity) AS 'Total Shoes Sold',
MIN(Quantity) AS 'Minimum Shoes Sold'
FROM MsVendor mv JOIN PurchaseHeader ph 
ON mv.VendorID = ph.VendorID
JOIN PurchaseDetail pd 
ON ph.PurchaseID = pd.PurchaseID
GROUP BY mv.VendorID, VendorName, VendorEmail
HAVING SUM(Quantity) > 13
AND MIN(Quantity) > 10
--no 5
SELECT 
  mv.VendorID,CONCAT(VendorName,' Company') AS 'Vendor Name', VendorPhoneNumber,
  DATENAME(MONTH , PurchaseDate) AS 'Purchase Month'
FROM MsVendor mv
JOIN PurchaseHeader ph ON mv.VendorID = ph.VendorID
JOIN PurchaseDetail pd ON ph.PurchaseID = pd.PurchaseID,
(SELECT AVG(Quantity) AS 'AVERAGE' FROM PurchaseDetail) M
WHERE 
DATENAME(MONTH,PurchaseDate) = 'April'
AND Quantity > M.AVERAGE

-- no 6
SELECT REPLACE(th.TransactionID,'SA','Invoice') AS 'Invoice Number',
YEAR(TransactionDate) AS 'Sales Year', ShoesName, ShoesPrice,
CONCAT (Quantity, ' piece(s)') AS 'Total Item'
FROM  TransactionHeader th
JOIN TransactionDetail td
ON th.TransactionID = td.TransactionID
JOIN MsShoes mss
ON mss.ShoesID = td.ShoesID,
(SELECT AVG(ShoesPrice) AS 'AVERAGE'
FROM MsShoes) M 
WHERE ShoesName LIKE '%c%'
AND ShoesPrice > M.AVERAGE
-- No 7  
SELECT 
  ph.PurchaseID,
  ms.StaffID,
  UPPER(StaffName) AS 'Staff Name',
  CONVERT(VARCHAR, PurchaseDate, 103) AS 'Purchase Date',
  'Rp. ' + CAST(SUM(ShoesPrice * Quantity) AS VARCHAR) AS 'Total Expenses'
FROM 
  MsStaff ms
JOIN 
  PurchaseHeader ph ON ms.StaffID = ph.StaffID
JOIN 
  PurchaseDetail pd ON pd.PurchaseID = ph.PurchaseID
JOIN 
  MsShoes mss ON mss.ShoesID = pd.ShoesID,
(
  SELECT AVG(ShoesPrice * Quantity) AS 'AverageSpent'
  FROM MsShoes mss
  JOIN PurchaseDetail pd ON pd.ShoesID = mss.ShoesID
) AS x
WHERE 
  CAST(RIGHT(ms.StaffID, 3) AS INT) % 2 = 1
  AND (ShoesPrice * Quantity) > x.AverageSpent
GROUP BY 
  ph.PurchaseID, 
  ms.StaffID, 
  UPPER(StaffName),
  CONVERT(VARCHAR, PurchaseDate, 103);


-- No 8
SELECT 
th.TransactionID,
ms.StaffID,
LEFT(StaffName, CHARINDEX(' ', StaffName) - 1) AS 'First Name',
RIGHT(StaffName, CHARINDEX(' ', REVERSE(StaffName)) - 1) AS 'Last Name',
SUM(Quantity * ShoesPrice) AS 'Total Revenue'
FROM MsStaff ms
JOIN Transactionheader th
ON ms.StaffID = th.StaffID
JOIN TransactionDetail td
ON td.TransactionID = th.TransactionID
JOIN MsShoes mss
ON mss.ShoesID = td.ShoesID,
(
SELECT AVG(ShoesPrice) AS 'AveragePrice'
FROM MsShoes
)x
WHERE StaffGender = 'Female'
AND
ShoesPrice > x.AveragePrice
GROUP BY th.TransactionID, 
ms.StaffID,
LEFT(StaffName, CHARINDEX(' ', StaffName) - 1),
RIGHT(StaffName, CHARINDEX(' ', REVERSE(StaffName)) - 1)

-- No 9

CREATE VIEW VendorMaxTransactionView 
AS
SELECT
    REPLACE(mv.VendorID, 'VE', 'Vendor ') AS 'Vendor Number',
    LOWER(VendorName) AS 'Vendor Name',
    COUNT(ph.PurchaseID) AS 'Total Transaction Made',
    MAX(Quantity) AS 'Maximum Quantity'
FROM
    MsVendor mv
    JOIN PurchaseHeader ph
	ON mv.VendorID = ph.VendorID
	JOIN PurchaseDetail pd
	ON pd.PurchaseID = ph.PurchaseID
WHERE
    VendorName LIKE '%a%' 
    AND Quantity > 20 
GROUP BY
    mv.VendorID, VendorName;

-- No 10
CREATE VIEW ShoesMinimumTransactionView 
AS
SELECT th.TransactionID, 
TransactionDate, 
StaffName, 
UPPER(StaffEmail) AS StaffEmail,
MIN(Quantity) AS 'Minimum Shoes Sold', 
SUM(Quantity) AS 'Total Shoes Sold'
FROM
    MsStaff ms
    JOIN TransactionHeader th
	ON ms.StaffID = th.StaffID
	JOIN TransactionDetail td
	ON td.TransactionID = th.TransactionID
	JOIN MsShoes mss
	ON mss.ShoesID = td.ShoesID
WHERE
    YEAR(TransactionDate) > 2020
    AND ShoesPrice > 10000
GROUP BY
th.TransactionID, TransactionDate, StaffName, StaffEmail

SELECT * FROM ShoesMinimumTransactionView
