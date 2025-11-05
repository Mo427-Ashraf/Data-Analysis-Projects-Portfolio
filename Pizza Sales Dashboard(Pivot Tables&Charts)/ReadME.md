# 🍕 Pizza Sales Dashboard – Excel Data Analytics Project

**Tool Used:** Microsoft Excel  
**Dataset:** Pizza Sales Dataset (`Pizza_Dataset.xlsx`)  
**Techniques:** Pivot Tables • Pivot Charts • Data Cleaning • Dashboard Design • KPI Metrics • Trend Analysis  
**Objective:** Analyze pizza sales performance and visualize key business insights across categories, sizes, and time trends.

---

## 📘 Project Overview
This project involved developing a fully interactive **Excel dashboard** to analyze pizza sales performance.  
The goal was to uncover insights related to revenue, sales trends, and product popularity, using Excel’s data modeling and visualization features.

The analysis focused on:
- Identifying top and bottom-performing pizzas  
- Tracking total orders and quantities across time  
- Understanding sales patterns by category, size, and time of day  

---

## 🧹 Data Preparation

**Steps performed in Excel:**
1. **Data Cleaning:**  
   - Verified numerical columns (`total_price`, `quantity`, `total_orders`) for missing or inconsistent data.  
   - Standardized date fields for daily, monthly, and hourly analysis.  

2. **Data Model Setup:**  
   - Built Pivot Tables for KPIs and sub-analyses.  
   - Used multiple Pivot Charts linked to slicers for real-time filtering.

---
## 📊 Pivot Tables Analysis

To summarize and visualize key sales metrics, multiple **Pivot Tables** were built across the workbook:

| Pivot Table | Purpose | Key Fields Used |
|--------------|----------|----------------|
| **KPI Cards** | Calculated Total Revenue, Orders, Quantity, AOV, Avg Pizzas per Order | `total_price`, `total_orders`, `quantity` |
| **Total Orders by Day of Week** | Identified busiest sales days | `order_date`, `order_id` |
| **Total Orders by Month** | Analyzed monthly order trends | `order_date`, `total_orders` |
| **Total Orders by Hour** | Mapped hourly order behavior | `order_hour`, `order_id` |
| **Revenue by Pizza Category** | Compared total revenue across pizza categories | `pizza_category`, `total_price` |
| **Revenue by Pizza Size** | Evaluated contribution of each size | `pizza_size`, `total_price` |
| **Quantity by Pizza Category** | Tracked share of units sold by category | `pizza_category`, `quantity` |
| **Top 5 / Bottom 5 Pizzas** | Ranked pizzas by total quantity sold | `pizza_name`, `quantity` |

**Pivot Table Operations:**
- Applied **SUM**, **COUNT**, and **AVERAGE** functions to compute aggregates.  
- Used **Value Filters** to isolate top/bottom performers.  
- Added **Slicers** for `Month`, `Pizza Category`, and `Pizza Size` to connect multiple tables.  
- Linked all pivot tables to the **Dashboard** sheet to automatically refresh metrics.

---

## 📊 KPIs (Key Performance Indicators)

| KPI | Formula | Description |
|------|----------|-------------|
| **Total Revenue** | `SUM(total_price)` | Overall sales revenue |
| **Total Orders** | `COUNT(total_orders)` | Total number of orders placed |
| **Total Quantity Sold** | `SUM(quantity)` | Total pizzas sold |
| **Average Order Value (AOV)** | `SUM(total_price) / SUM(total_orders)` | Avg. spending per order |
| **Average Pizzas per Order** | `SUM(quantity) / SUM(total_orders)` | Avg. number of pizzas in each order |

**Dashboard Results:**
- **Total Revenue:** $817,860  
- **Total Quantity Sold:** 49,574  
- **Total Orders:** 21,350  
- **AOV:** $38.3  
- **Avg. Pizzas per Order:** 2.32  

---

## 📈 Trend Analysis

| Trend | Description | Visual |
|--------|--------------|--------|
| **Monthly Orders Trend** | Tracks total orders per month (Jan–Dec). | Line Chart |
| **Hourly Orders Trend** | Shows order volume by time of day. | Area Chart |
| **Day of Week Distribution** | Highlights busiest days for orders. | Tree Map |

**Insights:**  
- **Friday** and **Saturday** record the highest sales, with over 3,000+ orders weekly.  
- Orders peak between **6 PM and 8 PM**, showing evening demand dominance.  

---

## 🍕 Product Sales Insights

| Category | Example Analysis | Visual Used |
|-----------|------------------|--------------|
| **Top 5 Best-Selling Pizzas** | Classic Deluxe, BBQ Chicken, Hawaiian, Pepperoni, Thai Chicken | Horizontal Bar Chart |
| **Bottom 5 Least-Selling Pizzas** | Brie Carre, Mediterranean, Calabrese, Spinach Supreme, Soppressata | Bar Chart |
| **Sales by Category** | Classic pizzas lead with **$220K revenue (30%)** | Column Chart + Pie Chart |
| **Sales by Size** | Large pizzas generate **46% of total revenue ($375K)** | Bar Chart |

**Insights:**  
- **Classic pizzas** are the top revenue drivers (≈30% of total sales).  
- **Large-sized pizzas** dominate order volume and profit share.  
- **Small/XL sizes** contribute minimally to total revenue.  

---

## 📊 Dashboard Structure

**Sheets in the Workbook:**
1. `pizza_sales` → Raw dataset (cleaned and standardized)  
2. `Pivot Tables Analysis` → Data aggregation and KPIs  
3. `Dashboard` → Interactive visuals and slicers  

### Dashboard Components:
- **KPI Cards:** Total Revenue, Orders, Quantity, AOV, Avg Pizzas/Order  
- **Trend Charts:** Orders by Month, Hourly Order Distribution  
- **Category & Size Analysis:** Revenue and Quantity breakdowns  
- **Best & Worst Sellers:** Top 5 and Bottom 5 pizzas  
- **Slicers:** Filters for Month, Pizza Category, and Pizza Size  

---

## 🎨 Design & Visualization Highlights
- Used **consistent color palette** (Orange–Black theme) for readability and brand tone.  
- Added **pizza-themed icons** and **gradient card visuals** for aesthetic appeal.  
- Used **slicers** for `Month`, `Pizza Category`, and `Pizza Size` to enable dynamic filtering.  
- Optimized chart layouts to fit a **single-page interactive dashboard view**.  

---

## 📈 Key Insights Summary

| Category | Observation |
|-----------|--------------|
| **Best Day** | Friday – 3,538 orders |
| **Top Pizza** | Classic Deluxe Pizza – 2,453 units sold |
| **Weakest Product** | Brie Carre Pizza – 490 units sold |
| **Top Size** | Large – $375,319 revenue |
| **Top Category** | Classic – $220,053 revenue |
| **Low Season** | September (1,661 total orders) |

---

## ⚙️ Tools & Techniques Used
**Excel Features:** Pivot Tables, Pivot Charts, Slicers, Data Validation, Conditional Formatting 
**Visualization Techniques:** Bar Charts • Line Charts • Pie Charts • Tree Maps • KPI Cards • Custom Theme Formatting  

---

## 🏁 Project Outcome
This dashboard enables **real-time performance tracking** for the pizza shop’s sales, highlighting top-performing pizzas, time-based sales patterns, and customer preferences.  

**Business Impact:**
- Identified best-selling pizza types and profitable size categories.  
- Optimized operations around high-demand time periods.  
- Delivered actionable insights for marketing and inventory management.  

---

## 🔧 Tools Summary
**Tools Used:** Microsoft Excel  
**Techniques:** PivotTables • Data Cleaning • Visualization • KPI Metrics • Dashboard Design  
**Skills Demonstrated:** Data Analytics • Excel Dashboarding • Business Intelligence • Visualization • Storytelling  

---

📂 **Dashboard Preview**

![Pizza Sales Dashboard](Dashboard(1).png)
