/*
=====================================================================
Gold Layer Views
=====================================================================
*/

USE SalesCRM;
GO

-- Create Dimension: gold.dim_accounts
IF OBJECT_ID('gold.dim_accounts','V') IS NOT NULL
     DROP VIEW gold.dim_accounts;
GO

CREATE VIEW gold.dim_accounts AS
   SELECT
       ROW_NUMBER () OVER (ORDER BY account) AS account_key,
       account,
       sector,
       year_established,
       revenue,
       employees,
       office_location,
       subsidiary_of
   FROM silver.accounts
   UNION ALL
   SELECT -1, 'Unknown', NULL, NULL, NULL, NULL, NULL, NULL;
GO

SELECT * FROM gold.dim_accounts;

-- Create Dimension: gold.dim_products
IF OBJECT_ID('gold.dim_products','V') IS NOT NULL
     DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
   SELECT
       ROW_NUMBER () OVER (ORDER BY product) AS product_key,
       product,
       series,
       sales_price
   FROM silver.products;
GO

SELECT * FROM gold.dim_products;

-- Create Dimension: gold.dim_sales_teams
IF OBJECT_ID('gold.dim_sales_teams','V') IS NOT NULL
     DROP VIEW gold.dim_sales_teams;
GO

CREATE VIEW gold.dim_sales_teams AS
   SELECT
       ROW_NUMBER () OVER (ORDER BY sales_agent) AS sales_agent_key,
       sales_agent,
       manager,
       regional_office
   FROM silver.sales_teams;
GO

SELECT * FROM gold.dim_sales_teams;

-- Create Fact Table: gold.fact_sales_pipeline
IF OBJECT_ID('gold.fact_sales_pipeline','V') IS NOT NULL
     DROP VIEW gold.fact_sales_pipeline;
GO

CREATE VIEW gold.fact_sales_pipeline AS
   SELECT
       sp.opportunity_id,
       st.sales_agent_key,
       p.product_key,
       COALESCE(a.account_key,-1) AS account_key,
       sp.deal_stage,    
       sp.engage_date,     
       sp.close_date,   
       sp.close_value 
   FROM silver.sales_pipeline sp
   LEFT JOIN gold.dim_sales_teams st
     ON sp.sales_agent = st.sales_agent
   LEFT JOIN gold.dim_products p
     ON sp.product = p.product
   LEFT JOIN gold.dim_accounts a
     ON sp.account = a.account
   
GO

SELECT * FROM gold.fact_sales_pipeline;

