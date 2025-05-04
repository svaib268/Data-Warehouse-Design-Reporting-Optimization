SELECT
    E.employee_id,
    I.invoicedate AS generated_date,
    COUNT(DISTINCT I.customer_id) AS customer_count,
    SUM(I.total) AS total_revenue,
    MAX(G.genre_name) AS popular_genre,         -- approximate representation
    MAX(A.album_title) AS popular_album,        -- approximate representation
    'Sales Report' AS report_type,
    0 AS access_count                           -- placeholder
FROM {{ ref('dim_invoice') }} I
JOIN {{ ref('dim_customer') }} C ON I.customer_id = C.customer_id
JOIN {{ ref('dim_employee') }} E ON C.support_employee_id = E.employee_id
LEFT JOIN {{ ref('dim_album') }} A ON A.artist_id = E.employee_id
LEFT JOIN {{ ref('dim_genre') }} G ON G.genre_id = C.customer_id   -- adjust if needed

GROUP BY
    E.employee_id,
    I.invoicedate
