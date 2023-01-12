{{
  config(
    materialized='table'
  )
}}

with src_order_items as (
    select * from {{ source('postgres', 'order_items') }}
),

cte_rename as (
    select
        order_id as order_guid,
        product_id as product_guid,
        quantity as item_quantity
    from src_order_items
)

select * from cte_rename
