{{
  config(
    materialized='table'
  )
}}

with order_products as (
  select * from {{ ref('int_orders_products') }}
),

cte_transformation as (
    select 
        name as product_name, 
        max(price) as product_price, 
        max(inventory) as product_inventory,
        count(order_guid) as order_cnt,
        sum(item_quantity) as product_cnt_across_orders,
        sum(item_quantity)/count(order_guid) as avg_products_per_order
    from order_products 
    group by 1
)

select * from cte_transformation
