B.ANALYTICAL / WINDOW FUNCTIONS ( 30 QUESTIONS )
--1.Assign row numbers to customers ordered by credit limit descending.
-- SELECT
--      CUST_ID,
--      CUST_FIRST_NAME,
--      CUST_CREDIT_LIMIT,
--      ROW_NUMBER() OVER(ORDER BY CUST_CREDIT_LIMIT DESC) AS ROW_NUMBER
-- FROM SH.CUSTOMERS


--2.Rank customers within each state by credit limit.
-- ;SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME,
--     CUST_STATE_PROVINCE
--     CUST_CREDIT_LIMIT,
--     RANK() OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_CREDIT_LIMIT DESC) AS STATE_RANK
-- FROM SH.CUSTOMERS



--3. Use DENSE_RANK() to find the top 5 credit holders per country.
-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME,
--     COUNTRY_ID,
--     CUST_CREDIT_LIMIT,
--     CREDIT_RANK
-- FROM (
--     SELECT 
--         CUST_ID,
--         CUST_FIRST_NAME,
--         COUNTRY_ID,
--         CUST_CREDIT_LIMIT,
--         DENSE_RANK() OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT DESC) AS CREDIT_RANK
--     FROM SH.CUSTOMERS
-- )
-- WHERE CREDIT_RANK <= 5;


--4. Divide customers into 4 quartiles based on their credit limit using NTILE(4).
-- SELECT 
--     CUST_ID,
--     CUST_CREDIT_LIMIT,
--     NTILE(4) OVER (ORDER BY CUST_CREDIT_LIMIT) AS quartile
-- FROM SH.CUSTOMERS;


--5.Calculate a running total of credit limits ordered by customer_id.
-- SELECT
--      CUST_ID
--      CUST_FIRST_NAME,
--      CUST_CREDIT_LIMIT,
--      SUM(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS RUNNING_TOTAL
-- FROM SH.CUSTOMERS;


--6.Show cumulative average credit limit by country.
-- SELECT 
--     CUST_ID,
--     CUST_FIRST_NAME,
--     COUNTRY_ID,
--     CUST_CREDIT_LIMIT,
--     AVG(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_ID) AS CUMULATIVE_AVG
-- FROM 
--     SH.CUSTOMERS;


--7. Compare each customer’s credit limit to the previous one using LAG().
-- SELECT
--     CUST_ID,
--     CUST_CREDIT_LIMIT,
--     LAG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS PREVIOUS_CREDIT_LIMIT,
--     CUST_CREDIT_LIMIT - LAG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS DIFFERENCE
-- FROM
--     SH.CUSTOMERS;


-- --8. Show next customer’s credit limit using LEAD().
-- SELECT 
--      CUST_ID,
--      CUST_CREDIT_LIMIT,
--      LEAD(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS NEXT_CREDIT_LIMIT
-- FROM SH.CUSTOMERS


--9.Display the difference between each customer’s credit limit and the previous one.
-- SELECT
--     CUST_ID,
--     CUST_CREDIT_LIMIT,
--     LAG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS PREVIOUS_CREDIT_LIMIT,
--     (CUST_CREDIT_LIMIT - LAG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID)) AS DIFFERENCE
-- FROM SH.CUSTOMERS;


--10.For each country, display the first and last credit limit using FIRST_VALUE() and LAST_VALUE()
-- SELECT
--     CUST_ID,
--     COUNTRY_ID,
--     CUST_CREDIT_LIMIT,
--     FIRST_VALUE(CUST_CREDIT_LIMIT) OVER ( PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT) AS FIRST_VALUE,
--     LAST_VALUE(CUST_CREDIT_LIMIT) OVER ( PARTITION BY CUST_CREDIT_LIMIT ORDER BY COUNTRY_ID) AS LAST_VALUE
-- FROM SH.CUSTOMERS



--11.Compute percentage rank (PERCENT_RANK()) of customers based on credit limit.
-- SELECT
--     CUST_ID,
--     CUST_CREDIT_LIMIT,
--     PERCENT_RANK() OVER (ORDER BY CUST_CREDIT_LIMIT) AS CREDIT_LIMIT_PERCENT_RANK
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_CREDIT_LIMIT;


--12.Show each customer’s position in percentile (CUME_DIST() function).
-- SELECT
--      CUST_ID,
--      CUST_CREDIT_LIMIT,
--      CUME_DIST() OVER (ORDER BY CUST_CREDIT_LIMIT) AS PERCENTILE_CREDIT_LIMIT
-- FROM SH.CUSTOMERS


--13.Display the difference between the maximum and current credit limit for each customer.
-- SELECT
--     CUST_ID,
--     CUST_CREDIT_LIMIT,
--     MAX(CUST_CREDIT_LIMIT) OVER () AS MAX_CREDIT_LIMIT,
--     (MAX(CUST_CREDIT_LIMIT) OVER () - CUST_CREDIT_LIMIT)AS DIFFERENCE
-- FROM
--     SH.CUSTOMERS
-- ORDER BY
--     CUST_ID;



--14.Rank income levels by their average credit limit.
-- SELECT
--      CUST_INCOME_LEVEL,
--      AVG(CUST_CREDIT_LIMIT) AS AVG_CREDIT_LIMIT,
--      RANK() OVER (ORDER BY AVG(CUST_CREDIT_LIMIT) DESC) AS RANK_BY_AVG_CREDIT
-- FROM SH.CUSTOMERS
-- GROUP BY CUST_INCOME_LEVEL


--15.Calculate the average credit limit over the last 10 customers (sliding window).
-- SELECT 
--     CUST_ID,
--     CUST_CREDIT_LIMIT,
--     AVG(CUST_CREDIT_LIMIT) 
--         OVER (ORDER BY CUST_ID
--             ROWS BETWEEN 9 PRECEDING AND CURRENT ROW
--         ) AS AVG_LAST_10_CUSTOMERS
-- FROM SH.CUSTOMERS
-- ORDER BY CUST_ID;


-- 16.For each state, calculate the cumulative total of credit limits ordered by city.
-- SELECT
--     CUST_ID,
--     CUST_STATE_PROVINCE_ID,
--     CUST_CREDIT_LIMIT,
--     CUST_CITY,
--     SUM(CUST_CREDIT_LIMIT) OVER (PARTITION BY CUST_STATE_PROVINCE_ID ORDER BY CUST_CITY) AS CUMULATIVE_CREDIT
-- FROM SH.CUSTOMERS;


--17. Find customers whose credit limit equals the median credit limit (use PERCENTILE_CONT(0.5)).
-- SELECT *
-- FROM ( 
--     SELECT
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         CUST_CREDIT_LIMIT,
--         PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CUST_CREDIT_LIMIT) OVER () AS median_credit
--     FROM SH.CUSTOMERS
-- )
-- WHERE CUST_CREDIT_LIMIT = median_credit


--18.Display the highest 3 credit holders per state using ROW_NUMBER() and PARTITION BY.
-- SELECT *
-- FROM (
--     SELECT
--         CUST_ID,
--         CUST_STATE_PROVINCE,
--         CUST_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_CREDIT_LIMIT) AS rn
--     FROM SH.CUSTOMERS
-- )
-- WHERE rn <= 3;


--19.Identify customers whose credit limit increased compared to previous row (using LAG).
-- SELECT *
-- FROM (
--     SELECT
--         CUST_ID,
--         CUST_CREDIT_LIMIT,
--         LAG(CUST_CREDIT_LIMIT) OVER (ORDER BY CUST_ID) AS PREVIOUS_CREDIT_LIMIT
--     FROM SH.CUSTOMERS
-- )
-- WHERE CUST_CREDIT_LIMIT > PREVIOUS_CREDIT_LIMIT;


--20.calculate moving average of credit limits with a window of 3.
-- SELECT
--     cust_id,
--     cust_credit_limit,
--     AVG(cust_credit_limit) OVER (
--         ORDER BY cust_id
--         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
--     ) AS moving_avg_3
-- FROM SH.CUSTOMERS


-- 21.Show cumulative percentage of total credit limit per country.
-- SELECT
--      COUNTRY_ID,
--      CUST_CREDIT_LIMIT,
--      SUM(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_ID)/
--      SUM(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID) * 100 AS CUMULATIVE_PCT
-- FROM SH.CUSTOMERS


--22.Rank customers by age (derived from CUST_YEAR_OF_BIRTH).
-- SELECT
--     CUST_ID,
--     CUST_YEAR_OF_BIRTH,
--     (EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) AS age,
--     RANK() OVER (ORDER BY (EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) DESC) AS age_rank
-- FROM SH.CUSTOMERS


--23.Calculate difference in age between current and previous customer in the same state.
-- SELECT 
--     CUST_ID,
--     CUST_STATE_PROVINCE,
--     EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH AS AGE,
--     LAG(EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) 
--         OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_ID) AS PREVIOUS_AGE,
--     (EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) - 
--     LAG(EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH) 
--         OVER (PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_ID) AS AGE_DIFF
-- FROM SH.CUSTOMERS;
     

--24.Use RANK() and DENSE_RANK() to show how ties are treated differently.
-- SELECT 
--     CUST_ID,
--     CUST_STATE_PROVINCE,
--     CUST_INCOME_LEVEL,
--     RANK() OVER(PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_INCOME_LEVEL) AS  RANK_ORDER,
--     DENSE_RANK() OVER(PARTITION BY CUST_STATE_PROVINCE ORDER BY CUST_INCOME_LEVEL) AS DENSE_RANK_ORDER
-- FROM SH.CUSTOMERS


--25.Compare each state’s average credit limit with country average using window partition.
-- SELECT
--      COUNTRY_ID,
--      CUST_ID,
--      CUST_STATE_PROVINCE,
--      CUST_CREDIT_LIMIT,
--      AVG(CUST_CREDIT_LIMIT) OVER (PARTITION BY CUST_STATE_PROVINCE) AS STATE_AVG,
--      AVG(CUST_CREDIT_LIMIT) OVER (PARTITION BY COUNTRY_ID) AS COUNTRY_AVG
-- FROM SH.CUSTOMERS


--26. Show total credit per state and also its rank within each country.
-- SELECT
--      COUNTRY_ID,
--      CUST_STATE_PROVINCE,
--      SUM(CUST_CREDIT_LIMIT) AS TOTAL_CREDIT_LIMIT,
--      RANK() OVER(PARTITION BY COUNTRY_ID ORDER BY SUM(CUST_CREDIT_LIMIT) DESC) AS state_rank_in_country
-- FROM SH.CUSTOMERS
-- GROUP BY COUNTRY_ID, CUST_STATE_PROVINCE;


--27. Find customers whose credit limit is above the 90th percentile of their income level.
-- SELECT *
-- FROM (
--     SELECT 
--         CUST_ID,
--         CUST_FIRST_NAME,
--         CUST_LAST_NAME,
--         CUST_INCOME_LEVEL,
--         CUST_CREDIT_LIMIT,
--         PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY CUST_CREDIT_LIMIT) OVER (PARTITION BY CUST_INCOME_LEVEL) AS pct_90
--     FROM SH.CUSTOMERS
-- )
-- WHERE CUST_CREDIT_LIMIT > pct_90;


--28. Display top 3 and bottom 3 customers per country by credit limit.
-- SELECT *
-- FROM (
--     SELECT
--         CUST_ID,
--         COUNTRY_ID,
--         CUST_CREDIT_LIMIT,
--         ROW_NUMBER() OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT DESC) AS rn_top,
--         ROW_NUMBER() OVER (PARTITION BY COUNTRY_ID ORDER BY CUST_CREDIT_LIMIT ASC) AS rn_bottom
--     FROM SH.CUSTOMERS
-- )
-- WHERE rn_top <= 3 OR rn_bottom <= 3;


--29.Calculate rolling sum of 5 customers’ credit limit within each country.
-- SELECT
--      CUST_ID,
--      COUNTRY_ID,
--      CUST_CREDIT_LIMIT,
--      SUM(CUST_CREDIT_LIMIT) OVER(PARTITION BY COUNTRY_ID ORDER BY CUST_ID ROWS BETWEEN 4 PRECEDING AND CURRENT ROW)  AS rolling_5_customer_sum
-- FROM SH.CUSTOMERS
-- ORDER BY COUNTRY_ID, CUST_ID;


--30.For each marital status, display the most and least wealthy customers using analytical functions.
-- SELECT *
-- FROM (
--     SELECT
--          CUST_ID,
--          CUST_MARITAL_STATUS,
--          CUST_CREDIT_LIMIT,
--          RANK() OVER (PARTITION BY CUST_MARITAL_STATUS ORDER BY CUST_CREDIT_LIMIT DESC) AS rank_most_wealthy,
--          RANK() OVER (PARTITION BY CUST_MARITAL_STATUS ORDER BY  CUST_CREDIT_LIMIT ASC) as rank_least_wealth
--     FROM SH.CUSTOMERS
-- )
-- WHERE rank_most_wealthy = 1 OR rank_least_wealth = 1