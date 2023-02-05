{{
  config(
    materialized='table'
  )
}}

with users as (
  select * from {{ ref('stg__users') }}
),

orders as (
    select * from {{ ref('stg__orders') }}
),

cte_join as (
  select
    orders.order_guid,
    orders.created_at_utc,
    orders.order_total,
    users.user_guid,
    users.first_name,
    users.last_name,
    users.email,
    users.phone_number,
    users.address_guid
  from users
  left join orders
    on orders.user_guid = users.user_guid
)

select * from cte_join
