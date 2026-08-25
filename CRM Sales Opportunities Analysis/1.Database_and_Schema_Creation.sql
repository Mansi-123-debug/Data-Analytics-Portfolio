
--Database and Schema Creation

USE master;
GO

IF EXISTS( SELECT 1 FROM sys.databases WHERE name = 'SalesCRM')
BEGIN
   ALTER DATABASE SalesCRM SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
   DROP DATABASE SalesCRM;
END;
GO

CREATE DATABASE SalesCRM;
GO

USE SalesCRM;
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
