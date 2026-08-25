/*
=============================================================
DDL_Bronze Layer
=============================================================
*/

USE SalesCRM;
GO

--Creating accounts table
IF OBJECT_ID('bronze.accounts','U') IS NOT NULL
   DROP TABLE bronze.accounts;
GO

CREATE TABLE bronze.accounts(
   account            NVARCHAR(100),
   sector             NVARCHAR(50),
   year_established   INT,
   revenue            DECIMAL(10,2),
   employees          INT,
   office_location    NVARCHAR(100),
   subsidiary_of      NVARCHAR(100)
);
GO

--Creating products table     
IF OBJECT_ID('bronze.products','U') IS NOT NULL
   DROP TABLE bronze.products;
GO

CREATE TABLE bronze.products(
   product       NVARCHAR(50),
   series        NVARCHAR(50),
   sales_price   INT
);
GO

--Creating sales_teams table
IF OBJECT_ID('bronze.sales_teams','U') IS NOT NULL
   DROP TABLE bronze.sales_teams;
GO

CREATE TABLE bronze.sales_teams(
   sales_agent       NVARCHAR(100),
   manager           NVARCHAR(100),
   regional_office   NVARCHAR(50)
);
GO

--Creating sales_pipeline table
IF OBJECT_ID('bronze.sales_pipeline','U') IS NOT NULL
   DROP TABLE bronze.sales_pipeline;
GO

CREATE TABLE bronze.sales_pipeline(
   opportunity_id  NVARCHAR(50),
   sales_agent     NVARCHAR(100),
   product         NVARCHAR(50),
   account         NVARCHAR(100),
   deal_stage      NVARCHAR(50),
   engage_date     DATE,
   close_date      DATE,
   close_value     INT
);
GO
