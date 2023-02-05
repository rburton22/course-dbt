{{
  config(
    materialized='table'
  )
}}

with orders as (
  select * from {{ ref('stg__orders') }}
),

products as (
  select * from {{ ref('stg__products') }}
),

order_items as (
  select * from {{ref('stg__order_items') }}
),

promos as (
  select * from {{ ref('stg__promos') }}
),

cte_join as (
  select
    orders.order_guid,
    products.name,
    products.price,
    products.inventory,
    order_items.item_quantity,
    orders.promo_desc,
    promos.discount,
    promos.active_status,
    orders.user_guid,
    orders.address_guid,
    orders.created_at_utc,
    orders.order_cost,
    orders.shipping_cost,
    orders.order_total,
    orders.tracking_guid,
    orders.shipping_service_company,
    orders.estimated_delivery_at_utc,
    orders.delivered_at_utc,
    orders.delivery_status
  from orders
  left join order_items as order_items
    on orders.order_guid = order_items.order_guid
  left join products as products
    on order_items.product_guid = products.product_guid
  left join promos as promos
    on orders.promo_desc = promos.promo_type
)

select * from cte_join
