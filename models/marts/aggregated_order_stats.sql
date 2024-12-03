
{{ config(
    materialized='table'
) }}

WITH aggregated_data AS (
    {{ aggregate_order_data() }}
)

SELECT * FROM aggregated_data
