{{
  config(
    materialized='table'
  )
}}

with users_orders as (
  select * from {{ ref('int_users_orders') }}
),

cte_transformation as (
    select
       user_guid,
       first_name,
       last_name,
       email,
       phone_number,
       count(order_guid) as order_cnt,
       min(created_at_utc) as first_order_at_utc,
       max(created_at_utc) as latest_order_at_utc,
       sum(order_total) as total_spend 
   from users_orders 
   group by 1,2,3,4,5
)

select * from cte_transformation
