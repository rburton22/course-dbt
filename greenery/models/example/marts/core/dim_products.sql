{{
  config(
    materialized='table'
  )
}}

with products as (
  select * from {{ ref('stg__products') }}
),

cte_final as (
    select
       product_guid,
       name,
       price,
       inventory,
       (price * inventory) as revenue_potential
    from products
)

select * from cte_final
