# 📊 KPI 1: Total Sales Revenue

**Domain:** Sales  
**Database:** AdventureWorks2022  

---

## 🎯 Definition
**Total Sales Revenue = SUM(TotalDue)**  
Represents the **total financial value** of all sales transactions, including taxes, freight, and discounts.

---

## 💼 Business Purpose
This KPI measures the **overall financial performance** of the company.  
It helps:
1. Monitor **revenue growth trends** (monthly, quarterly, yearly).  
2. Compare **performance by region, product, or salesperson**.  
3. Assess **company profitability** and sales stability.

---

## 🧠 SQL Logic Overview
| Query # | Purpose | Description |
|----------|----------|-------------|
| 1.1 | All-Time Revenue | Counts total orders and sums `TotalDue`. |
| 1.2 | Revenue by Year | Groups sales totals per year. |
| 1.3 | Revenue by Month | Focuses on 2013 for seasonality analysis. |
| 1.4 | Revenue by Quarter | Uses `DATEPART(QUARTER)` to track quarterly trends. |
| 1.5 | Top 2 Years | Identifies years with maximum revenue. |
| 1.6 | Quarterly by Range | Shows 2011–2013 quarter-wise trends. |
| 1.7 | Cumulative Revenue | Uses window function for running total. |
| 1.8 | Avg Revenue per Year | Evaluates mean order value per year. |
| 1.9 | Revenue by Region | Joins `SalesTerritory` for regional sales. |
| 1.10 | Top/Bottom Customers | Highlights customer spending extremes. |
| 1.11 | Avg Revenue per Quarter | Measures average sale amount per quarter. |
| 1.12 | Orders per Region | Counts total orders by territory. |
| 1.13 | Revenue per Product | Aggregates line totals at product level. |
| 1.14 | Revenue per Category | Joins multi-level product hierarchy. |
| 1.15 | Top 10 Products | Ranks products by revenue. |
| 1.16 | Monthly Sales (2014) | Displays 2014 monthly sales trend. |

---

## 📈 Recommended Visualizations
- **Line chart:** Revenue trend by year or month  
- **Bar chart:** Revenue per region or product category  
- **Tree map:** Revenue contribution by product  
- **Stacked column:** Quarterly or cumulative revenue  
- **Table/Matrix:** Top 10 customers or products  

---

## 💡 Key Insights
- Reveals **highest-performing years, months, and regions**.  
- Helps detect **seasonal demand** and **growth patterns**.  
- Enables **data-driven sales forecasting**.  
- Identifies **high-value customers and products**.  

---

**Author:** Data Analytics Team  
**Tool:** SQL Server (AdventureWorks2022)  
**KPI Category:** Financial Performance  
