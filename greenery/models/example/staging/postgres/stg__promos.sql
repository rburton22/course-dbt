{{
  config(
    materialized='table'
  )
}}

with src_promos as (
    select * from {{ source('postgres', 'promos') }}
),

cte_rename as (
    select
        promo_id as promo_type,
        discount,
        status as active_status
    from src_promos
)

select * from cte_rename
