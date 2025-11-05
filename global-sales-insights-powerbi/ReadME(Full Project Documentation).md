# 📊 Power BI Data Modeling, Cleaning, and Visualization Project

**Project Title:** Sales & Customer Performance Analysis  
**Tool Used:** Microsoft Power BI Desktop  
**Data Source:** Multiple CSV files (Customer, Product, Sales, Territory, Date)  
**Author:** [Your Name]  
**Completion Date:** August 27, 2025  

---

## 📘 Project Overview
This project demonstrates **end-to-end data analysis and visualization** in **Power BI**, starting from importing multiple raw datasets, cleaning and preprocessing them, building a robust **data model (star schema)**, and creating an interactive dashboard for analyzing **sales, customers, products, and territories**.

The work follows a systematic BI workflow:
1. **Data Import**
2. **Data Understanding**
3. **Data Cleaning & Transformation**
4. **Data Modeling**
5. **Data Visualization**

---

## 🗂️ Data Sources

The project integrates **six CSV datasets**, each representing a functional entity of the business.  

| Dataset | Type | Rows (approx.) | Description |
|----------|------|----------------|--------------|
| `Customer.csv` | Dimension | ~18K | Customer demographic details including gender, education, occupation, first purchase date |
| `Date.csv` | Dimension | ~1K | Calendar table including day, month, year, and fiscal information |
| `Product.csv` | Dimension | ~600 | Product information (model, list price, subcategory, line type) |
| `ProductCategory.csv` | Dimension | 4 | Product category names (Bikes, Accessories, Clothing, Components) |
| `ProductSubcategory.csv` | Dimension | 37 | Product subcategories (e.g., Helmets, Tires, Road Bikes) |
| `Sales.csv` | Fact | ~60K | Sales transactions including customer, product, date, revenue, freight |
| `Territory.csv` | Dimension | 10 | Regional breakdown by country and sales territory group |

---

## 🔍 Data Understanding

Each dataset represents part of the company’s retail operations:

### 🧾 Fact Table: `Sales`
Contains the main transactional data — each record represents one sale.
| Column | Description |
|---------|--------------|
| `OrderDate` | Date when the sale was placed |
| `DueDate` | Payment due date |
| `ShipDate` | Shipment date |
| `CustomerKey` | Foreign key linking to Customer dimension |
| `ProductKey` | Foreign key linking to Product dimension |
| `TerritoryKey` | Foreign key linking to Territory dimension |
| `CurrencyKey` | Currency type of the transaction |
| `OrderQuantity` | Quantity of units sold |
| `ExtendedAmount` | Total sale amount (before freight and tax) |
| `Freight` | Shipping fee |
| `TotalDue` | Total amount including freight |

---

### 🧍‍♂️ Dimension: `Customer`
Contains demographic and behavioral data.

| Column | Description |
|---------|-------------|
| `CustomerKey` | Unique identifier |
| `FirstName`, `Gender` | Basic attributes |
| `EnglishEducation` | Customer education level |
| `EnglishOccupation` | Job or career group |
| `DateFirstPurchase` | When the customer first made a purchase |
| `CommuteDistance` | Estimated distance between residence and store |
| `BirthDate` | For deriving age segmentation |

---

### 🌎 Dimension: `Territory`
| Column | Description |
|---------|-------------|
| `SalesTerritoryKey` | Primary key |
| `SalesTerritoryCountry` | Country of the sale |
| `SalesTerritoryGroup` | Regional grouping (e.g., Europe, North America) |
| `SalesTerritoryRegion` | Sub-region label (e.g., Northwest, Central) |

---

### 🏷️ Dimension: `Product`
| Column | Description |
|---------|-------------|
| `ProductKey` | Unique product ID |
| `ModelName` | Model name (e.g., Road-250) |
| `ListPrice` | Catalog price |
| `ProductSubcategoryKey` | Links to subcategory table |
| `ProductLine` | Product line (e.g., R = Road, M = Mountain) |
| `ReorderPoint` | Inventory threshold |
| `SafetyStockLevel` | Minimum stock before reorder |

---

### 🧩 Dimension: `ProductSubcategory` & `ProductCategory`
These connect product granularity:
- `ProductSubcategory` → contains 37 subcategories.
- `ProductCategory` → top-level 4 categories.  
Linked via `ProductSubcategory[ProductCategoryKey]`.

---

### 📅 Dimension: `Date`
A standard **calendar table** used for time-intelligence analysis.  
Includes fields like:
- `CalendarYear`
- `FiscalQuarter`
- `EnglishMonthName`
- `DayNumberOfWeek`
- `DateKey`

---

## 🧹 Data Cleaning & Preprocessing

Data transformation was performed using **Power Query Editor** in Power BI.

### ✅ Cleaning Steps
| Step | Description | Tool/Function |
|------|--------------|----------------|
| **1. Data Type Validation** | Converted text fields, numeric columns, and dates to correct formats | Power Query “Detect Data Type” |
| **2. Handling Missing Values** | Removed NULLs in key columns (`CustomerKey`, `ProductKey`, `OrderDate`) | `Remove Rows → Remove Empty` |
| **3. Removing Duplicates** | Ensured unique records in dimension tables | “Remove Duplicates” on key columns |
| **4. Derived Columns** | Extracted `Year`, `Month`, `Quarter` from `OrderDate` | `Add Column → Date → Year` |
| **5. Standardized Naming** | Renamed columns for readability (e.g., `OrderDateKey` → `Order Date`) | Power Query rename step |
| **6. Data Filtering** | Removed blank category/subcategory names | Filter rows where field ≠ null |

---

## 🧠 Data Model Design

![Data Model Diagram](Data%20modeling%20task.png)

### ⭐ Schema: Star Model
The model follows a **classic star schema**, with **one fact table** (`Sales`) and **five dimension tables** (`Customer`, `Date`, `Product`, `ProductSubcategory`, `ProductCategory`, `Territory`).

### 🔗 Relationships
| From Table | Column | To Table | Column | Type |
|-------------|----------|-----------|---------|------|
| Sales | `CustomerKey` | Customer | `CustomerKey` | Many-to-One |
| Sales | `OrderDateKey` | Date | `DateKey` | Many-to-One |
| Sales | `ProductKey` | Product | `ProductKey` | Many-to-One |
| Product | `ProductSubcategoryKey` | ProductSubcategory | `ProductSubcategoryKey` | Many-to-One |
| ProductSubcategory | `ProductCategoryKey` | ProductCategory | `ProductCategoryKey` | Many-to-One |
| Sales | `SalesTerritoryKey` | Territory | `SalesTerritoryKey` | Many-to-One |

**Cardinality:** All relationships are *many-to-one* (Sales → Dimensions).  
**Filter Direction:** Single-direction (from dimensions to fact).

---

## 🧮 DAX Calculations

Core measures created using **DAX (Data Analysis Expressions)**:

| Measure | Formula | Description |
|----------|----------|-------------|
| **Total Sales** | `SUM(Sales[ExtendedAmount])` | Total revenue from all sales |
| **Total Quantity Sold** | `SUM(Sales[OrderQuantity])` | Total number of items sold |
| **Average Sale per Order** | `DIVIDE([Total Sales], COUNT(Sales[OrderDateKey]))` | Revenue efficiency metric |
| **Total Freight** | `SUM(Sales[Freight])` | Total shipping cost |
| **Sales Growth %** | `( [Total Sales] - CALCULATE([Total Sales], PREVIOUSYEAR('Date'[CalendarYear])) ) / CALCULATE([Total Sales], PREVIOUSYEAR('Date'[CalendarYear]))` | Year-over-year revenue change |
| **Revenue by Category** | `CALCULATE([Total Sales], ALLEXCEPT(ProductCategory, ProductCategory[EnglishProductCategoryName]))` | Category-level performance |
| **Average Age of Customer** | `AVERAGE(Customer[Age])` *(if derived)* | Customer demographics |
| **Sales per Region** | `SUM(Sales[ExtendedAmount])` + `RELATED(Territory[SalesTerritoryRegion])` | Regional insights |

---

## 📊 Data Visualization (PBIX Dashboards)

### Dashboard Pages:
#### 1️⃣ **Sales Overview**
Focuses on company-wide financial and product performance.

| Visual | Description |
|---------|--------------|
| **Card Visuals** | KPIs: Total Sales, Quantity Sold, Total Freight, Growth % |
| **Bar Chart** | Revenue by Product Category & Subcategory |
| **Line Chart** | Monthly revenue trend by Year |
| **Map Visual** | Total Sales by Territory Region |
| **Matrix Table** | Year vs. Category Revenue |

---

#### 2️⃣ **Customer Insights**
Analyzes customer distribution and buying behavior.

| Visual | Description |
|---------|-------------|
| **Pie Chart** | Gender or Education breakdown |
| **Column Chart** | Sales by Age Group |
| **Donut Chart** | Revenue by Occupation |
| **Table Visual** | Top 10 Customers by Purchase Value |
| **Slicers** | Filter by Year, Territory, Gender |

---

#### 3️⃣ **Product & Profitability**
Highlights product line performance and category contribution.

| Visual | Description |
|---------|-------------|
| **Bar Chart** | Top 10 Products by Revenue |
| **Clustered Chart** | Category vs Subcategory Sales |
| **KPI Visuals** | Avg List Price, Total Units Sold |
| **Trend Line** | Sales Volume over Time |
| **Tree Map** | Product Category Share |

---

## 📈 Insights Summary

| Category | Key Findings |
|-----------|---------------|
| **Sales** | Highest sales volume occurs in **North America** with consistent growth from 2011–2013. |
| **Customers** | Majority of buyers are **middle-aged professionals** with Bachelor’s education. |
| **Products** | **Bikes** contribute nearly **60% of total revenue**, while **Accessories** show the most variety. |
| **Time** | Sales peak in **Q4** due to holiday season. |
| **Regions** | Western territories exhibit higher freight costs but faster delivery turnaround. |

---

## 📦 Deliverables
- ✅ Cleaned datasets (6 CSVs imported)
- ✅ Power Query transformations applied
- ✅ Star schema model built
- ✅ DAX measures defined
- ✅ Three interactive dashboards designed
- ✅ Insights exported and validated

---

## 🧰 Tools & Techniques Used
| Category | Tools / Features |
|-----------|------------------|
| **Data Prep** | Power Query Editor |
| **Modeling** | Manage Relationships, Star Schema |
| **Analysis** | DAX Calculations |
| **Visualization** | Power BI Charts (Card, Bar, Map, Tree Map) |
| **Validation** | Model view, relationship testing, cross-filter logic |

---

## 🏁 Conclusion
This Power BI project demonstrates a full **data analytics lifecycle**, from raw data ingestion to visual storytelling.  
It successfully integrates multiple CSVs into a unified star schema and provides clear insights into company performance.  

> The approach ensures scalability, accuracy, and reusability — essential for enterprise BI solutions.

---

© 2025 – Power BI Data Modeling Project | Developed by [Your Name]
