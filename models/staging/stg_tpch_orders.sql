with source as (

    select * from {{ source('RAW_1', 'orders') }}

),

renamed as (

    select

        id as order_key,
        user_id as customer_key,
        
        order_date as order_date,
       
       
        status as order_status,
        _ETL_LOADED_AT as order_loaded_at

    from source

)

select * from renamed