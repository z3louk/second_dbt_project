with
    customers_names as (select * from {{ ref("stg_tpch_line_items") }}),
    all_payment as (select * from {{ ref("int_order_items") }})

select
    all_payment.customer_key,
    customers_names.first_name,
    customers_names.last_name,
    sum(all_payment.payment_amount) as total_payment_amount  -- Sum of payment_amount for each customer
from all_payment
inner join customers_names on all_payment.customer_key = customers_names.customer_key
group by all_payment.customer_key, customers_names.first_name, customers_names.last_name
order by total_payment_amount DESC  -- Ordering by total payment amount, if needed
