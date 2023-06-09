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
--('TransactionID', 'StaffID', 'CustomerID', 'TransactionDate')
-- NOTE: Ini aku udah buat polanya ya guys, untuk StaffID sama CustomerID pastikan aja udah ada ST001 - ST010, habistu untuk TransactionDate kita buatnya dari tahun 2020 - 2022
-- Habistu kalau misalnya mau tambahin jadi ada TR016 dst tambahin aja, habistu gak apa ada duplikat di StaffID sama CustomerID, soalnya kan staff atau customer bisa melakukan transaksi lebih dari 2x
-- Kalau bingung ambil aja referensi dari purchaseheader dari yang aku buat, atau gak dari db FishingMania
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
--('TransactionID','ShoesID','Quantity')
-- NOTE: Ini aku udah buat polanya ya guys, untuk TransactionID pastikan aja data yang ada di Transactionheader ada semua sama CustomerID pastikan aja udah ada CU001 - CU010, 
-- habistu untuk quantity menurut aku paling tinggi buat aja sampai 30 (jadi biar pas kerjain soal no 5 lebih simpel)
-- Habistu kalau misalnya mau tambahin jumlah data dari TransactionDetail tambahin aja, habistu untuk TransactionID kalau bisa buat urutan kek di PurchaseDetail di database kita, biar lebih rapi aja bacanya sama gak susah cari 
-- masalahnya dimana kalau misalnya tiba tiba mau ganti, sekaligus ShoesID gpp ya duplikat soalnya dalam 1 transaction bisa jadi customernya beli 2 jenis sepatu (ShoesID) yang berbeda
-- Kalau bingung ambil aja referensi dari purchasedetail dari yang aku buat, atau gak dari db FishingMania yang TransactionDetail

INSERT INTO TransactionDetail VALUES
('TR001','SH002','3'),
('TR002','SH004','1'),
('TR003','SH005','3'),
('TR004','SH003','5'),
('TR005','SH008','7'),
('TR006','SH010','6'),
('TR007','SH012','9'),
('TR008','SH036','10'),
('TR009','SH018','12'),
('TR010','SH021','15'),
('TR011','SH024','26'),
('TR012','SH022','17'),
('TR013','SH015','18'),
('TR014','SH013','9'),
('TR015','SH016','3'),
('TR012','SH017','5'),
('TR013','SH019','27'),
('TR014','SH008','25'),
('TR015','SH005','21'),
('TR001','SH003','4'),
('TR002','SH009','21'),
('TR003','SH003','32'),
('TR004','SH001','12'),
('TR005','SH029','14'),
('TR006','SH030','17')
