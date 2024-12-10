with
    orders as (select * from {{ ref("stg_tpch_orders") }}),

    payment as (select * from {{ ref("stg_tpch_nations") }})
select

    
    orders.order_key,
    orders.customer_key,
    orders.order_date,
    orders.order_status ,
    payment.payment_key,
    payment.payment_method,
    payment.payment_status,
    payment.payment_amount,
    payment.payment_date
   

    

from orders
inner join payment on orders.order_key = payment.order_key
order by orders.customer_key
