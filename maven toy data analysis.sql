use mentorness;
##1. What is the total sales revenue generated by each store?

select stores.Store_Name, sum(products.Product_Price * sales.Units)
 as sales_revenue
from sales left join stores on sales.Store_ID=stores.Store_ID
left join products on sales.Product_ID=products.Product_ID
group by stores.Store_Name;



##2. Which products are the top-selling in terms of units sold?

SELECT SUM(sales.Units) AS total_units, products.Product_Name 
FROM sales 
LEFT JOIN products ON sales.Product_ID = products.Product_ID 
GROUP BY products.Product_Name 
ORDER BY total_units DESC 
LIMIT 0, 100;

# 3  What is the sales performance by product category?

select products.Product_Category,SUM(sales.Units) AS sales_performace
from sales left join products on sales.Product_ID=products.Product_ID
group by products.Product_Category;

#4 What are the current inventory levels for each product at each store?

select products.Product_Name,stores.Store_Name,
inventory.Stock_On_Hand from inventory
left join stores on inventory.Store_ID=stores.Store_ID
left join products on inventory.Product_ID=products.Product_ID
group by products.Product_Name,stores.Store_Name,inventory.Stock_On_Hand
limit 0,1000;

 #How do monthly sales trends vary across different stores?
 select stores.Store_Name,MONTHNAME(sales.Date),SUM(sales.Units) AS total_unit
 from sales  left join stores on  sales.Store_ID=stores.Store_ID
 group by stores.Store_Name,MONTHNAME(sales.Date)
 limit 0,10000;
 
 ##
 select * from products;
 desc products;
 
SET SQL_SAFE_UPDATES = 0;
#lite
UPDATE products 
SET Product_Price = CAST(REPLACE(Product_Price, '$', '') AS DECIMAL(10, 2))
WHERE Product_Price LIKE '$%';

ALTER TABLE products 
MODIFY Product_Price DECIMAL(10, 2);

UPDATE products 
SET Product_Cost = CAST(REPLACE(Product_Cost, '$', '') AS DECIMAL(10, 2))
WHERE Product_Cost LIKE '$%';

ALTER TABLE products 
MODIFY Product_Cost DECIMAL(10, 2);







 #Which stores have the highest and lowest sales performance?
 
 SELECT stores.Store_Name, 
       SUM(products.Product_Price * sales.Units) AS total_revenue 
FROM sales 
LEFT JOIN stores ON sales.Store_ID = stores.Store_ID 
LEFT JOIN products ON sales.Product_ID = products.Product_ID 
GROUP BY stores.Store_Name 
ORDER BY total_revenue 
LIMIT 0, 50000;

 
 ##What is the profit margin for each product?
 select Product_Name,((Product_Price-Product_Cost)/Product_Cost)*100 as
 profit_revenue
 from products
 order by profit_revenue;
 
 ##How are sales distributed across different cities?
 select stores.Store_City,sum(sales.Units * products.Product_Price) from
 sales left join products on sales.Product_ID=products.Product_ID
 left join stores on sales.Store_ID=stores.Store_ID
 group by stores.Store_City;
 ##Which products are out of stock in each store
 select products.Product_Name from inventory
 left join products on products.Product_ID=inventory.Product_ID
 where inventory.Stock_On_Hand=0;
 ##How do sales vary by specific dates?
 
 
 SELECT 
    sales.date, 
    SUM(sales.Units * products.Product_Price) AS total_sales, 
    products.Product_Name
FROM 
    sales 
LEFT JOIN 
    products ON sales.Product_ID = products.Product_ID
GROUP BY 
    sales.date, 
    products.Product_Name
LIMIT 0, 1000;
#What is the average cost of products in each category?
SELECT Product_Category,avg(Product_Cost) from products
group by Product_Category;

#What is the sales growth over time for the entire company?
select sales.Date,sum(products.Product_Price*sales.Units) 
as sales_growth
from sales left join products on sales.Product_ID=products.Product_ID
group by sales.date;

##How does the store open date affect sales performance?


SELECT stores.Store_Open_Date, stores.Store_Name,
 SUM(sales.Units * products.Product_Price) as sales_performance
FROM sales 
LEFT JOIN stores ON sales.Store_ID = stores.Store_ID 
LEFT JOIN products ON sales.Product_ID = products.Product_ID 
GROUP BY stores.Store_Open_Date, stores.Store_Name 
LIMIT 0, 50000;

#What percentage of total sales does each store contribute?
create table t10 as
SELECT  stores.Store_Name, SUM(sales.Units * products.Product_Price) as sales_performance
FROM sales 
LEFT JOIN stores ON sales.Store_ID = stores.Store_ID 
LEFT JOIN products ON sales.Product_ID = products.Product_ID 
GROUP BY  stores.Store_Name 
limit 0,50;



SELECT Store_Name, 
       SUM(sales_performance) / (SELECT SUM(sales_performance) FROM t10)
       AS sales_ratio
FROM t10
GROUP BY Store_Name
LIMIT 50000;
##How do sales compare to current stock levels for each product?


 
 
 
 
 
