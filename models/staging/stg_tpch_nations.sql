with source as (

    select * from {{ source('RAW_2', 'payment') }}

),

renamed as (

    select

        id as payment_key,
        orderid as order_key,
        paymentmethod as  payment_method,
        status as payment_status,
        amount as payment_amount,
        created as payment_date,
        _batched_at as payment_loaded_at
    
    from source

)
select * from renamed




