{{ config(materialized='view') }}

with products as (
    select distinct
        product_id,
        product_category_name,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm
    from {{ source('brazilian', 'products') }}
),

product_translation as (
    select distinct
        string_field_0 as product_category_name, -- Assuming this maps to product_category_name
        string_field_1 as product_category_name_english, -- Assuming this is the English translation
    from {{ source('brazilian', 'product_translation') }}
)

select
    p.product_id,
    pt.product_category_name,
    pt.product_category_name_english,
    --p.product_weight_g,
    --p.product_length_cm,
    --p.product_height_cm,
    --p.product_width_cm,
from products p
left join product_translation pt on p.product_category_name = pt.product_category_name