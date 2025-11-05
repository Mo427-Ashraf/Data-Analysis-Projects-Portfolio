

USE AdventureWorks2022;


--4.1 Get total count of one-time vs repeat customers.
--Purpose: Measures customer loyalty by comparing first-time buyers to repeat buyers.
WITH CustomerTypes AS (
SELECT  CustomerID,
CASE WHEN COUNT(*) > 1 THEN 'Repeated Customer' 
  ELSE 'One-Time Customer' 
 END AS Customer_Type
 FROM Sales.SalesOrderHeader
 GROUP BY CustomerID
)
SELECT Customer_Type,COUNT(*) AS Customers_Count
FROM CustomerTypes
GROUP BY Customer_Type;

--4.2 Get percentage of one-time vs repeat customers.
--Purpose: Shows the percentage share of one-time and repeat buyers.
WITH CustomerTypes AS (
SELECT  CustomerID,
CASE WHEN COUNT(*) > 1 THEN 'Repeated Customer' 
  ELSE 'One-Time Customer' 
 END AS Customer_Type
 FROM Sales.SalesOrderHeader
 GROUP BY CustomerID
)
SELECT Customer_Type,COUNT(*) As TYPE_COUNT,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 3) AS Percentage 
FROM CustomerTypes
GROUP BY Customer_Type;

--4.3 Get top 10 customers with the highest number of orders.
--Purpose: Finds the most frequent customers based on number of orders placed.
Select top 10 soh.CustomerID,count(soh.SalesOrderID) as Total_Customer_orders
from sales.SalesOrderHeader soh
group by CustomerID
order by Total_Customer_orders desc

--4.4 Get top 10 customers with the highest average order value.
--Purpose: Identifies customers who spend the most per purchase.
Select top 10 soh.CustomerID,Avg(soh.TotalDue) as Avg_order_value
from sales.SalesOrderHeader soh
group by CustomerID
order by Avg_order_value desc

--4.5 Get total of inactive customers (no orders after 2013).
--Purpose: Counts customers who have not placed any orders since 2013.
SELECT count(CustomerID)As #Customers_NoOrders
FROM Sales.Customer
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM Sales.SalesOrderHeader
    WHERE YEAR(OrderDate) > 2013
);

--4.6 Get average spending per order per customer.
--Purpose: Calculates each customer’s average spending per individual order.
SELECT CustomerID,AVG(TotalDue) AS AverageOrderValue
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;

--4.7 Get total number of unique customers per sales territory.
--Purpose: Measures customer base size and sales for each geographic territory.
select st.Name as territory,count(soh.CustomerID) As #Unique_Customers,
sum(soh.TotalDue) As Total_territory_Sales 
from Sales.SalesOrderHeader soh
join Sales.SalesTerritory st
on soh.TerritoryID=st.TerritoryID
group by st.Name
order by Total_territory_Sales desc

--4.8 Get yearly count of new customers (first purchase year).
--Purpose: Shows how many new customers joined each year to track acquisition growth.
SELECT FirstPurchaseYear,COUNT(*) AS NewCustomers
FROM (SELECT CustomerID,YEAR(MIN(OrderDate)) AS FirstPurchaseYear
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
) AS FirstOrders
GROUP BY FirstPurchaseYear
ORDER BY FirstPurchaseYear;
