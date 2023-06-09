with stg_customer as (
    select
        customerid,
        personid,
        storeid
    from {{ ref('stg_sales__customer') }}
),

stg_person as (
    select
        businessentityid,
        concat(coalesce(firstname, ''), ' ', coalesce(middlename, ''), ' ', coalesce(lastname, '')) as fullname
    from {{ ref('stg_person__person') }}
),

stg_store as (
    select
        businessentityid as storebusinessentityid,
        storename
    from {{ ref('stg_sales__store') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['stg_customer.customerid']) }} as customer_key,
    stg_customer.customerid,
    stg_person.businessentityid,
    stg_person.fullname,
    stg_store.storebusinessentityid,
    stg_store.storename
from stg_customer
join stg_person on stg_customer.personid = stg_person.businessentityid
join stg_store on stg_customer.storeid = stg_store.storebusinessentityid
