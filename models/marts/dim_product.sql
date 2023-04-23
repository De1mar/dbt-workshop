with stg_product as (
    select *
    from {{ ref('stg_production__product') }}
),

stg_product_subcategory as (
    select *
    from {{ ref('stg_production__productsubcategory') }}
),

stg_product_category as (
    select *
    from {{ ref('stg_production__productcategory') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['stg_product.productid']) }} as product_key,
    stg_product.productid,
    stg_product.name as product_name,
    stg_product.productnumber,
    stg_product.color,
    stg_product.class,
    stg_product_subcategory.name as product_subcategory_name,
    stg_product_category.name as product_category_name
from stg_product
left join stg_product_subcategory on cast(stg_product.productsubcategoryid as TEXT) = cast(stg_product_subcategory.productsubcategoryid as TEXT)
left join stg_product_category on cast(stg_product_subcategory.productcategoryid as TEXT) = cast(stg_product_category.productcategoryid as TEXT)