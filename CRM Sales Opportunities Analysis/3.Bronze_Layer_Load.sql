/*
=====================================================================
Stored Procedure - Bronze Layer
=====================================================================
*/

USE SalesCRM;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
  DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
  BEGIN TRY
     SET @batch_start_time = GETDATE();
     PRINT '==================================================================';
     PRINT 'Loading Bronze Layer';
     PRINT '==================================================================';

     --Loading bronze.accounts
     SET @start_time = GETDATE();
     PRINT '>>Truncating Table : bronze.accounts';
     TRUNCATE TABLE bronze.accounts;
     PRINT '>>Inserting Data Into : bronze.accounts';
     BULK INSERT bronze.accounts
     FROM 'C:\Users\Mansi\OneDrive\Desktop\CRM\accounts.csv'
     WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
     );
     SET @end_time = GETDATE();
     PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
     PRINT '>>------------------------';

     --Loading bronze.products
     SET @start_time = GETDATE();
     PRINT '>>Truncating Table : bronze.products';
     TRUNCATE TABLE bronze.products;
     PRINT '>>Inserting Data Into : bronze.products';
     BULK INSERT bronze.products
     FROM 'C:\Users\Mansi\OneDrive\Desktop\CRM\products.csv'
     WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
     );
     SET @end_time = GETDATE();
     PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
     PRINT '>>------------------------';

     --Loading bronze.sales_teams
     SET @start_time = GETDATE();
     PRINT '>>Truncating Table : bronze.sales_teams';
     TRUNCATE TABLE bronze.sales_teams;
     PRINT '>>Inserting Data Into : bronze.sales_teams';
     BULK INSERT bronze.sales_teams
     FROM 'C:\Users\Mansi\OneDrive\Desktop\CRM\sales_teams.csv'
     WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
     );
     SET @end_time = GETDATE();
     PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
     PRINT '>>------------------------';

     --Loading bronze.sales_pipeline
     SET @start_time = GETDATE();
     PRINT '>>Truncating Table : bronze.sales_pipeline';
     TRUNCATE TABLE bronze.sales_pipeline;
     PRINT '>>Inserting Data Into : bronze.sales_pipeline';
     BULK INSERT bronze.sales_pipeline
     FROM 'C:\Users\Mansi\OneDrive\Desktop\CRM\sales_pipeline.csv'
     WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
     );
     SET @end_time = GETDATE();
     PRINT '>>Load Duration: '+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
     PRINT '>>------------------------';

     SET @batch_end_time = GETDATE();
     PRINT '==================================================================';
     PRINT 'Loading Bronze Layer is completed.';
     PRINT '>>Total Load Duration: '+ CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)+' seconds';
     PRINT '==================================================================';
  END TRY

  BEGIN CATCH
     PRINT '==================================================================';
     PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
     PRINT 'Error Message :' + ERROR_MESSAGE();
     PRINT 'Error Number :' + CAST(ERROR_NUMBER() AS NVARCHAR);
     PRINT 'Error State :' + CAST(ERROR_STATE() AS NVARCHAR);
     PRINT '==================================================================';
  END CATCH

END 