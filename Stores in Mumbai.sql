CREATE TABLE retail_stores (
         store_id INT PRIMARY KEY, 
         store_name VARCHAR(100), 
         city VARCHAR(100)
     );
     INSERT INTO retail_stores VALUES 
         (1, 'Reliance Mart', 'Mumbai'), 
         (2, 'Big Bazaar', 'Delhi'), 
         (3, 'D Mart', 'Mumbai');


SELECT * FROM RETAIL_STORES

/*
Find all retail stores located in Mumbai.
*/

SELECT STORE_NAME
FROM RETAIL_STORES
WHERE CITY ILIKE 'Mumbai'