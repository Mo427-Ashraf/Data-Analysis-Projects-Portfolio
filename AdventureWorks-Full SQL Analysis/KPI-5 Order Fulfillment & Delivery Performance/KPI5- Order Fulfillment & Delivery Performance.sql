USE AdventureWorks2022;


--5.1 Get average delivery time (days between OrderDate and ShipDate).
--Purpose: Calculates the company’s average shipping duration to measure efficiency.
SELECT AVG(DATEDIFF(DAY, OrderDate, ShipDate)) AS AvgDeliveryDays
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL;

--5.2 Get percentage of on-time vs delayed deliveries (?5 days = on-time).
--Purpose: Evaluates shipping reliability by showing the share of timely vs delayed orders.
SELECT CASE 
        WHEN DATEDIFF(DAY, OrderDate, ShipDate) <= 5 THEN 'On-Time'
        ELSE 'Delayed' 
END AS DeliveryStatus,
COUNT(*) AS OrdersCount,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
GROUP BY CASE 
 WHEN DATEDIFF(DAY, OrderDate, ShipDate) <= 5 THEN 'On-Time'
 ELSE 'Delayed' 
  END;

--5.3 Get top 10 orders with the longest delivery time.
--Purpose: Identifies the slowest fulfilled orders to detect delays.
SELECT TOP 10 SalesOrderID,CustomerID,DATEDIFF(DAY, OrderDate, ShipDate) AS DeliveryDays
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
ORDER BY DeliveryDays DESC;

--5.4 Get average delivery time per sales territory.
--Purpose: Compares average shipping speed between territories.
SELECT st.Name AS TerritoryName,
ROUND(AVG(DATEDIFF(DAY, OrderDate, ShipDate)), 2) AS AvgDeliveryDays
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
WHERE ShipDate IS NOT NULL
GROUP BY st.Name
ORDER BY AvgDeliveryDays;

--5.5 Get top 10 customers with the most delayed deliveries (>7 days).
--Purpose: Highlights customers frequently experiencing shipping delays.
SELECT TOP 10 
    CustomerID,
    COUNT(*) AS DelayedOrders
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
  AND DATEDIFF(DAY, OrderDate, ShipDate) > 7
GROUP BY CustomerID
ORDER BY DelayedOrders DESC;

--5.6 Get count of delayed deliveries per quarter.
--Purpose: Tracks how many late shipments occur in each quarter.
SELECT 
    YEAR(OrderDate) AS SalesYear,
    CONCAT('Q', DATEPART(QUARTER, OrderDate)) AS Quarter,
    COUNT(*) AS DelayedOrders
FROM Sales.SalesOrderHeader
WHERE ShipDate IS NOT NULL
  AND DATEDIFF(DAY, OrderDate, ShipDate) > 5
GROUP BY YEAR(OrderDate), DATEPART(QUARTER, OrderDate)
ORDER BY SalesYear, Quarter;

--5.7 Get top 10 salespersons with the highest number of delayed deliveries.
--Purpose: Finds salespeople associated with the most late shipments for performance tracking.
SELECT TOP 10 sp.BusinessEntityID AS SalesPersonID,COUNT(*) AS DelayedOrders
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.BusinessEntityID
WHERE ShipDate IS NOT NULL
  AND DATEDIFF(DAY, OrderDate, ShipDate) > 5
GROUP BY sp.BusinessEntityID
ORDER BY DelayedOrders DESC;
