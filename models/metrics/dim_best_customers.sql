{{
    config(
        materialized='table'
       
    )
}}




WITH monthly_sales AS (
    SELECT
        O.CUSTOMER_KEY AS customer_id,
        EXTRACT(YEAR FROM O.ORDER_DATE) AS order_year,
        EXTRACT(MONTH FROM O.ORDER_DATE) AS order_month,
        SUM(P.amount) AS total_sales  -- Summing the total payment amount
  
    FROM
        {{ ref('fct_orders') }} O
    JOIN
        {{ ref('raw_payments') }} P  -- Including payments data
        ON O.ORDER_KEY = P.ORDER_ID  -- Join on ORDER_KEY
    WHERE
        O.STATUS_CODE = 'F'  -- Filtering for finalized orders (assuming 'F' means 'finalized')
    GROUP BY
        O.CUSTOMER_KEY, EXTRACT(YEAR FROM O.ORDER_DATE), EXTRACT(MONTH FROM O.ORDER_DATE)
),

ranked_customers AS (
    SELECT
        customer_id,
        order_year,
        order_month,
        total_sales,
        RANK() OVER (PARTITION BY order_year, order_month ORDER BY total_sales DESC) AS sales_rank
    FROM
        monthly_sales
)

SELECT
    customer_id,
    order_year,
    order_month,
    total_sales
FROM
    ranked_customers
WHERE
    sales_rank <= 100  -- Only top 100 customers per month
ORDER BY
    total_sales DESC
