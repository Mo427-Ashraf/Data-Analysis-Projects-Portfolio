# 📊 Sales Analysis Report (Excel Project)

Comprehensive retail performance insights using **Excel PivotTables, Slicers, and Interactive Dashboards**.

---

## 📘 Project Overview
This project analyzes a retail sales dataset to uncover business insights regarding:

- Top-performing product categories and items  
- Geographic sales distribution  
- Shipping mode behavior  
- Seasonal and monthly demand trends  
- Profitability by location and product types  

All analysis and visualizations were built using **Microsoft Excel** without external BI tools.

---

## 📂 Dataset Information

**File:** `Sales Analysis Using PivotTables, Dashboard, Slicers.xlsx`  
**Total Records:** Retail sales transactions (Superstore-style dataset)

### Key Fields
| Field | Description |
|-------|-------------|
| Order Date | Date of purchase |
| Ship Mode | Delivery option selected |
| State / City | Geographic customer information |
| Category | Product’s high-level grouping |
| Sub-Category | Detailed product type |
| Product Name | Specific product |
| Quantity | Units sold |
| Sales | Revenue amount |
| Profit | Income after cost |

---

## 🧮 Data Preparation
- Removed duplicates and missing fields  
- Formatted dataset as **Excel Table** for dynamic range updates  
- Validated numeric/date fields  
- Built PivotTables to answer business questions  
- Applied financial formatting and slicers for interactivity  

---

## 🧱 PivotTable Outputs

### ✅ Overall Sales Metrics
| Metric | Result |
|--------|--------|
| **Total Sales** | $2,297,200.86 |
| **Average Sales** | ~$229.86 |
| **Max Sales** | ~$22,638.48 |
| **Min Sales** | ~$0.44 |

---

### ✅ Total Sales by Category
| Category | Total Sales |
|----------|-------------|
| Furniture | $741,999.80 |
| Office Supplies | $719,047.03 |
| Technology | $836,154.03 |
| **Grand Total** | **$2,297,200.86** |

🔍 Technology leads with the highest revenue contribution.

---

### ✅ Top 2 Sub-Categories by Total Sales
| Sub-Category | Total Sales |
|--------------|-------------|
| Chairs | $328,449.10 |
| Phones | $330,007.05 |
| **Grand Total** | **$658,456.16** |

Chairs and Phones dominate the product mix.

---

### ✅ Top 3 States by Total Sales
| State | Total Sales |
|-------|------------|
| California | $457,687.63 |
| New York | $310,876.27 |
| Texas | $170,188.05 |

These three states generate **40%+** of total revenue.

---

### ✅ Top 10 Products by Total Sales
| Product Name | Sales |
|--------------|------|
| Canon imageCLASS 2200 A | $61,599.82 |
| Cisco TelePresence System | $22,638.48 |
| Fellowes PB500 Electric Punch | $27,453.38 |
| GBC DocuBind P400 Electric | $17,965.07 |
| GBC DocuBind TL300 Electric | $19,823.48 |
| GBC Ibimaster 500 Manual | $19,024.50 |
| Hewlett Packard LaserJet | $18,839.69 |
| High Speed Automatic Electric | $17,030.31 |
| HON 5400 Series Task Chairs | $21,870.58 |
| HP Designjet T520 Inkjet | $18,374.90 |
| **Total** | **$244,620.20** |

---

### ✅ Bottom 10 Products by Total Sales
| Product Name | Sales |
|--------------|------|
| 4009 Highlighters | $8.04 |
| Avery 5 | $5.76 |
| Avery Hi-Liter Comfort Grip | $7.80 |
| Avery Hi-Liter Pen Style | $7.70 |
| Eureka Disposable Bags | $1.62 |
| Grip Seal Envelopes | $7.07 |
| Newell 308 | $8.40 |
| Stockwell Gold Paper Clips | $8.10 |
| Xerox 1989 | $7.97 |
| Xerox 20 | $6.48 |
| **Total** | **$68.94** |

---

### ✅ Sales Quantity by Sub-Category
| Sub-Category | Total Sales | Total Quantity |
|--------------|-------------|----------------|
| Chairs | $328,449.10 | 2356 |
| Phones | $330,007.05 | 3289 |
| **Grand Total** | **$658,456.16** | **5645** |

---

### ✅ #Orders by State
> Created using PivotTable count of order IDs  
> Supports geographic decision making and territory prioritization  

---

## 🎛 Slicers for User Interactivity
- Ship Mode  
- City  


These slicers are **synchronized** across all PivotTables.

---

## 📊 Dashboard Summary

📌 Executive Sales Dashboard  
![Sales Dashboard](Staticdashboard.png)

Main visual insights include:

- **Sales by Product** (Top performers highlighted)
- **Monthly Order Quantity** trend line chart
- **Sales by Region** pie chart
- **Category quantity comparison across multiple years**

Dashboard formatted with:

- Neutral gray theme for executive readability  
- Data labels for immediate consumption  
- Clean layout enabling drill-down navigation  

---

## 💡 Key Insights
1. Technology holds the largest share of revenue.
2. Chairs and Phones are core revenue drivers.
3. California is the most valuable market.
4. A few high-value items deliver a significant revenue share.
5. Several products are significantly underperforming.
6. Seasonality exists, with higher demand in later months.

---

## 📁 Project Files
| File | Description |
|------|-------------|
| Excel workbook | Full dataset, PivotTables, and dashboard |
| Dashboard screenshot | Executive overview visualization |
| PivotTable screenshots | Supporting analytics views |

---

## 🏁 Conclusion
This project demonstrates how Excel is capable of **professional BI reporting**, enabling:

- Profit and product performance insights  
- State-level revenue evaluation  
- Data-driven inventory and sales strategy decisions  

This report can be expanded into **Power BI or Tableau** for deeper analytics and drill-through reporting.

---

© 2025 – Sales Analytics Dashboard in Excel
