show databases;
create database online_retail2;
use online_retail2;
set global local_infile =1;
use online_retail2;
create table online_retail2(
InvoiceNo VARCHAR(20),
 StockCode VARCHAR(20),
 Description TEXT,
 Quantity INT,
 InvoiceDate DATETIME,
 UnitPrice DECIMAL(10,2),
 CustomerID VARCHAR(20),
 Country VARCHAR(50)
);
select count(*) from online_retail2;
select * from online_retail2;
select count(distinct(CustomerID)) from online_retail2;
select * from online_retail2;
select * from online_retail2 where CustomerID = '';
select count(*) from online_retail2 where CustomerID = '';
select * from online_retail2;
select * from online_retail2 where CustomerID is Null;
select * from online_retail2;
select * from online_retail2 where Description = '' and CustomerID='';
select count(distinct(Description)) from online_retail2;
select * from online_retail2;
select * from online_retail2 where Quantity <=0 and CustomerID = '';
select * from online_retail2;
select * from online_retail2 where Description = "check" or Desription ="damages" and Quantity <=0 and UnitPrice =0.00 and CustomerID ='';
set sql_safe_updates =0;
delete from online_retail2 where (Description ="check" or Description ="damages") and Quantity <=0 and UnitPrice =0.00 and CustomerID='';
set sql_safe_updates=1;
select * from online_retail2;
select * from online_retail2 where Description ="check" and UnitPrice =0.00 and CustomerID='';
set sql_safe_updates=0;
delete from online_retail2 where Description ="check" and UnitPrice =0.00 and CustomerID ='';
set sql_safe_updates=1;
select distinct(Description) from online_retail2;
select * from online_retail2 where Quantity <=0 and Description ='' and UnitPrice =0.00;
set sql_safe_updates=0;
delete from online_retail2 where Description ='' and Quantity <=0 and UnitPrice =0.00;
set sql_safe_updates=1;
select * from online_retail2 where Description ='' and Quantity <=0 and UnitPrice =0.00;
select distinct(Description) from online_retail2;
select * from online_retail2;
select * from online_retail2 where Description like '?%';

set sql_safe_updates =0;
delete from online_retail2 where Description like '?%';
set sql_safe_updates=1;
select * from online_retail2 where Description like '?%';
select * from online_retail2 where Description ='';
set sql_safe_updates=0;
delete from online_retail2 where Description ='' and UnitPrice =0.00 and CustomerID ='';
set sql_safe_updates=1;
select * from online_retail2;
select * from online_retail2 where Description ='' and UnitPrice =0.00 and CustomerID='';
select distinct(Country) from online_retail2;
select count(*) from online_retail2 where CustomerID ='';
select count(*) from online_retail2;
select * from online_retail2 where CustomerID='';
set sql_safe_updates =0;
delete from online_retail2 where CustomerID ='';
set sql_safe_updates=1;
select * from online_retail2;
#cek InvoiceNO is null
select * from online_retail2 where InvoiceNo ='';
select * from online_retail2;
select * from online_retail2 where StockCode ='';
select * from online_retail2 where Description ='';
select * from online_retail2 where Quantity ='';
select count(*) from online_retail2 where 	UnitPrice =0.00;

set sql_safe_updates=0;
delete from online_retail2 where UnitPrice =0.00;
set sql_safe_updates=1;
select * from online_retail2 where UnitPrice =0.00;

select * from online_retail2 order by Quantity asc;
select * from online_retail2;
select Country, count(Country) as number_of_country  from online_retail2 group by Country order by number_of_country desc;
select distinct(Description) from online_retail2;
select * from online_retail2 where Description ='Discount';
select * from online_retail2;

#check setiap row ada yang duplicate ga 

select *, row_number () over (
partition by InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country) as row_num 
from online_retail2;

with duplicate_cte as 
(
select *, row_number () over (
partition by InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country) as row_num
 from online_retail2
)

select * from duplicate_cte where row_num>1;
delete from duplicate_cte where row_num >1; 

CREATE TABLE `online_retail3` (
  `InvoiceNo` varchar(20) DEFAULT NULL,
  `StockCode` varchar(20) DEFAULT NULL,
  `Description` text,
  `Quantity` int DEFAULT NULL,
  `InvoiceDate` datetime DEFAULT NULL,
  `UnitPrice` decimal(10,2) DEFAULT NULL,
  `CustomerID` varchar(20) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from online_retail3;
insert into online_retail3
select *, row_number () over (
partition by InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country) as row_num
from online_retail2;

select * from online_retail3;
select * from online_retail3 where row_num >1;
set sql_safe_updates =0;
delete from online_retail3 where row_num >1;
set sql_safe_updates=1;
select * from online_retail3;
select * from online_retail3 where row_num >1;
select * from online_retail3;

alter table online_retail3 drop column row_num;
select * from online_retail3;
select COUNT(*) from online_retail3 where InvoiceNo like 'C%';
select * from online_retail3;
select * from online_retail3 where Description ='Discount';
select distinct(StockCode) from online_retail3; 
select * from online_retail3 where StockCode ='Bank Charges' or StockCode = 'M' or StockCode ='C2' or StockCode = 'POST';
set sql_safe_updates=0;
delete from online_retail3 where StockCode ='Bank Charges' or StockCode ='M' or StockCode ='C2' or StockCode ='POST';
set sql_safe_updates=1;
select * from online_retail3 where StockCode ='Bank Charges' or StockCode = 'M' or StockCode ='C2' or StockCode = 'POST';
select * from online_retail3;
select * from online_retail3 where InvoiceNo like 'C%'; 

select min(InvoiceDate) from online_retail3;
select max(InvoiceDate) from online_retail3;
select * from online_retail3;
select * from online_retail3 where StockCode = 21533;
#cek duplicate data
select * from online_retail3 where Quantity<=0;
select * from online_retail3;
select * from online_retail3 where Country like 'United Kingdom%';
select Country from online_retail3;

-- Hapus karakter \r dari kolom Country,                                                         
-- kenapa? karena kalau tidak dihapus tidak bisa Country ='United Kingdom' bisanya hanya like 'United Kingdom%'
set sql_safe_updates=0;
UPDATE online_retail3
SET Country = REPLACE(Country, CHAR(13), '');
set sql_safe_updates=1;
 
select * from online_retail3;
select * from online_retail3 where Country ='France';

ALTER TABLE online_retail3 
ADD COLUMN CustomerID_clean INT;
-- Nonaktifkan safe updates
SET SQL_SAFE_UPDATES = 0;

-- Update CustomerID_clean dengan nilai sebelum titik
UPDATE online_retail3
SET CustomerID_clean = CAST(SUBSTRING_INDEX(TRIM(CustomerID), '.', 1) AS UNSIGNED)
WHERE CustomerID IS NOT NULL;

SET SQL_SAFE_UPDATES=0;
UPDATE online_retail3
SET CustomerID = CAST(CustomerID_clean AS CHAR)
WHERE CustomerID_clean IS NOT NULL;

select * from online_retail3 where CustomerID IS NULL;
set sql_safe_updates=0;
ALTER TABLE online_retail3
DROP COLUMN CustomerID_clean;

select *from online_retail3;

