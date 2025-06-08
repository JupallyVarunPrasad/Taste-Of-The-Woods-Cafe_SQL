-- OBJECTIVE 1
USE restaurant_db;

-- 1. View the menu_items table.
SELECT * FROM menu_items;

-- 2. Finding out number of items on the menu.
SELECT COUNT(*) FROM menu_items;

-- 3. Findng out least and most expensive items on the menu.
SELECT * FROM menu_items
ORDER BY price ASC;

SELECT * FROM menu_items
ORDER BY price DESC;

-- 4. How many Italaian dishes are on the menu?
SELECT COUNT(*) FROM menu_items
WHERE category = "Italian";

-- 5. Finding out least and most expensive Italian dishes on the menu?
SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price ASC;

SELECT * FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC;

-- 6. Finding out how many dishes are in each category?
SELECT category,
COUNT(menu_item_id) AS num_dishes
FROM menu_items
GROUP BY category;

-- 7. Average dish price within each category
SELECT category,
AVG(price) AS avg_price
FROM menu_items
GROUP BY category;


-- OBJECTIVE 2
USE restaurant_db;

-- 1. Viewing order_details table.
SELECT * FROM order_details;
-- 2. Viewing daet range of the table.alter
SELECT
MIN(order_date),
MAX(order_date)
FROM order_details;
-- 3. How many orders were within this date range?
SELECT
COUNT(distinct order_id) FROM order_details;
-- 4. How many items were ordered within this date range?
SELECT COUNT(*) FROM order_details;
-- 5. Which orders had the most number of items?
SELECT order_id,
COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;
-- 6. How many orders had more than 12 items?
SELECT COUNT(*) FROM
(SELECT order_id,
COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders;


-- OBJECTIVE 3
USE restaurant_db;

-- 1. Combine the menu-items and order_details tables into a single table.
SELECT * 
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id;
	
-- 2. What were the least or more ordered items? What category were they in?
SELECT item_name, category, COUNT(order_details_id) AS num_of_purchases
FROM order_details od LEFT JOIN menu_items mi
ON od.item_id = mi.menu_item_id
GROUP BY item_name,category
ORDER BY num_of_purchases;
-- 3. What are the top5 orders that spent the most money?
	SELECT order_id, SUM(price) AS total_spend
	FROM order_details od LEFT JOIN menu_items mi
		ON od.item_id = mi.menu_item_id
	GROUP BY order_id 
	ORDER BY total_spend desc
	LIMIT 5;
-- 4. View the details of the highest spend order. What insights can you gather from the results?
SELECT category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;
-- 5. View the details of the top5 hightest spend orders. What insights can you gather from the results?
/*SELECT order_id, SUM(price) AS total_spent
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spent DESC
LIMIT 5;*/

SELECT order_id, category, COUNT(item_id) AS num_items
FROM order_details od LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440,2075,1957,330,2675)
GROUP BY order_id, category