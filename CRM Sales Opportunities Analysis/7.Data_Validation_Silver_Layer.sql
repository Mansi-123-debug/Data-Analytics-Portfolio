/*
=====================================================================
Data Validation - Silver Layer
=====================================================================
*/

USE SalesCRM;
GO

EXEC silver.load_silver;

/*-------------------------accounts table-------------------------*/
SELECT * FROM silver.accounts;

--Total number of records
SELECT COUNT(*) AS Total_Rows FROM silver.accounts;

--Reviewing distinct values to confirm 'technolgy' and 'Philipines' are corrected
SELECT DISTINCT sector FROM silver.accounts ORDER BY sector;
SELECT DISTINCT office_location FROM silver.accounts ORDER BY office_location;

/*-------------------------products table-------------------------*/
SELECT * FROM  silver.products;


/*-------------------------sales_teams table-------------------------*/
SELECT * FROM  silver.sales_teams;

--Total number of records
SELECT COUNT(*) AS Total_Rows FROM silver.sales_teams;

/*-------------------------sales_pipeline table-------------------------*/
SELECT * FROM  silver.sales_pipeline;

--Total number of records
SELECT COUNT(*) AS Total_Rows FROM silver.sales_pipeline;

--Reviewing all distinct product values to confirm GTXPro is corrected
SELECT DISTINCT product FROM silver.sales_pipeline ORDER BY product;


/*
================================================================================
Silver Layer Validation Findings
================================================================================

accounts
---------------------------
- 85 rows loaded, matches Bronze
- 'technolgy' fixed to 'technology' in sector column
- 'Philipines' fixed to 'Philippines' in office_location column

products
---------------------------
- 7 rows loaded, matches Bronze

sales_teams
---------------------------
- 35 rows loaded, matches Bronze

sales_pipeline
---------------------------
- 8,800 rows loaded, matches Bronze
- 'GTXPro' fixed to 'GTX Pro' in product column
- All products now match products table

================================================================================
All Silver layer fixes confirmed — data is clean and ready for Gold layer
================================================================================
*/



