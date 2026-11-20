# Global Electronics Retailer Analysis

An end-to-end **Global Electronics Retailer Analysis** project built using **Microsoft Excel 2019** to transform raw sales data into meaningful business insights. The project explores product performance, customer locations, revenue trends, delivery time and average order value (AOV) across online and in-store sales channels.

## Tools & Technologies

- **Microsoft Excel 2019** 

## Advanced Excel Concepts Used
- Power Query: Data import, loading, data profiling, preparation
- Data Cleaning: Duplicate checks, blank value checks, and identification of spelling inconsistencies and invalid entries using Group By
- Lookup formulas: VLOOKUP for data consolidation
- Conditional and aggregation formulas: IF, IFERROR, SUMIFS, COUNT
- Text and arithmetic formulas: CONCATENATE, multiplication, subtraction, division, percentage
- PivotTables and PivotCharts
- Slicers for interactive filtering
- KPI calculations and sales performance analysis
- Time-series, product, geographic and sales-channel analysis
- Dashboard layout and data visualization

## Dataset

**Global Electronics Retailer — Maven Analytics**

Sales data for a fictitious global electronics retailer, including tables containing information about transactions, products, customers, stores and currency exchange rates.

https://mavenanalytics.io/data-playground/global-electronics-retailer

## Business Questions

This project addresses the four business questions provided by Maven Analytics:
- What types of products does the company sell, and where are customers located?
- Are there any seasonal patterns or trends for order volume or revenue?
- How long is the average delivery time in days? Has that changed over time?
- Is there a difference in average order value (AOV) for online vs. in-store sales?

## Key KPIs

| KPI | Value |
|---|---:|
| **Total Orders** |  **26,326** |
| **Total Revenue** | **$55.76M** |
| **Total Profit** |  **$32.66M** |
| **Average Order Value (AOV)** |  **$2,117.89** |
| **Difference between In-store and Online AOV** |  **$94.03** |

## Key Insights

- **Computers** are the highest-revenue category at **$19.30M (34.62%)** and **Adventure Works** is the 
  top-performing brand at **$11.85M (21.25%)**.
- **United States** is the largest market at **$29.87M (53.58%)** by revenue.
- Yearly revenue peaked at **$18.26M** in **2019**.
- **Q4** was the strongest quarter in each year from **2016 to 2019**, while **Q1** was the strongest quarter in **2020**.
- Delivery-time analysis covers **online** orders only. 
- Average delivery time decreased from **7.2 days in 2016 to 3.8 days in 2021**.
- In-store AOV exceeds online AOV by **$94.03**.

## Notes

- Revenue and profit are reported in USD.
- The 2021 dataset covers only 1 January to 20 February 2021; therefore, 2021 is a partial year.
- Delivery-time averages are calculated at the order level to avoid giving greater weight to orders containing more items.

