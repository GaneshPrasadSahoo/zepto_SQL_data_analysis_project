create database Zepto
use Zepto
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE Zepto_data (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Category VARCHAR(200),
    Name VARCHAR(150) NOT NULL,
    Mrp DECIMAL(8,2),
    DiscountPercent INT,
    availableQuantity INT,
    discountedSellingPrice INT,
    weightInGms INT,
    outOfStock BOOLEAN,
    quantity INT
);

select * from zepto_v2

-- show first 3 data 
select * from zepto_v2 limit 3

-- cheack null values 
SELECT * 
FROM zepto_v2 
WHERE 
    category IS NULL 
    OR name IS NULL 
    OR mrp IS NULL 
    OR discountPercent IS NULL 
    OR availableQuantity IS NULL 
    OR discountedSellingPrice IS NULL 
    OR weightInGms IS NULL 
    OR outOfStock IS NULL 
    OR quantity IS NULL;
    
    -- find different product Category
    select distinct(Category) from zepto_v2  order by Category

-- find how many different product Category is present
    select count(distinct(Category) )from zepto_v2 
    
-- product in Stock and out of Stuck
select count(Category),outOfStock  from zepto_v2 group by outOfStock

-- Find product names that appear more than once in the table, along with the number of records for each, ordered by frequency.

select name,count(availableQuantity) from zepto_v2 
group by name 
having count(availableQuantity)>1
order by count(availableQuantity) desc

-- Data clining
-- Identify and remove products with zero price from the database
select * from zepto_v2 where mrp =0;
delete from  zepto_v2 
where mrp =0;

-- mrp and discountedSellingPriceare present in paisa convert to rupees
update zepto_v2
set mrp=mrp/100.0,
discountedSellingPrice=discountedSellingPrice/100.0


-- Solve business problem
-- q1) Find the top 10 best-value products based on the discounts percentage
select Distinct name,mrp,discountPercent 
from zepto_v2
order by discountPercent desc 
limit 10

-- q2 what are the product that high mrp but out of stuck
select  distinct name,mrp from zepto_v2
where outOfStock ="True"
order by mrp desc
limit 4

-- q3)calculate estimate Revenue from each category
select category,
sum(discountedSellingPrice*availableQuantity) as total_revenue 
from zepto_v2
group by category 
order by total_revenue

-- q4) find all products where mrp is grater then 500 and discount is less then 10 %
where mrp >500 and discountPercent <10

-- q5) identify the top 5 categories offering the highest average discount percentage
select category,
avg(discountPercent) as avg_discount
from zepto_v2 
group by category
order by avg_discount desc
limit 5;

-- q6) find the price per gram for products above 100g and sort by best value
select distinct name,weightInGms,discountedSellingPrice ,
round(discountedSellingPrice/weightInGms,2) as price_per_gram
from zepto_v2 
where weightInGms >= 100
order by price_per_gram

-- q7) Group the product into catagories like low ,medium & bulk
select distinct name,weightInGms,
case when weightInGms <1000 then "low"
      when weightInGms <5000 then "medium"
	  else "Bulk"
      End as weight_category
      from zepto_v2
      
-- q8)what is the total inventory weight per catecory
SELECT 
    Category, SUM(weightInGms)
FROM
    zepto_v2
GROUP BY Category

