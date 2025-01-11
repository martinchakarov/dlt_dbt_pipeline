WITH SOURCE AS (

      SELECT         
        _ID,
        THEATER_ID,
        LOCATION,
        _DLT_LOAD_ID,
        _DLT_ID 
    FROM {{ source('mongo_mflix', 'theaters') }}

),

FINAL AS (

    SELECT
        _ID AS THEATHER_ID,
        THEATER_ID AS THEATER_KEY,
        LOCATION AS THEATER_LOCATION,
        _DLT_LOAD_ID,
        _DLT_ID
    FROM SOURCE

)

SELECT * FROM FINAL
  