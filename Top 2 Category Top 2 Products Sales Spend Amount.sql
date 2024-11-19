CREATE TABLE orders (category VARCHAR(20), product VARCHAR(20), user_id INT, spend DECIMAL(10, 2),transaction_date DATE);

INSERT INTO orders VALUES 
	('appliance','refrigerator',165,246.00,'2021/12/26'), 
	('appliance','refrigerator',123,299.99,'2022/03/02'),
	('appliance','washingmachine',123,219.80,'2022/03/02'), 
	('electronics','vacuum',178,152.00,'2022/04/05'), 
	('electronics','wirelessheadset',156,249.90,'2022/07/08'), 
	('electronics','TV',145,189.00,'2022/07/15'), 
	('Television','TV',165,129.00,'2022/07/15'),
	('Television','TV',163,129.00,'2022/07/15'),
	('Television','TV',141,129.00,'2022/07/15'),
	('toys','Ben10',145,189.00,'2022/07/15'), 
	('toys','Ben10',145,189.00,'2022/07/15'), 
	('toys','yoyo',165,129.00,'2022/07/15'), 
	('toys','yoyo',163,129.00,'2022/07/15'),
	('toys','yoyo',141,129.00,'2022/07/15'),
	('toys','yoyo',145,189.00,'2022/07/15'),
	('electronics','vacuum',145,189.00,'2022/07/15');

SELECT * FROM ORDERS

/*
Find the top 2 products in the top 2 categories based on spend amount.
*/

WITH CTE1 AS (
    SELECT CATEGORY,
           PRODUCT,
           SUM(SPEND) AS TOTAL_SPEND_AMOUNT
    FROM ORDERS
    GROUP BY CATEGORY, PRODUCT
),
CTE2 AS (
    SELECT 
           CATEGORY,
           SUM(TOTAL_SPEND_AMOUNT) AS TOTAL_CATEGORY_SPEND,
           DENSE_RANK() OVER( ORDER BY SUM(TOTAL_SPEND_AMOUNT) DESC) AS DRNK
    FROM CTE1
    GROUP BY CATEGORY
),
CTE3 AS (
    SELECT
        CTE1.CATEGORY,
        CTE1.PRODUCT,
        CTE1.TOTAL_SPEND_AMOUNT,
        DENSE_RANK() OVER(PARTITION BY CTE1.CATEGORY ORDER BY CTE1.TOTAL_SPEND_AMOUNT DESC) AS DRNK
    FROM CTE1 
    JOIN CTE2
    ON CTE1.CATEGORY = CTE2.CATEGORY
    WHERE CTE2.DRNK <= 2
)
SELECT 
    CATEGORY,
    PRODUCT,
    TOTAL_SPEND_AMOUNT
FROM CTE3
WHERE CTE3.DRNK <= 2;


