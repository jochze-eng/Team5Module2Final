{{ config(materialized='table') }} -- Fact tables are often materialized as tables

with order_items as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date,
        price,
        freight_value
    from {{ source('brazilian', 'order_items') }}
),

orders as (
    select
        order_id,
        customer_id
    from {{ ref('dim_orders') }}
),

order_totals as (
    select
        order_id,
        sum(price + freight_value) as order_total
    from order_items
    group by order_id
)
select
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    oi.shipping_limit_date,
    oi.price,
    oi.freight_value,
    o.customer_id,
    ot.order_total
from order_items oi
left join orders o on oi.order_id = o.order_id
left join order_totals ot on oi.order_id = ot.order_id
