{{ config(materialized='view') }}

with customers as (
    select distinct
        customer_id,
        customer_unique_id,
        customer_zip_code_prefix,
        customer_city,
        customer_state
    from {{ source('brazilian', 'customers_dataset') }}
),

geolocation as (
    select 
        geolocation_zip_code_prefix,
        any_value(geolocation_lat) as geolocation_lat,
        any_value(geolocation_lng) as geolocation_lng,
    from {{ source('brazilian', 'geolocation') }}
    group by 1 -- Group by zip code prefix to handle multiple lat/lng for the same prefix
)

select distinct
    c.customer_id,
    c.customer_unique_id,
    c.customer_zip_code_prefix,
    c.customer_city,
    c.customer_state,
    g.geolocation_lat,
    g.geolocation_lng
from customers c
left join geolocation g on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix