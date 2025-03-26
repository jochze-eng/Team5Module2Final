{{ config(materialized='view') }}

with sellers as (
    select distinct
        seller_id,
        seller_zip_code_prefix,
        seller_city,
        seller_state
    from {{ source('brazilian', 'sellers') }}
),

seller_geolocation as (
    select
        geolocation_zip_code_prefix,
        any_value(geolocation_lat) as seller_lat,
        any_value(geolocation_lng) as seller_lng
    from {{ source('brazilian', 'geolocation') }}
    group by geolocation_zip_code_prefix
)

select DISTINCT
    s.seller_id,
    s.seller_zip_code_prefix,
    s.seller_city,
    s.seller_state,
    sg.seller_lat,
    sg.seller_lng,
from sellers s
left join seller_geolocation sg on s.seller_zip_code_prefix = sg.geolocation_zip_code_prefix