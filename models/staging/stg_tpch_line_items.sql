with source as (

    select * from {{ source('RAW_1', 'Customers') }}

),

renamed as (

    select
    
        
        id as customer_key,
        first_name as first_name,
        last_name as last_name
        

    from source

)

select * from renamed