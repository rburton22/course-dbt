{{
  config(
    materialized='table'
  )
}}

with src_superheroes as (
    select * from {{ source('tutorial', 'superheroes') }}
),

cte_rename as (
    select
        id,
        name,
        gender,
        eye_color,
        race,
        hair_color,
        height,
        publisher,
        skin_color,
        alignment,
        weight,
        created_at::timestampntz as created_at_utc,
        updated_at::timestampntz as updated_at_utc
    from src_superheroes
)

select * from cte_rename