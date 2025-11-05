# 🏷️ KPI 3: Product Sales Insights

**Domain:** Sales & Production  
**Database:** AdventureWorks2022  

---

## 🎯 Definition
**Core Formulae:**
- Product Revenue = SUM(LineTotal)  
- Quantity Sold = SUM(OrderQty)  
- Discount Impact = SUM(UnitPriceDiscount × UnitPrice × OrderQty)  
- Contribution % = (Product Revenue ÷ Category Revenue) × 100  

---

## 💼 Business Purpose
This KPI analyzes **product-level performance** to understand:
1. Best and worst selling products.  
2. Seasonal patterns (quarterly/annual).  
3. Impact of discounts on revenue.  
4. Cost-to-revenue efficiency.  
5. Category and subcategory contribution.  
6. Declining or stable product trends.  

---

## 🧠 SQL Logic Overview
| Query # | Purpose | Description |
|----------|----------|-------------|
| 3.1 | Top 10 Products by Qty | Ranks highest volume products. |
| 3.2 | Category by Qty | Aggregates order quantity by product category. |
| 3.3 | Subcategory Yearly Sales | Tracks annual revenue per subcategory. |
| 3.4 | Discount Impact | Total discount value per product. |
| 3.5 | Evergreen Products | Sold in every available year. |
| 3.6 | Top Q4 Products | Seasonal performance (Q4 revenue). |
| 3.7 | Contribution % | Product share within its category. |
| 3.8 | Declining Sales | LAG() detects year-over-year drops. |
| 3.9 | Cost-to-Revenue | Compares production cost vs revenue. |
| 3.10 | Unsold Products | Products never ordered. |
| 3.11 | Broad Appeal Products | Products with most unique customers. |
| 3.12 | Fastest Growth | YoY growth (2012→2013). |

---

## 📊 Recommended Visualizations
- **Bar / Column Chart:** Top selling products or categories  
- **Tree Map:** Category revenue share  
- **Line Chart:** Year-over-year sales trends  
- **Waterfall:** Discount impact per product  
- **Bubble Chart:** Cost-to-Revenue vs Quantity Sold  
- **Heat Map:** Growth or decline patterns  

---

## 💡 Key Insights
- Identifies **top-selling and underperforming** items.  
- Detects **discount dependency and profit leaks**.  
- Measures **production efficiency and cost ratios**.  
- Enables **strategic stock management and pricing decisions**.  

---

**Author:** Data Analytics Team  
**Tool:** SQL Server (AdventureWorks2022)  
**KPI Category:** Product Performance Analysis  
