CREATE TABLE staging_cafe_sales (
    transaction_id TEXT,
    item TEXT,
    quantity TEXT,
    price_per_unit TEXT,
    total_spent TEXT,
    payment_method TEXT,
    location TEXT,
    transaction_date TEXT
);

SELECT *
FROM staging_cafe_sales
LIMIT 10;

SELECT COUNT(*) AS total_rows
FROM staging_cafe_sales;

SELECT COUNT(*) AS missing_transaction_id
FROM staging_cafe_sales
WHERE transaction_id IS NULL
   OR TRIM(transaction_id) = '';

SELECT COUNT(*) AS missing_item
FROM staging_cafe_sales
WHERE item IS NULL
   OR TRIM(item) = ''
   OR UPPER(TRIM(item)) IN ('UNKNOWN', 'ERROR');

SELECT COUNT(*) AS invalid_quantity
FROM staging_cafe_sales
WHERE quantity IS NULL
   OR TRIM(quantity) = ''
   OR UPPER(TRIM(quantity)) IN ('UNKNOWN', 'ERROR');

SELECT COUNT(*) AS invalid_price
FROM staging_cafe_sales
WHERE price_per_unit IS NULL
   OR TRIM(price_per_unit) = ''
   OR UPPER(TRIM(price_per_unit)) IN ('UNKNOWN', 'ERROR');

SELECT COUNT(*) AS invalid_total_spent
FROM staging_cafe_sales
WHERE total_spent IS NULL
   OR TRIM(total_spent) = ''
   OR UPPER(TRIM(total_spent)) IN ('UNKNOWN', 'ERROR');

SELECT COUNT(*) AS invalid_location
FROM staging_cafe_sales
WHERE location IS NULL
   OR TRIM(location) = ''
   OR UPPER(TRIM(location)) IN ('UNKNOWN', 'ERROR');

SELECT COUNT(*) AS invalid_transaction_date
FROM staging_cafe_sales
WHERE transaction_date IS NULL
   OR TRIM(transaction_date) = ''
   OR UPPER(TRIM(transaction_date)) IN ('UNKNOWN', 'ERROR');

SELECT
    transaction_id,
    item,
    quantity,
    price_per_unit,
    total_spent,
    payment_method,
    location,
    transaction_date,
    COUNT(*) AS duplicate_count
FROM staging_cafe_sales
GROUP BY
    transaction_id,
    item,
    quantity,
    price_per_unit,
    total_spent,
    payment_method,
    location,
    transaction_date
HAVING COUNT(*) > 1;


CREATE TABLE cleaned_cafe_sales AS

SELECT
    TRIM(transaction_id) AS transaction_id,

    CASE
        WHEN UPPER(TRIM(item)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE TRIM(item)
    END AS item,

    CASE
        WHEN UPPER(TRIM(quantity)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE CAST(quantity AS INTEGER)
    END AS quantity,

    CASE
        WHEN UPPER(TRIM(price_per_unit)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE CAST(price_per_unit AS NUMERIC(10,2))
    END AS price_per_unit,

    CASE
        WHEN UPPER(TRIM(total_spent)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE CAST(total_spent AS NUMERIC(10,2))
    END AS total_spent,

    CASE
        WHEN UPPER(TRIM(payment_method)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE TRIM(payment_method)
    END AS payment_method,

    CASE
        WHEN UPPER(TRIM(location)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE TRIM(location)
    END AS location,

    CASE
        WHEN UPPER(TRIM(transaction_date)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE CAST(transaction_date AS DATE)
    END AS transaction_date

FROM staging_cafe_sales;

SELECT *
FROM cleaned_cafe_sales
LIMIT 10;


SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'cleaned_cafe_sales'
ORDER BY ordinal_position;


SELECT *
FROM cleaned_cafe_sales
WHERE total_spent IS NULL
  AND quantity IS NOT NULL
  AND price_per_unit IS NOT NULL;


UPDATE cleaned_cafe_sales
SET total_spent = quantity * price_per_unit
WHERE total_spent IS NULL
  AND quantity IS NOT NULL
  AND price_per_unit IS NOT NULL;

SELECT *
FROM cleaned_cafe_sales
WHERE total_spent IS NULL
  AND quantity IS NOT NULL
  AND price_per_unit IS NOT NUll;


DROP TABLE IF EXISTS cleaned_cafe_sales;

CREATE TABLE cleaned_cafe_sales AS

SELECT
    TRIM(transaction_id) AS transaction_id,

    CASE
        WHEN UPPER(TRIM(item)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE TRIM(item)
    END AS item,

    CASE
        WHEN UPPER(TRIM(quantity)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE CAST(quantity AS INTEGER)
    END AS quantity,

    CASE
        WHEN UPPER(TRIM(price_per_unit)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE CAST(price_per_unit AS NUMERIC(10,2))
    END AS price_per_unit,

    COALESCE(
        CASE
            WHEN UPPER(TRIM(total_spent)) IN ('UNKNOWN', 'ERROR')
                THEN NULL
            ELSE CAST(total_spent AS NUMERIC(10,2))
        END,
        CASE
            WHEN UPPER(TRIM(quantity)) NOT IN ('UNKNOWN', 'ERROR')
             AND UPPER(TRIM(price_per_unit)) NOT IN ('UNKNOWN', 'ERROR')
            THEN CAST(quantity AS NUMERIC) *
                 CAST(price_per_unit AS NUMERIC)
            ELSE NULL
        END
    ) AS total_spent,

    CASE
        WHEN UPPER(TRIM(payment_method)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE TRIM(payment_method)
    END AS payment_method,

    CASE
        WHEN UPPER(TRIM(location)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE TRIM(location)
    END AS location,

    CASE
        WHEN UPPER(TRIM(transaction_date)) IN ('UNKNOWN', 'ERROR')
            THEN NULL
        ELSE CAST(transaction_date AS DATE)
    END AS transaction_date

SELECT
    transaction_id,
    COUNT(*) AS count
FROM cleaned_cafe_sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;

SELECT *
FROM cleaned_cafe_sales
ORDER BY transaction_date
LIMIT 20;

SELECT COUNT(*) AS total_rows
FROM cleaned_cafe_sales;

SELECT
    transaction_id,
    COUNT(*) AS duplicate_count
FROM cleaned_cafe_sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS remaining_invalid_values
FROM cleaned_cafe_sales
WHERE UPPER(TRIM(item)) IN ('UNKNOWN', 'ERROR')
   OR UPPER(TRIM(payment_method)) IN ('UNKNOWN', 'ERROR')
   OR UPPER(TRIM(location)) IN ('UNKNOWN', 'ERROR');

SELECT
    COUNT(*) FILTER (WHERE transaction_id IS NULL) AS missing_transaction_id,
    COUNT(*) FILTER (WHERE item IS NULL) AS missing_item,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS missing_quantity,
    COUNT(*) FILTER (WHERE price_per_unit IS NULL) AS missing_price,
    COUNT(*) FILTER (WHERE total_spent IS NULL) AS missing_total_spent,
    COUNT(*) FILTER (WHERE payment_method IS NULL) AS missing_payment_method,
    COUNT(*) FILTER (WHERE location IS NULL) AS missing_location,
    COUNT(*) FILTER (WHERE transaction_date IS NULL) AS missing_transaction_date
FROM cleaned_cafe_sales;

SELECT COUNT(*) AS incorrect_total_spent
FROM cleaned_cafe_sales
WHERE quantity IS NOT NULL
  AND price_per_unit IS NOT NULL
  AND total_spent IS NOT NULL
  AND total_spent <> quantity * price_per_unit;

-- =====================================================
-- FINAL DATA VALIDATION
-- =====================================================

SELECT
    COUNT(*) AS total_rows,

    COUNT(*) FILTER (
        WHERE transaction_id IS NULL
    ) AS missing_transaction_id,

    COUNT(*) FILTER (
        WHERE item IS NULL
    ) AS missing_item,

    COUNT(*) FILTER (
        WHERE quantity IS NULL
    ) AS missing_quantity,

    COUNT(*) FILTER (
        WHERE price_per_unit IS NULL
    ) AS missing_price,

    COUNT(*) FILTER (
        WHERE total_spent IS NULL
    ) AS missing_total_spent,

    COUNT(*) FILTER (
        WHERE payment_method IS NULL
    ) AS missing_payment_method,

    COUNT(*) FILTER (
        WHERE location IS NULL
    ) AS missing_location,

    COUNT(*) FILTER (
        WHERE transaction_date IS NULL
    ) AS missing_transaction_date

FROM cleaned_cafe_sales;

SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'cleaned_cafe_sales'
ORDER BY ordinal_position;