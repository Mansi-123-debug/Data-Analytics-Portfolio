/*
=============================================================
DDL_Silver Layer
=============================================================
*/

USE SalesCRM;
GO

--Creating accounts table
IF OBJECT_ID('silver.accounts','U') IS NOT NULL
   DROP TABLE silver.accounts;
GO

CREATE TABLE silver.accounts(
   account            NVARCHAR(100),
   sector             NVARCHAR(50),
   year_established   INT,
   revenue            DECIMAL(10,2),
   employees          INT,
   office_location    NVARCHAR(100),
   subsidiary_of      NVARCHAR(100),
   dwh_create_date    DATETIME2 DEFAULT GETDATE()   
   );
GO

--Creating products table     
IF OBJECT_ID('silver.products','U') IS NOT NULL
   DROP TABLE silver.products;
GO

CREATE TABLE silver.products(
   product       NVARCHAR(50),
   series        NVARCHAR(50),
   sales_price   INT,
   dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO

--Creating sales_teams table
IF OBJECT_ID('silver.sales_teams','U') IS NOT NULL
   DROP TABLE silver.sales_teams;
GO

CREATE TABLE silver.sales_teams(
   sales_agent       NVARCHAR(100),
   manager           NVARCHAR(100),
   regional_office   NVARCHAR(50),
   dwh_create_date   DATETIME2 DEFAULT GETDATE()
);
GO

--Creating sales_pipeline table
IF OBJECT_ID('silver.sales_pipeline','U') IS NOT NULL
   DROP TABLE silver.sales_pipeline;
GO

CREATE TABLE silver.sales_pipeline(
   opportunity_id  NVARCHAR(50),
   sales_agent     NVARCHAR(100),
   product         NVARCHAR(50),
   account         NVARCHAR(100),
   deal_stage      NVARCHAR(50),
   engage_date     DATE,
   close_date      DATE,
   close_value     INT,
   dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
