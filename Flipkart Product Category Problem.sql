CREATE TABLE products (product_id INT, product_name VARCHAR(25), category VARCHAR(25)); 

INSERT INTO products VALUES (101, 'Laptop', 'Electronics'), (102, 'Phone', 'Electronics'), (103, 'Desk', 'Furniture'), (104, 'Chair', 'Furniture'), (105, 'Book', 'Books'); 

CREATE TABLE transactions (transaction_id INT, product_id INT, quantity INT, price_per_unit DECIMAL(8,2)); 

INSERT INTO transactions VALUES (1, 101, 10, 1000), (2, 102, 20, 500), (3, 103, 5, 200), (4, 104, 15, 150), (5, 105, 50, 20), (6, 102, 10, 500), (7, 101, 5, 1000), (8, 103, 10, 200), (9, 104, 20, 150), (10, 105, 30, 20);


SELECT * FROM PRODUCTS

SELECT * FROM TRANSACTIONS


/*
Find the top 3 best-selling products in each category with their total sales and percentage contribution
*/

WITH CTE AS
(
SELECT P.PRODUCT_NAME,
       P.CATEGORY,
       SUM(T.QUANTITY * T.PRICE_PER_UNIT) AS TOTAL_SALES,
	   RANK() OVER (PARTITION BY p.category ORDER BY SUM(t.quantity * t.price_per_unit) DESC) AS rank,
 	   ROUND(SUM(t.quantity * t.price_per_unit) * 100.0 / SUM(SUM(t.quantity * t.price_per_unit)) OVER (PARTITION BY p.category), 2) AS contribution_percentage
FROM PRODUCTS P
JOIN TRANSACTIONS T
ON P.PRODUCT_ID = T.PRODUCT_ID
GROUP BY 1,2
)
SELECT PRODUCT_NAME,
       CATEGORY,
       TOTAL_SALES,
       CONTRIBUTION_PERCENTAGE
FROM CTE 
WHERE RANK <=3