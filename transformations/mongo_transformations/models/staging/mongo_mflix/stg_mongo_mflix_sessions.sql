WITH SOURCE AS (

    SELECT 
        _ID,
        USER_ID,
        JWT,
        _DLT_LOAD_ID,
        _DLT_ID
    FROM {{ source('mongo_mflix', 'sessions') }}

),

FINAL AS (

    SELECT
        _ID AS SESSION_ID,
        USER_ID,
        MD5(JWT) AS JWT_HASH,
        _DLT_LOAD_ID,
        _DLT_ID
    FROM SOURCE

)

SELECT * FROM FINAL
  