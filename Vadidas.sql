CREATE DATABASE Vadidas
GO
USE Vadidas
GO

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
	Quantity INT NOT NULL,
	ShoesID CHAR(5) FOREIGN KEY REFERENCES MsShoes(ShoesID) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
	PRIMARY KEY (PurchaseID)
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
	PRIMARY KEY (TransactionID)
)
SELECT * FROM TransactionHeader

-- CONSTRAINTS

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
-- INSERT DATA

-- MsTable
-- MsCustomer
INSERT INTO MsCustomer VALUES
--('CU001','Andika Teriawan','Male','1997-04-11','Jl KH Fachrudin 4, Dki Jakarta','andikat97@gmail.com')
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

--MsVendor

--TransactionHeader
--PurchaseHeader

--PurchaseDetail

--TransactionHeader

--TransactionHeader