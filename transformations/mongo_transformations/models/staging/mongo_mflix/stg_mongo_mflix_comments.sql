with source as (
      select 
        _ID,
        NAME,
        EMAIL,
        MOVIE_ID,
        TEXT,
        DATE,
        _DLT_LOAD_ID,
        _DLT_ID
      from {{ source('mongo_mflix', 'comments') }}
),

final as (
    select
        _ID AS COMMENT_ID,
        NAME AS COMMENTER_NAME,
        EMAIL AS COMMENTER_EMAIL,
        MOVIE_ID,
        TEXT AS COMMENT_TEXT,
        DATE AS COMMENT_DATE,
        _DLT_LOAD_ID,
        _DLT_ID
    from source
)
select * from final
  