# 📊 AE Company — Sales Performance Tracking (Power BI)
![Sales Overview](Sales%20Overview.png)
Comprehensive sales performance analysis and dashboarding project for AE Company. This project uses CSV data sources, Power Query transformations, a star-schema Power BI data model, DAX measures, and a multi-page Power BI report to analyze sales, customers, product performance, order trends, and market contribution.

The repository demonstrates an end-to-end business intelligence workflow: prepare source data, model relationships, create measures, design report pages, and communicate insights through an interactive Power BI dashboard.

## Table of contents

- [Project overview](#project-overview)
- [Dataset & schema](#dataset--schema)
- [Data model](#data-model)
- [Data preparation & cleaning](#data-preparation--cleaning)
- [Data validation snapshot](#data-validation-snapshot)
- [DAX measures (Power BI)](#dax-measures-power-bi)
- [Dashboard pages & visuals](#dashboard-pages--visuals)
- [Key business insights](#key-business-insights)
- [Business recommendations](#business-recommendations)
- [Repository files](#repository-files)

---

## Project overview

This project analyzes AE Company sales performance across countries, products, customer segments, and time periods. The goal is to give business stakeholders a clear view of revenue drivers, customer behavior, product-line performance, and monthly sales trends.

Core deliverables:

- Cleaned CSV data sources for customers, products, and sales transactions
- Star-schema Power BI model with `Fact_Sales` as the central fact table
- DAX measures for sales, orders, quantity, customers, and average order value
- Multi-page Power BI report covering overview, customer analysis, and product analysis
- Dashboard screenshots and PDF export for portfolio presentation

Main KPIs shown in the dashboard:

| KPI | Value |
|---|---:|
| Total Sales | `$29.36M` |
| Total Orders | `27.7K` |
| Customers | `18.5K` |
| Total Quantity | `60.42K` |
| Average Order Value | `$1.06K` |

---

## Dataset & schema

The project uses three main CSV files.

| File | Role | Description |
|---|---|---|
| `sales _dt.csv` | Fact table | Sales transactions including order, product, quantity, price, sales amount, dates, and customer ID |
| `dim_customers.csv` | Dimension table | Customer profile data including country, marital status, gender, birthdate, and account creation date |
| `dim_products.csv` | Dimension table | Product details including product name, category, subcategory, product line, and start date |

Important fields used:

### `sales _dt.csv`

- `Order_id`
- `Product_id`
- `Quantity`
- `Price`
- `Sales_amount`
- `Order_date`
- `Shiping_date`
- `Due_datw`
- `Customer_id`

> Note: The raw sales file contains spelling inconsistencies such as `Shiping_date` and `Due_datw`. In the Power BI model, these should be standardized as `Shipping_date` and `Due_date`.

### `dim_customers.csv`

- `customer_id`
- `first_name`
- `last_name`
- `country`
- `marital_status`
- `gender`
- `birthdate`
- `create_date`

### `dim_products.csv`

- `product_id`
- `product_name`
- `category_id`
- `category_name`
- `subcategory`
- `product_line`
- `start_date`

---


---

## Data model

The Power BI model follows a star-schema style design with `Fact_Sales` as the central fact table and dimension tables for customers, products, and dates.

![Data model diagram](The%20Data%20Model.png)

Model structure:

- `Fact_Sales` stores sales transactions and numeric measures.
- `dim_customers` connects to `Fact_Sales` through `customer_id` / `Customer_id`.
- `dim_products` connects to `Fact_Sales` through `product_id` / `Product_id`.
- `DimDate` supports time-based filtering and trend analysis using order, shipping, and due dates.

Benefits of this model:

- Cleaner filtering across report pages
- Better report performance
- Reusable dimensions for multiple visuals
- Simpler DAX measures
- Easier separation between descriptive fields and transactional metrics

---

## Data preparation & cleaning

Main preparation steps:

1. Loaded CSV files into Power BI using Power Query.
2. Verified data types for dates, numeric fields, and IDs.
3. Standardized spelling issues in date columns:
   - `Shiping_date` → `Shipping_date`
   - `Due_datw` → `Due_date`
4. Removed or ignored duplicate/unneeded fields where appropriate, such as repeated order ID columns.
5. Created or used a `DimDate` table for year, quarter, month, and month-number analysis.
6. Built relationships between the fact table and dimension tables.
7. Created KPI measures for sales, quantity, orders, customers, and AOV.
8. Designed slicers for interactive filtering by time period, country, gender, marital status, category, product line, and subcategory.

---

## Data validation snapshot

The following validation metrics were calculated from the source CSV files.

| Metric | Value |
|---|---:|
| Customer records | `18,484` |
| Product records | `295` |
| Sales transaction rows | `60,398` |
| Total Sales Amount | `$29,356,250` |
| Total Quantity | `60,423` |
| Distinct Orders | `27,659` |
| Distinct Customers in Sales | `18,484` |
| Distinct Products Sold | `130` |

Top countries by sales:

| Country | Sales |
|---|---:|
| United States | `$9.16M` |
| Australia | `$9.06M` |
| United Kingdom | `$3.39M` |
| Germany | `$2.89M` |
| France | `$2.64M` |
| Canada | `$1.98M` |

Top product categories by sales:

| Category | Sales |
|---|---:|
| Bikes | `$28.32M` |
| Accessories | `$0.70M` |
| Clothing | `$0.34M` |

Top product lines by sales:

| Product line | Sales |
|---|---:|
| Road | `$14.62M` |
| Mountain | `$10.25M` |
| Touring | `$3.88M` |
| Other Sales | `$0.60M` |

---

## DAX measures (Power BI)

The report uses DAX measures to calculate key metrics. The formulas below are representative measures for this type of model and may need minor naming adjustments depending on the exact table and column names in Power BI.

| Measure | DAX formula | Description |
|---|---|---|
| Total Sales | `SUM(Fact_Sales[Sales_amount])` | Calculates total revenue |
| Total Quantity | `SUM(Fact_Sales[Quantity])` | Calculates total units sold |
| Total Orders | `DISTINCTCOUNT(Fact_Sales[Order_id])` | Counts unique orders |
| Total Customers | `DISTINCTCOUNT(dim_customers[customer_id])` | Counts unique customers |
| Average Order Value | `DIVIDE([Total Sales], [Total Orders])` | Calculates average revenue per order |
| Products Sold | `DISTINCTCOUNT(Fact_Sales[Product_id])` | Counts distinct sold products |

Example DAX measure definitions:

```DAX
Total Sales =
SUM(Fact_Sales[Sales_amount])
```

```DAX
Total Quantity =
SUM(Fact_Sales[Quantity])
```

```DAX
Total Orders =
DISTINCTCOUNT(Fact_Sales[Order_id])
```

```DAX
Total Customers =
DISTINCTCOUNT(dim_customers[customer_id])
```

```DAX
Average Order Value =
DIVIDE([Total Sales], [Total Orders])
```

```DAX
Orders by Year =
CALCULATE(
    [Total Orders],
    ALLEXCEPT(DimDate, DimDate[Year])
)
```

```DAX
Sales by Product Line =
CALCULATE(
    [Total Sales],
    ALLEXCEPT(dim_products, dim_products[product_line])
)
```

---

## Dashboard pages & visuals

The Power BI report contains three main dashboard pages.

### Page 1 — Sales Overview

The overview page gives stakeholders a high-level view of company performance.

![Sales Overview](Sales%20Overview.png)

Main visuals:

- KPI cards for Total Sales, Total Orders, Customers, Total Quantity, and AOV
- Total Sales by country treemap
- Sales by Category bar chart
- Percentage of Orders by Marital Status donut chart
- Total Orders by Year column chart
- Monthly Sales Trend area/line chart
- Slicers for Month, Year, Quarter, Sub_Category, Gender, and Country

Key observations:

- Total sales are approximately `$29M`.
- Bikes dominate category-level revenue.
- United States and Australia are the strongest sales markets.
- Married customers represent a slightly higher order share than single customers.
- Monthly sales trend rises toward the end of the year, with December appearing as the strongest month.

---

### Page 2 — Customers Analysis

The customers page focuses on customer behavior, demographics, and top customer contribution.

![Customers Analysis](Customers%20Analysis.png)

Main visuals:

- KPI cards for Total Orders, Customers, and AOV
- Total Sales by country bar chart
- Total Orders by Age Group column chart
- Decomposition tree by Quarter and Age Group
- Top 10 Customers by Total Sales bar chart
- Percentage of Orders Generated by Gender donut chart
- Slicers for Year, Quarter, Month, Marital Status, Gender, and Country

Key observations:

- The `50–64` age group generates the highest order volume.
- The United States and Australia lead country-level sales.
- Q4 contributes strongly to total sales.
- The visible gender chart shows almost all orders generated by male customers.
- Top customers include Jordan Turner, Willie Xu, Kaitlyn Henderson, Nichole Nara, Margaret He, Randall Dominguez, Adriana Gonzalez, Rosa Hu, Brandi Gill, and Brad She.

---

### Page 3 — Products Analysis

The products page explains revenue contribution across products, product lines, and categories.

![Products Analysis](Products%20Analysis.png)

Main visuals:

- KPI cards for Total Sales, Total Quantity, and AOV
- Top 10 Products by Sales bar chart
- Total Sales by Product Line bar chart
- Decomposition tree by product line and category
- Percentage of Orders by Product Line donut chart
- Number of Customers by Category treemap
- Slicers for Year, Quarter, Month, Category, Product Line, and Subcategory

Key observations:

- Road products generate the highest sales, followed by Mountain products.
- Bikes are the strongest product category by sales and customer count.
- Accessories and Clothing contribute significantly less revenue than Bikes.
- The top-selling products are mainly Mountain and Road bike products.

Top products by sales:

| Product | Sales |
|---|---:|
| Mountain-200 Black- 46 | `$1.37M` |
| Mountain-200 Black- 42 | `$1.36M` |
| Mountain-200 Silver- 38 | `$1.34M` |
| Mountain-200 Silver- 46 | `$1.30M` |
| Mountain-200 Black- 38 | `$1.29M` |
| Mountain-200 Silver- 42 | `$1.26M` |
| Road-150 Red- 48 | `$1.21M` |
| Road-150 Red- 62 | `$1.20M` |
| Road-150 Red- 52 | `$1.08M` |
| Road-150 Red- 56 | `$1.06M` |

---

## Key business insights

- **Bikes drive nearly all revenue.** Bikes generate about `$28.32M`, far ahead of Accessories and Clothing.
- **Road and Mountain product lines are the strongest performers.** Road contributes about `$14.62M`, while Mountain contributes about `$10.25M`.
- **United States and Australia are the top markets.** Each contributes about `$9M` in sales.
- **Late-year performance is strong.** Monthly sales increase toward the end of the year, with December appearing as the highest sales month.
- **Older customer segments are important.** The `50–64` age group has the highest order volume on the customer analysis page.
- **Top customers are visible revenue contributors.** The customer page highlights a small group of high-value customers that can support loyalty and retention strategies.

---

## Business recommendations

- Prioritize marketing, inventory, and promotional planning around Bikes, especially Road and Mountain product lines.
- Strengthen sales campaigns in the United States and Australia, which are the strongest markets.
- Investigate why Accessories and Clothing contribute less revenue and consider cross-sell campaigns with bike purchases.
- Build retention programs for high-value customers identified in the top-customer analysis.
- Use late-year sales strength to plan promotions, stock availability, and operational capacity before peak months.
- Add profit, margin, and cost data in a future version to move from revenue analysis to profitability analysis.

---

## Repository files

| File | Description |
|---|---|
| `Task_Pbi-2.pbix` | Main Power BI report file |
| `AE Company Performance Analysis.pdf` | PDF export of dashboard pages |
| `Sales Overview.png` | Screenshot of the overview dashboard page |
| `Customers Analysis.png` | Screenshot of the customer analysis dashboard page |
| `Products Analysis.png` | Screenshot of the product analysis dashboard page |
| `The Data Model.png` | Screenshot of the Power BI data model |
| `dim_customers.csv` | Customer dimension data |
| `dim_products.csv` | Product dimension data |
| `sales _dt.csv` | Sales fact data |
| `README.md` | Project documentation file |

---
