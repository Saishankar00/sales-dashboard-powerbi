SHOW DATABASES;
USE sales_dashboard;
DROP TABLE book1
SHOW TABLES;
SELECT COUNT(*) FROM Sales;
SELECT COUNT(*) FROM Products;
SELECT COUNT(*) FROM REGIONS;
SELECT COUNT(*) FROM RETURNS;
SELECT
    s.Sale_ID,
    s.Date,
    p.Product_Name,
    p.Category,
    r.Region_Name,
    s.Quantity,
    s.Sales_Amount
FROM Sales s
JOIN Products p ON s.Product_ID = p.Product_ID
JOIN Regions r ON s.Region_ID = r.Region_ID;
SELECT
    r.Region_Name,
    SUM(s.Sales_Amount) AS Total_Sales
FROM Sales s
JOIN Regions r
ON s.Region_ID = r.Region_ID
GROUP BY r.Region_Name;
SELECT
    MONTH(Date) AS Month,
    SUM(Sales_Amount) AS Monthly_Sales
FROM Sales
GROUP BY MONTH(Date)
ORDER BY Month;
SELECT
    p.Product_Name,
    ROUND(SUM(s.Sales_Amount),2) AS Revenue
FROM Sales s
JOIN Products p
ON s.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY Revenue DESC
LIMIT 10;
SELECT
    p.Category,
    ROUND(SUM(s.Sales_Amount),2) AS Total_Sales
FROM Sales s
JOIN Products p
ON s.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Total_Sales DESC;
SELECT
    ROUND(
        SUM(Sales_Amount) / COUNT(Sale_ID),
        2
    ) AS Average_Order_Value
FROM Sales;
WITH MonthlySales AS (
    SELECT
        MONTH(Date) AS Month_No,
        SUM(Sales_Amount) AS Revenue
    FROM Sales
    GROUP BY MONTH(Date)
)
SELECT
    Month_No,
    Revenue,
    ROUND(
        (
            Revenue -
            LAG(Revenue) OVER (ORDER BY Month_No)
        ) /
        LAG(Revenue) OVER (ORDER BY Month_No)
        * 100,
        2
    ) AS Growth_Percent
FROM MonthlySales;
SELECT
    r.Region_Name,
    ROUND(SUM(s.Sales_Amount),2) AS Total_Sales
FROM Sales s
JOIN Regions r
ON s.Region_ID = r.Region_ID
GROUP BY r.Region_Name
ORDER BY Total_Sales ASC
LIMIT 1;