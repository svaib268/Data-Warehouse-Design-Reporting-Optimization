WITH employee_customers AS (
    SELECT
        e.EmployeeId,
        c.CustomerId
    FROM {{ source('raw', 'staging_employee') }} e
    JOIN {{ source('raw', 'staging_customer') }} c
        ON e.EmployeeId = c.SupportRepId
),

customer_invoices AS (
    SELECT
        c.CustomerId,
        i.Total AS invoice_total,
        i.InvoiceId
    FROM {{ source('raw', 'staging_customer') }} c
    JOIN {{ source('raw', 'staging_invoice') }} i
        ON c.CustomerId = i.CustomerId
),

aggregated_metrics AS (
    SELECT
        ec.EmployeeId,
        COUNT(DISTINCT ec.CustomerId) AS customer_count,
        SUM(ci.invoice_total) AS total_revenue,
        AVG(ci.invoice_total) AS avg_customer_value,
        COUNT(ci.InvoiceId) * 1.0 / COUNT(DISTINCT ec.CustomerId) AS avg_invoice_count,
        COUNT(DISTINCT CASE WHEN inv_count > 1 THEN ci.CustomerId END) AS retained_customers,
        COUNT(DISTINCT CASE WHEN inv_count = 1 THEN ci.CustomerId END) AS new_customers
    FROM employee_customers ec
    JOIN customer_invoices ci
        ON ec.CustomerId = ci.CustomerId
    JOIN (
        SELECT
            CustomerId,
            COUNT(*) AS inv_count
        FROM {{ source('raw', 'staging_invoice') }}
        GROUP BY CustomerId
    ) inv_ct ON ci.CustomerId = inv_ct.CustomerId
    GROUP BY ec.EmployeeId
)

SELECT
    EmployeeId,
    customer_count,
    total_revenue,
    avg_customer_value,
    avg_invoice_count,
    retained_customers,
    new_customers,
    NULL::FLOAT AS performance_score -- Placeholder for external/manual input
FROM aggregated_metrics
