/*
=====================================================================
Stored Procedure - Silver Layer
=====================================================================
*/

USE SalesCRM;
GO

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '=======================================================';
        PRINT 'Loading Silver Layer';
        PRINT '=======================================================';

        -- Loading silver.accounts
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.accounts';
		TRUNCATE TABLE silver.accounts;
		PRINT '>> Inserting Data Into: silver.accounts';
		
		INSERT INTO silver.accounts (
			account, sector, year_established, revenue,
			employees, office_location, subsidiary_of
		)
		SELECT
		    TRIM(account) AS account,
			CASE WHEN TRIM(sector) = 'technolgy' THEN 'technology' 
			ELSE TRIM(sector)
			END AS sector,
			year_established,
			revenue,
			employees,
			CASE WHEN TRIM(office_location) = 'Philipines' THEN 'Philippines'
			ELSE TRIM(office_location)
			END AS office_location,
			TRIM(subsidiary_of) AS subsidiary_of
         FROM bronze.accounts;

		 SET @end_time = GETDATE();
         PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
         PRINT '>> -------------------------';
	     
		 -- Loading silver.products
         SET @start_time = GETDATE();
		 PRINT '>> Truncating Table: silver.products';
		 TRUNCATE TABLE silver.products;
		 PRINT '>> Inserting Data Into: silver.products';
		
		 INSERT INTO silver.products (
		    	product, series, sales_price
		 )
		 SELECT
		        product,
				series,
				sales_price
         FROM bronze.products;

		 SET @end_time = GETDATE();
         PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
         PRINT '>> -------------------------';

		 -- Loading silver.sales_teams
         SET @start_time = GETDATE();
		 PRINT '>> Truncating Table: silver.sales_teams';
		 TRUNCATE TABLE silver.sales_teams;
		 PRINT '>> Inserting Data Into: silver.sales_teams';
		
		 INSERT INTO silver.sales_teams(
		    	sales_agent, manager, regional_office
		 )
		 SELECT
		        TRIM(sales_agent) AS sales_agent,
                TRIM(manager) AS manager,          
                TRIM(regional_office) AS regional_office
         FROM bronze.sales_teams;

		 SET @end_time = GETDATE();
         PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
         PRINT '>> -------------------------';
	     
		 -- Loading silver.sales_pipeline
         SET @start_time = GETDATE();
		 PRINT '>> Truncating Table: silver.sales_pipeline';
		 TRUNCATE TABLE silver.sales_pipeline;
		 PRINT '>> Inserting Data Into: silver.sales_pipeline';
		
		 INSERT INTO silver.sales_pipeline(
		    	opportunity_id, sales_agent, product,
                account, deal_stage, engage_date, 
				close_date, close_value    
		 )
		 SELECT
		       TRIM(opportunity_id) AS opportunity_id,
               TRIM(sales_agent) AS sales_agent,
               CASE WHEN TRIM(product) = 'GTXPro' THEN 'GTX Pro' 
			   ELSE TRIM(product) 
			   END AS product,
               TRIM(account) AS account,
               TRIM(deal_stage) AS deal_stage,
               engage_date,
               close_date,
               close_value 
		 FROM bronze.sales_pipeline;

		 SET @end_time = GETDATE();
         PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
         PRINT '>> -------------------------';
		 SET @batch_end_time = GETDATE();
         
		 PRINT '==================================================================';
         PRINT 'Loading Silver Layer is completed.';
         PRINT '>>Total Load Duration: '+ CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)+' seconds';
         PRINT '==================================================================';
	
	
    END TRY
	BEGIN CATCH
	     PRINT '==================================================================';
         PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER';
         PRINT 'Error Message :' + ERROR_MESSAGE();
         PRINT 'Error Number :' + CAST(ERROR_NUMBER() AS NVARCHAR);
         PRINT 'Error State :' + CAST(ERROR_STATE() AS NVARCHAR);
         PRINT '==================================================================';
	END CATCH
END        