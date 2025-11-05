
# 📊 AdventureWorks2022 – Sales & Operations KPI Documentation

This document consolidates the five key performance indicators (KPIs) analyzed from the **AdventureWorks2022** SQL Server database.  
Each KPI includes its **business definition**, **SQL logic breakdown**, and **recommended visualization insights**.

---

## KPI 1 – Total Sales Revenue

**Domain:** Sales  
**Formula:** SUM(TotalDue)

### Business Purpose
Monitors the total financial performance of the organization by measuring total money generated from all sales orders.  
It supports revenue growth analysis, regional comparison, and trend forecasting.

### Key SQL Components
- Aggregate: `SUM(TotalDue)`
- Time Functions: `YEAR()`, `DATEPART(QUARTER)`
- Joins: Region & Product tables
- Window Function: `SUM() OVER()` for cumulative totals

### Visualization Ideas
- Line chart: Revenue trend by year/month  
- Tree map: Product revenue contribution  
- Column chart: Regional comparison  
- KPI card: Total revenue, cumulative trend

### Key Insight
Highlights top-performing years, quarters, products, and regions, enabling forecasting and strategic planning.

---

## KPI 2 – Customer Lifetime Value (CLV)

**Domain:** Sales Analytics  
**Formula:** CLV = AVG(TotalDue) × COUNT(SalesOrderID)

### Business Purpose
Measures total expected revenue from a customer over their lifetime to guide retention, marketing ROI, and customer segmentation.

### Key SQL Components
- Aggregates: `AVG()`, `COUNT()`
- Joins: `SalesTerritory` for regional CLV comparison  
- Window Function: `DENSE_RANK()` for ranking customers  
- Subqueries for above-average CLV segmentation

### Visualization Ideas
- Bar chart: Top 10 CLV customers  
- Pie chart: High vs Low CLV groups  
- Map: CLV distribution by region  
- Table: CLV rank per customer  

### Key Insight
Reveals high-value customers and informs targeted campaigns for retention, loyalty, and acquisition optimization.

---

## KPI 3 – Product Sales Insights

**Domain:** Production & Sales Performance  
**Formulae:**  
- Product Revenue = SUM(LineTotal)  
- Quantity Sold = SUM(OrderQty)  
- Discount Impact = SUM(UnitPriceDiscount × UnitPrice × OrderQty)  
- Contribution % = (Product Revenue ÷ Category Revenue) × 100

### Business Purpose
Analyzes performance at product and category level, identifying best sellers, discount-heavy items, and cost inefficiencies.

### Key SQL Components
- Joins: Product, Subcategory, Category tables  
- CTE + Window: `LAG()` for trend comparisons  
- Self-Join: YoY growth analysis  
- Cost-to-Revenue Ratio with `ROUND()`  

### Visualization Ideas
- Tree map: Category contribution %  
- Bar chart: Top-selling products  
- Waterfall: Discount impact per product  
- Heatmap: Declining vs growing items  

### Key Insight
Supports data-driven production planning, pricing strategy, and marketing prioritization by pinpointing performance gaps.

---

## KPI 4 – Customer Behavior Analysis

**Domain:** Customer Insights  
**Formulae:**  
- Repeat Rate = (Customers with >1 order ÷ Total Customers) × 100  
- Inactive Customers = No orders after year X  
- Orders per Customer = COUNT(SalesOrderID) ÷ COUNT(DISTINCT CustomerID)

### Business Purpose
Evaluates customer engagement and loyalty. Helps detect inactive customers, analyze retention, and track acquisition.

### Key SQL Components
- CTEs for classification (Repeated vs One-Time)  
- CASE statements for segmentation  
- Aggregations: `COUNT()`, `AVG()`  
- Subquery: `MIN(OrderDate)` for first purchase detection  

### Visualization Ideas
- Pie chart: One-time vs Repeat customers  
- Line chart: New customers per year  
- Bar chart: Top customers by orders/spending  
- Map: Customers per region  

### Key Insight
Reveals loyalty, churn, and engagement trends essential for CRM, marketing, and retention strategy.

---

## KPI 5 – Order Fulfillment & Delivery Performance

**Domain:** Operations & Logistics  
**Formulae:**  
- Average Delivery Time = AVG(DATEDIFF(DAY, OrderDate, ShipDate))  
- On-Time % = Orders ≤ 5 days ÷ Total Orders × 100

### Business Purpose
Monitors operational efficiency, focusing on delivery timeliness and fulfillment consistency.

### Key SQL Components
- Date Function: `DATEDIFF()` for delivery duration  
- Conditional: `CASE` for on-time classification  
- Aggregates: `AVG()`, `COUNT()`  
- Grouping: `YEAR()`, `DATEPART(QUARTER)` for seasonal patterns

### Visualization Ideas
- Pie chart: On-time vs Delayed %  
- Line chart: Delivery trends per quarter  
- Bar chart: Average delivery per territory  
- Table: Top delayed customers/salespersons  

### Key Insight
Improves service quality by identifying delay patterns, underperforming regions, and logistics inefficiencies.

---

## 📘 Summary Table

| KPI | Category | Focus | Key Metric | Key Benefit |
|-----|-----------|--------|-------------|--------------|
| 1 | Financial | Sales Revenue | TotalDue | Revenue growth tracking |
| 2 | Customer Value | Lifetime Revenue | CLV | Identify high-value customers |
| 3 | Product Performance | Product & Category | LineTotal | Detect top and weak products |
| 4 | Customer Behavior | Loyalty & Retention | Orders per Customer | Retention and churn analysis |
| 5 | Operations | Delivery Timeliness | DATEDIFF | SLA and logistics optimization |

---

**Prepared by:** Data Analytics Team  
**Tool:** SQL Server (AdventureWorks2022)  
**Document Type:** Consolidated KPI Reference Guide  
**Date:** November 2025
