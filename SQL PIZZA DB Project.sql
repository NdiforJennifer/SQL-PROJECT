Select * from pizza_sales

--1) Total Revenue

SELECT SUM(total_price) AS total_Revenue From pizza_sales

--2) Average Order Value 

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_order_Value
From pizza_sales

---3) Total Pizzas Sold 

SELECT SUM(Quantity) As Total_pizza_sold From pizza_sales

--4) Total Orders 

SELECT COUNT(DISTINCT Order_id) As Total_Order_id From pizza_sales

--5) Average Pizzas per order

SELECT CAST (CAST(SUM(Quantity) AS DECIMAL (10,2)/
CAST(COUNT( DISTINCT Order_id)AS DECIMAL (10,2)) AS DECIMAL 10,2))
AS Avg_pizzas_per_order
From pizza_sales

--6)  Daily Trend for total sales

SELECT DATENAME (DW,Order_date) AS Order_day,COUNT (DISTINCT Order_id) AS total_orders
From pizza_sales
GROUP BY DATENAME (DW,Order_date)

--7) Hourly Trend Orders

SELECT DATEPART (HOUR,Order_time) AS Order_Hours,COUNT (DISTINCT Order_id) AS total_orders
From pizza_sales
GROUP BY DATEPART (HOUR,Order_time)
ORDER BY DATEPART (HOUR,Order_time)

--8) % Of Sales by pizza category

SELECT pizza_category, SUM(total_price) AS total_sales,
SUM(total_price)*100 / (SELECT SUM(total_price) from pizza_sales Where MONTH(Order_Date) = 1) as PCT
FROM pizza_sales
Where MONTH(Order_Date) = 1
GROUP BY pizza_category


SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS
total_revenue,
CAST(SUM(total_price)*100 / (SELECT SUM(total_price) from pizza_sales)
AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category

--9) % Of Sales by Pizza Size 

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS
total_Sales,
CAST(SUM(total_price)*100 / (SELECT SUM(total_price) from pizza_sales)
AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART (quarter, Order_date)=1
GROUP BY pizza_size
ORDER BY PCT DESC

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS
total_revenue,
CAST(SUM(total_price)*100 / (SELECT SUM(total_price) from pizza_sales)
AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size

--10) Total Pizza Sold by Category 

SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date)=2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


---11) Top 7 Best Sellers by Total Pizzas Sold

SELECT TOP 7 pizza_Name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_Name
ORDER BY Total_Pizza_Sold DESC

 
 ---11) Top 7 Bottom Sellers by Total Pizzas Sold

 SELECT TOP 7 pizza_Name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_Name
ORDER BY Total_Pizza_Sold ASC



-- By Month
SELECT TOP 7 pizza_Name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
WHERE MONTH(order_date)=2
GROUP BY pizza_Name
ORDER BY Total_Pizza_Sold ASC

SELECT TOP 7 pizza_Name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
WHERE MONTH(order_date)=8
GROUP BY pizza_Name
ORDER BY Total_Pizza_Sold ASC

CREATE VIEW TOP7PIZZA_SALES As
 SELECT TOP 7 pizza_Name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_Name
--ORDER BY Total_Pizza_Sold ASC


CREATE VIEW PIZZA_SALESBYCATEGORY As
SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date)=2
GROUP BY pizza_category
--ORDER BY Total_Quantity_Sold DESC