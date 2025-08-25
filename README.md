# 📦 Zepto E-commerce Inventory SQL Analysis

This project is a **complete real-world Data Analyst Portfolio Project** using an **e-commerce inventory dataset** scraped from **Zepto**, one of India’s fastest-growing quick-commerce startups.  

It covers the full workflow of a data analyst:
- Database & table creation  
- Data exploration  
- Data cleaning (handling null values, duplicates, invalid prices)  
- Business-focused analysis using SQL  

---

## 🚀 Project Overview
This project simulates **real analyst tasks** in the retail/e-commerce domain:  
- Working with raw scraped data  
- Cleaning and transforming data for usability  
- Deriving insights for **business decisions** such as pricing, stock, and revenue estimation  

---

## 🛠️ Tools & Technologies
- **MySQL** (Workbench) for SQL queries  
- **Kaggle Dataset** (scraped from Zepto)  
- **SQL concepts used**:  
  - `CREATE TABLE`, `INSERT`, `DELETE`, `UPDATE`  
  - `DISTINCT`, `GROUP BY`, `HAVING`, `ORDER BY`  
  - Aggregate functions (`SUM`, `AVG`, `COUNT`)  
  - Case expressions for categorization  

---

## 📂 Dataset Information
The dataset contains information about products available on Zepto, including:  
- Product ID  
- Category  
- Name  
- MRP (Maximum Retail Price)  
- Discount Percent  
- Available Quantity  
- Discounted Selling Price  
- Weight (in grams)  
- Stock Availability  
- Quantity  

---

## 🔑 Key SQL Tasks

### 🏗️ Database & Table Creation
```sql
CREATE DATABASE Zepto;
USE Zepto;

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

🔍 Data Exploration

-- Show first 3 records
SELECT * FROM zepto_v2 LIMIT 3;

-- Check null values
SELECT * 
FROM zepto_v2 
WHERE category IS NULL 
   OR name IS NULL 
   OR mrp IS NULL 
   OR discountPercent IS NULL 
   OR availableQuantity IS NULL 
   OR discountedSellingPrice IS NULL 
   OR weightInGms IS NULL 
   OR outOfStock IS NULL 
   OR quantity IS NULL;

-- Find distinct product categories
SELECT DISTINCT(category) FROM zepto_v2 ORDER BY Category;

-- Count of distinct categories
SELECT COUNT(DISTINCT(category)) FROM zepto_v2;

-- In-stock vs Out-of-stock products
SELECT COUNT(Category), outOfStock 
FROM zepto_v2 
GROUP BY outOfStock;

🧹 Data Cleaning

-- Find duplicates by product name
SELECT name, COUNT(availableQuantity) 
FROM zepto_v2 
GROUP BY name 
HAVING COUNT(availableQuantity) > 1
ORDER BY COUNT(availableQuantity) DESC;

-- Identify and remove products with zero MRP
SELECT * FROM zepto_v2 WHERE mrp = 0;
DELETE FROM zepto_v2 WHERE mrp = 0;

-- Convert MRP & Discounted Price from paise to rupees
UPDATE zepto_v2
SET mrp = mrp/100.0,
    discountedSellingPrice = discountedSellingPrice/100.0;

📊 Business Analysis Queries
Q1. Find the top 10 best-value products based on discount percentage

SELECT DISTINCT name, mrp, discountPercent 
FROM zepto_v2
ORDER BY discountPercent DESC 
LIMIT 10;

Q2. Find high-MRP products that are out of stock

SELECT DISTINCT name, mrp 
FROM zepto_v2
WHERE outOfStock = "True"
ORDER BY mrp DESC
LIMIT 4;

Q3. Calculate estimated revenue from each category

SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto_v2
GROUP BY category
ORDER BY total_revenue;

Q4. Find products with MRP > 500 and discount < 10%

SELECT * 
FROM zepto_v2
WHERE mrp > 500 AND discountPercent < 10;

Q5. Identify the top 5 categories with the highest average discount

SELECT category,
       AVG(discountPercent) AS avg_discount
FROM zepto_v2 
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

Q6. Price per gram for products above 100g

SELECT DISTINCT name, weightInGms, discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto_v2
WHERE weightInGms >= 100
ORDER BY price_per_gram;

Q7. Group products into categories by weight

SELECT DISTINCT name, weightInGms,
CASE 
    WHEN weightInGms < 1000 THEN "Low"
    WHEN weightInGms < 5000 THEN "Medium"
    ELSE "Bulk"
END AS weight_category
FROM zepto_v2;

Q8. Total inventory weight per category

SELECT Category, SUM(weightInGms) AS total_weight
FROM zepto_v2
GROUP BY Category;

 📈 Key Insights

- Several products had missing values and duplicate entries  
- Some products were incorrectly recorded with `MRP = 0`, requiring cleaning  
- Discounts vary widely across categories, with some offering very high average discounts  
- Revenue estimation per category gives insights into **best-performing categories**  
- Weight-based categorization helps segment products into **Low, Medium, Bulk classes**  

---

✅ These queries provide a quick overview of:
- Dataset structure  
- Missing values  
- Category diversity  
- Stock availability  

---

✍️ **Author:** Ganesh Prasad Sahoo  
🔗 **GitHub:** [GaneshPrasadSahoo](https://github.com/GaneshPrasadSahoo)  
🔗 **LinkedIn:** [Ganesh Prasad Sahoo](https://www.linkedin.com/in/ganesh-prasad-sahoo-775346293/)  
