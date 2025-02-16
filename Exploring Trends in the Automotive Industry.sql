-- USE Automative_industry

-- 1)Calculate the average selling price for cars with a manual transmission and owned by the first owner, for each fuel type. ---
SELECT fuel,AVG(selling_price) FROM automative
WHERE transmission = 'Manual' and owner = 'First Owner'
GROUP BY fuel ;

-- 2)Find the top 3 car models with the highest average mileage, considering only cars with more than 5 seats.---
SELECT NAME,AVG(mileage) AS avge FROM automative
WHERE seats >5
GROUP BY Name
ORDER BY avge DESC
LIMIT 3;

-- 3)Identify the car models where the difference between the maximum and minimum selling prices is greater than $10,000. ---
SELECT Name FROM automative
GROUP BY Name 
HAVING MAX(selling_price) - MIN(selling_price) >10000;

-- 4)Retrieve the names of cars with a selling price above the overall average selling price and a mileage below the overall average mileage. ---
SELECT Name FROM automative
WHERE selling_price > (SELECT AVG(selling_price) FROM automative)
AND mileage < (SELECT AVG(mileage) FROM automative);

-- 5)Calculate the cumulative sum of the selling prices over the years for each car model. ---

SELECT Name,year,selling_price,SUM(selling_price) OVER (PARTITION BY NAME ORDER BY YEAR) AS cumsum
FROM automative;

-- 6)Identify the car models that have a selling price within 10% of the average selling price. ---
SELECT Name FROM automative
WHERE selling_price BETWEEN (SELECT AVG(selling_price) * 0.9 FROM automative) AND (SELECT AVG(selling_price) * 1.1 FROM automative);

-- 7)Calculate the exponential moving average (EMA) of the selling prices for each car model, considering a smoothing factor of 0.2. ---

SELECT Name, year, selling_price,
       AVG(selling_price) OVER (PARTITION BY Name ORDER BY year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ema_selling_price
FROM automative;


-- 8)Identify the car models that have had a decrease in selling price from the previous year. ---

SELECT Name, year, selling_price
FROM (
    SELECT Name, year, selling_price,
           LAG(selling_price) OVER (PARTITION BY Name ORDER BY year) AS previous_year_price
    FROM automative
) AS price_changes
WHERE selling_price < previous_year_price;

-- 9)Retrieve the names of cars with the highest total mileage for each transmission type. ---
WITH TotalMileage AS (
    SELECT Name, transmission, SUM(km_driven) AS total_mileage
    FROM  automative
    GROUP BY Name, transmission
)
SELECT Name, transmission, total_mileage
FROM TotalMileage
WHERE (transmission, total_mileage) IN (
    SELECT transmission, MAX(total_mileage)
    FROM TotalMileage
    GROUP BY transmission
);


--- 10. Find the average selling price per year for the top 3 car models with the highest overall selling prices. ---
WITH RankedSellingPrices AS (
    SELECT Name, selling_price,
           RANK() OVER (PARTITION BY Name ORDER BY selling_price DESC) AS price_rank
    FROM automative
)
SELECT Name, year, AVG(selling_price) AS avg_selling_price_per_year
FROM automative
WHERE Name IN (
    SELECT Name
    FROM RankedSellingPrices
    WHERE price_rank <= 3
)
GROUP BY Name, year;




