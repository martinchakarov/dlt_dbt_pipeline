WITH SOURCE AS (

      SELECT 
        _ID,
        NAME,
        EMAIL,
        PASSWORD,
        PREFERENCES,
        _DLT_LOAD_ID,
        _DLT_ID
      FROM {{ source('mongo_mflix', 'users') }}

),

FINAL AS (

    SELECT
        _ID AS USER_ID,
        NAME AS USERNAME,
        EMAIL AS EMAIL,
        PASSWORD,
        PREFERENCES,
        _DLT_LOAD_ID,
        _DLT_ID
    FROM SOURCE

)

SELECT * FROM FINAL
  