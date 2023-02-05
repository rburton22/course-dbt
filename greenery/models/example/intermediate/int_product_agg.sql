{{
  config(
    materialized='table'
  )
}}

with events as (
  select * from {{ ref('stg__events') }}
),

products as (
   select * from {{ ref('stg__products') }}
),

order_items as (
   select * from {{ ref('stg__order_items') }}
),

cte_sessions as (
    select
       product_guid,
       count(distinct session_guid) as unique_sessions
    from events
    where product_guid is not null
    group by 1
),

cte_product_orders as (
   select
      product.product_guid,
      count(distinct orders.order_guid) as orders_cnt
   from products as product
   left join order_items as orders
      on product.product_guid = orders.product_guid
   group by 1
),

cte_final as (
    select
       sessions.product_guid,
       products.name,
       prod_orders.orders_cnt as product_orders_cnt,
       sessions.unique_sessions as unique_sessions
    from cte_sessions as sessions
    left join products
       on sessions.product_guid = products.product_guid
    left join cte_product_orders as prod_orders
       on sessions.product_guid = prod_orders.product_guid
)

select * from cte_final
