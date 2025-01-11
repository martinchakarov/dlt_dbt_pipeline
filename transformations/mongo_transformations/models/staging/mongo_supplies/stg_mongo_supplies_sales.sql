WITH SOURCE AS (
    
      SELECT 
        _ID,
        SALE_DATE,
        ITEMS,
        STORE_LOCATION,
        CUSTOMER,
        COUPON_USED,
        PURCHASE_METHOD,
        _DLT_LOAD_ID,
        _DLT_ID
      FROM {{ source('mongo_supplies', 'sales') }}
),

FINAL AS (

    SELECT
        _ID AS SALE_ID,
        SALE_DATE,
        ITEMS,
        STORE_LOCATION,
        CUSTOMER AS CUSTOMER_DETAILS,
        COUPON_USED AS IS_COUPON_USED,
        PURCHASE_METHOD,
        _DLT_LOAD_ID,
        _DLT_ID
    FROM SOURCE
)
SELECT * FROM FINAL
  