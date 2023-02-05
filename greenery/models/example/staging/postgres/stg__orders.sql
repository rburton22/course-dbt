{{
  config(
    materialized='table'
  )
}}

with src_orders as (
    select * from {{ source('postgres', 'orders') }}
),

cte_rename as (
    select
        order_id as order_guid,
        user_id as user_guid,
        promo_id as promo_desc,
        address_id as address_guid,
        {{ to_utc('created_at') }} as created_at_utc,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id as tracking_guid,
        shipping_service as shipping_service_company,
        {{ to_utc('estimated_delivery_at') }} as estimated_delivery_at_utc,
        {{ to_utc('delivered_at') }} as delivered_at_utc,
        status as delivery_status
    from src_orders
)

select * from cte_rename
