# 💰 KPI 2: Customer Lifetime Value (CLV)

**Domain:** Sales  
**Database:** AdventureWorks2022  

---

## 🎯 Definition
**Formula:**
> CLV = (Average Order Value × Purchase Frequency) × Average Customer Lifespan  

Since lifespan is not directly available, the simplified version used here is:
> CLV = AVG(TotalDue) × COUNT(SalesOrderID)

---

## 💼 Business Purpose
Customer Lifetime Value (CLV) estimates the **total expected revenue** from each customer over their entire relationship with the business.  
It enables:
1. Identifying **high-value vs low-value** customers.  
2. Designing **targeted loyalty or retention programs**.  
3. Evaluating **marketing ROI** and acquisition cost.  
4. Prioritizing regions and customer segments.  

---

## 🧠 SQL Logic Overview
| Query # | Purpose | Description |
|----------|----------|-------------|
| 2.1 | Average Order Value (AOV) | Calculates mean order value for each customer. |
| 2.2 | Total Orders | Counts how many purchases each customer made. |
| 2.3 | CLV per Customer | Multiplies AOV × Orders (direct & CTE versions). |
| 2.4 | Top 10 Customers | Lists top 10 by CLV. |
| 2.5 | CLV by Region | Aggregates CLV values by sales territory. |
| 2.6 | Loyal Customers | Filters customers with >15 orders. |
| 2.7 | Above-Average CLV | Filters customers outperforming the mean CLV. |
| 2.8 | CLV Ranking | Uses DENSE_RANK() for tiered ranking. |
| 2.9 | High vs Low CLV % | Categorizes and computes share per group. |
| 2.10 | CLV Classification | Assigns “High” or “Low” label per customer. |

---

## 📊 Visualization Ideas
- **Bar chart:** Top 10 CLV customers  
- **Pie chart:** % of High vs Low CLV groups  
- **Map:** CLV per region  
- **Table:** Ranked customer CLV list  
- **Heatmap:** CLV vs number of orders  

---

## 💡 Insights & Applications
- Reveals **who contributes the most** to overall revenue.  
- Helps allocate **marketing budgets efficiently**.  
- Identifies **customer retention priorities**.  
- Tracks **loyal vs churn-prone segments**.  

---

**Author:** Data Analytics Team  
**Tool:** SQL Server (AdventureWorks2022)  
**KPI Category:** Customer Value Analysis  
