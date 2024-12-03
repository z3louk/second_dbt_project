
{% macro aggregate_order_data() %}
    SELECT
        STATUS_CODE,
        PRIORITY_CODE,
        COUNT(ORDER_KEY) AS order_count,
        SUM(GROSS_ITEM_SALES_AMOUNT) AS total_gross_sales,
        SUM(ITEM_DISCOUNT_AMOUNT) AS total_discounts,
        SUM(ITEM_TAX_AMOUNT) AS total_taxes,
        SUM(NET_ITEM_SALES_AMOUNT) AS total_net_sales
    FROM
         {{ ref('fct_orders') }}
    GROUP BY
        STATUS_CODE,
        PRIORITY_CODE
    
{% endmacro %}
