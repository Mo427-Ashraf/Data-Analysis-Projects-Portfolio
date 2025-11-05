# 👥 KPI 4: Customer Behavior Analysis

**Domain:** Customer Insights  
**Database:** AdventureWorks2022  

---

## 🎯 Definition
**Formulae:**
- Repeat Purchase Rate = (Customers with >1 order ÷ Total Customers) × 100  
- Average Orders per Customer = COUNT(SalesOrderID) ÷ COUNT(DISTINCT CustomerID)  
- Inactive Customers = Customers with no orders after specific year  
- Customer Share by Territory = (Unique Customers in Territory ÷ Total Customers) × 100  

---

## 💼 Business Purpose
This KPI helps understand **customer engagement and loyalty patterns**.  
It supports:
1. Identifying **repeat vs one-time buyers**.  
2. Detecting **inactive or churned** customers.  
3. Measuring **average spending and order frequency**.  
4. Evaluating **regional customer concentration**.  
5. Monitoring **yearly customer acquisition growth**.  

---

## 🧠 SQL Logic Overview
| Query # | Purpose | Description |
|----------|----------|-------------|
| 4.1 | Customer Type Count | Segments customers into One-Time vs Repeated. |
| 4.2 | Type Percentage | Calculates loyalty ratio percentages. |
| 4.3 | Top 10 by Orders | Most frequent buyers. |
| 4.4 | Top 10 by Avg Value | Highest average spenders. |
| 4.5 | Inactive Customers | Identifies customers with no recent orders. |
| 4.6 | Avg Spending | Baseline spend metric per customer. |
| 4.7 | Customers per Region | Regional distribution of customer base. |
| 4.8 | New Customers per Year | Tracks acquisition rate. |

---

## 📊 Recommended Visualizations
- **Pie Chart:** One-time vs Repeat customers (%)  
- **Bar Chart:** Top 10 by total orders or average value  
- **Line Chart:** Yearly new customers  
- **Map Chart:** Unique customers per region  
- **Stacked Column:** Active vs inactive over years  

---

## 💡 Insights & Business Applications
- Measures **customer loyalty and retention**.  
- Identifies **regions with high/low customer base**.  
- Helps design **customer reactivation strategies**.  
- Tracks **new customer acquisition** effectiveness.  

---

**Author:** Data Analytics Team  
**Tool:** SQL Server (AdventureWorks2022)  
**KPI Category:** Customer Retention & Behavior  
