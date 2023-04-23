{% snapshot person_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='businessentityid',

      strategy='timestamp',
      updated_at='modifieddate',
    )
}}

select * from {{ source('person', 'person') }}

{% endsnapshot %}

