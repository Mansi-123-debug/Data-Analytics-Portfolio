/*================================================================
  Data Profiling - Bronze Layer
  ================================================================*/

USE SalesCRM;
GO

EXEC bronze.load_bronze;

/*-------------------------accounts table-------------------------*/
SELECT * FROM bronze.accounts;

--Total number of records
SELECT COUNT(*) AS Total_Rows FROM bronze.accounts;

--Checking for duplicate account names
SELECT account,
       COUNT(*)
FROM bronze.accounts
GROUP BY account
HAVING COUNT(*) > 1;

--Checking for null values across key columns
SELECT
    SUM(CASE WHEN account IS NULL THEN 1 ELSE 0 END) AS account_nulls,
    SUM(CASE WHEN sector IS NULL THEN 1 ELSE 0 END) AS sector_nulls,
    SUM(CASE WHEN year_established IS NULL THEN 1 ELSE 0 END) AS year_established_nulls,
    SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS revenue_nulls,
    SUM(CASE WHEN employees IS NULL THEN 1 ELSE 0 END) AS employees_nulls,
    SUM(CASE WHEN office_location IS NULL THEN 1 ELSE 0 END) AS office_location_nulls
FROM bronze.accounts;

--Checking distinct values to identify inconsistent formatting or data entry errors
SELECT DISTINCT sector FROM bronze.accounts ORDER BY sector;
SELECT DISTINCT office_location FROM bronze.accounts ORDER BY office_location;

--Checking for invalid values
SELECT 
    MIN(year_established) AS min_year, MAX(year_established) AS max_year,
    MIN(revenue) AS min_revenue, MAX(revenue) AS max_revenue,
    MIN(employees) AS min_employees, MAX(employees) AS max_employees
FROM bronze.accounts;

/*-------------------------products table-------------------------*/
SELECT * FROM  bronze.products;


/*-------------------------sales_teams table-------------------------*/
SELECT * FROM  bronze.sales_teams;

--Total number of records
SELECT COUNT(*) AS Total_Rows FROM bronze.sales_teams;

--Checking for duplicate sales_agent names
SELECT sales_agent,
       COUNT(*)
FROM bronze.sales_teams
GROUP BY sales_agent
HAVING COUNT(*) > 1;

--Checking for null values across key columns
SELECT
    SUM(CASE WHEN sales_agent IS NULL THEN 1 ELSE 0 END) AS sales_agent_nulls,
    SUM(CASE WHEN manager IS NULL THEN 1 ELSE 0 END) AS manager_nulls,
    SUM(CASE WHEN regional_office IS NULL THEN 1 ELSE 0 END) AS regional_office_nulls
FROM bronze.sales_teams;

--Checking distinct values to identify inconsistent formatting or data entry errors
SELECT DISTINCT manager FROM bronze.sales_teams ORDER BY manager;
SELECT DISTINCT regional_office FROM bronze.sales_teams ORDER BY regional_office;

/*-------------------------sales_pipeline table-------------------------*/
SELECT * FROM  bronze.sales_pipeline;
 
--Total number of records
SELECT COUNT(*) AS Total_Rows FROM bronze.sales_pipeline;

--Checking for duplicate opportunity_id
SELECT opportunity_id,
       COUNT(*)
FROM bronze.sales_pipeline
GROUP BY opportunity_id
HAVING COUNT(*) > 1;

--Checking if every sales_agent in sales_pipeline exists in sales_teams
SELECT DISTINCT p.sales_agent
FROM bronze.sales_pipeline p
LEFT JOIN bronze.sales_teams t 
  ON p.sales_agent = t.sales_agent
WHERE t.sales_agent IS NULL;

--Checking if every product in sales_pipeline exists in products
SELECT DISTINCT s.product
FROM bronze.sales_pipeline s
LEFT JOIN bronze.products p
  ON s.product = p.product
WHERE p.product IS NULL;

--Checking if every account in sales_pipeline exists in accounts
SELECT DISTINCT s.account
FROM bronze.sales_pipeline s
LEFT JOIN bronze.accounts a
  ON s.account = a.account
WHERE a.account IS NULL AND s.account IS NOT NULL;

--Checking for null values across key columns
SELECT
    SUM(CASE WHEN account IS NULL THEN 1 ELSE 0 END) AS account_nulls,
    SUM(CASE WHEN engage_date IS NULL THEN 1 ELSE 0 END) AS engage_date_nulls,
    SUM(CASE WHEN close_date IS NULL THEN 1 ELSE 0 END) AS close_date_nulls,
    SUM(CASE WHEN close_value IS NULL THEN 1 ELSE 0 END) AS close_value_nulls
FROM bronze.sales_pipeline;

--Checking distinct values to identify inconsistent formatting or data entry errors
SELECT DISTINCT product FROM bronze.sales_pipeline ORDER BY product;
SELECT DISTINCT deal_stage FROM bronze.sales_pipeline ORDER BY deal_stage;

--Checking for date logic
SELECT engage_date,
       close_date
FROM bronze.sales_pipeline
WHERE engage_date > close_date;

--Checking for invalid values
SELECT 
    MIN(engage_date) AS min_engage_date, MAX(engage_date) AS max_engage_date,
    MIN(close_date) AS min_close_date, MAX(close_date) AS max_close_date,
    MIN(close_value) AS min_close_value, MAX(close_value) AS max_close_value
FROM bronze.sales_pipeline;


/*
================================================================================
Data Profiling Findings
================================================================================


/*--accounts table--*/

- No duplicate accounts found
- Sector contains misspelled value 'technolgy'
- Office location contains misspelled value 'Philipines'
- No invalid values found in year_established, revenue and employees columns
- No null values found in key columns

/*--products table--*/

- All 7 rows visually verified, no issues found

/*--sales_teams table--*/

- No duplicate sales agents found
- No null values found in key columns
- 3 distinct regional offices confirmed: Central, East, West
- All manager names consistent, no issues found

/*--sales_pipeline table--*/

- No duplicate opportunity IDs found
- Product value 'GTXPro' does not match products table
- 1,425 blank account values (expected — open/prospecting deals not yet assigned)
- 500 blank engage_date (expected — prospecting deals not yet engaged)
- 2,089 blank close_date and close_value (expected — open deals not yet closed)
- All accounts, products and sales agents confirmed matching their dimension tables
- No invalid date relationships found
- No invalid values found in engage_date, close_date and close_value columns

*/