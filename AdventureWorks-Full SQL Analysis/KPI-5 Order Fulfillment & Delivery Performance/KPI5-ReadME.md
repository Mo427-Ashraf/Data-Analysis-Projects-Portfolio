# 🚚 KPI 5: Order Fulfillment & Delivery Performance

**Domain:** Operations & Logistics  
**Database:** AdventureWorks2022  

---

## 🎯 Definition
**Core Formulae:**
- Average Delivery Time = AVG(DATEDIFF(DAY, OrderDate, ShipDate))  
- On-Time % = Orders delivered ≤ 5 days ÷ Total Shipped Orders × 100  
- Delayed % = Orders delivered > 5 days ÷ Total Shipped Orders × 100  

---

## 💼 Business Purpose
This KPI evaluates the **efficiency and reliability** of order delivery.  
It helps:
1. Monitor **average shipping duration**.  
2. Measure **on-time vs delayed performance**.  
3. Identify **regions or salespersons** with poor delivery metrics.  
4. Detect **customer impact** from recurring delays.  
5. Optimize **logistics and SLA adherence**.

---

## 🧠 SQL Logic Overview
| Query # | Purpose | Description |
|----------|----------|-------------|
| 5.1 | Avg Delivery Days | Measures mean time from order to shipment. |
| 5.2 | On-Time vs Delayed | Classifies and computes % share. |
| 5.3 | Longest Deliveries | Finds top 10 extreme delays. |
| 5.4 | Territory Performance | Average delivery days per region. |
| 5.5 | Delayed Customers | Top customers with >7-day delays. |
| 5.6 | Delays per Quarter | Tracks delay trends across time. |
| 5.7 | Delays by Salesperson | Measures salesperson-linked inefficiency. |

---

## 📊 Recommended Visualizations
- **Pie Chart:** On-time vs Delayed %  
- **Line Chart:** Average delivery days by year or quarter  
- **Bar Chart:** Territories ranked by delay time  
- **Table:** Top delayed customers or salespersons  
- **KPI Card:** Average delivery days (current vs target)  

---

## 💡 Insights & Applications
- Reveals **logistical performance bottlenecks**.  
- Highlights **territories or staff needing improvement**.  
- Tracks **delivery consistency** over time.  
- Directly influences **customer satisfaction and retention**.  
- Supports **KPI-based performance bonuses or penalties**.

---

**Author:** Data Analytics Team  
**Tool:** SQL Server (AdventureWorks2022)  
**KPI Category:** Operational Efficiency  
