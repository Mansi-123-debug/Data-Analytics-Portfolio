# CRM Sales Opportunity Analysis

An end-to-end **CRM Sales Opportunity Analysis** project built using **SQL Server (SSMS)** and **Power BI** to transform raw sales pipeline data into meaningful business insights.

## Tools & Technologies

- **SQL Server (SSMS)** — Database creation, ETL, data transformation, and data modeling.
- **Power BI** — Data modeling, dashboard development, and visualization.
- **DAX** — KPI and measure calculations.

## SQL Concepts Used

Joins, window functions, views, stored procedures, data profiling, data validation, surrogate keys, star schema, and Medallion Architecture.

## Power BI Concepts Used

Data modeling, DAX measures, and dashboard development.

## Dataset

**CRM Sales Opportunities — Maven Analytics**

B2B sales pipeline data for a fictitious computer-hardware company, covering accounts, products, sales teams, and sales opportunities.

https://mavenanalytics.io/data-playground/crm-sales-opportunities

## Project Overview

The project follows a **Bronze–Silver–Gold (Medallion Architecture)** approach to transform raw CRM data into a structured dataset for Power BI analysis and visualization.

### Bronze Layer

- Created the SQL Server database and Bronze schema.
- Created tables for the raw CRM data.
- Loaded the CSV files into the Bronze layer.
- Performed data profiling and validation.
- Checked duplicates, nulls, relationships, and date fields.

### Silver Layer

Cleaned and standardized the data based on the profiling findings.

- Corrected `technolgy` to `technology`.
- Corrected `Philipines` to `Philippines`.
- Corrected `GTXPro` to `GTX Pro`.
- Validated product values against the products table.
- Confirmed Bronze and Silver row counts after transformation.

### Gold Layer

Created a **star schema** consisting of:

- **One fact table:** `gold.fact_sales_pipeline`
- **Three dimension tables:**
  - `dim_accounts`
  - `dim_products`
  - `dim_sales_teams`

Surrogate keys were created to establish relationships between the fact and dimension tables.

## Power BI Dashboard

Developed a **two-page Power BI dashboard** to analyze sales pipeline performance.

### Key KPIs

| KPI | Value |
|---|---:|
| **Total Revenue** | **$10.01M** |
| **Total Deals** | **8,800** |
| **Win Rate** | **63.15%** |
| **Average Deal Size** | **$2.36K** |

### Key Insights

- **Melvin Marxen's team** recorded the highest revenue at **$2.3M**.
- **Lajuana Vencill** had the lowest win rate at **54.98%**.
- **Quarter 2 (Q2)** recorded the highest quarterly revenue at **$3.09M**.
- **GTX Pro** generated the highest product revenue at **$3.5M**.
- **Retail** led all sectors with **$1.87M** in revenue.
- **West** led all regions with **$3.6M** in revenue.

## Business Questions

- How is each sales team performing compared to the rest?
- Are any sales agents lagging behind?
- How does revenue vary across quarters?
- Which product generates the most revenue?
- Which sector contributes the most revenue?
- Which region generates the most revenue?
