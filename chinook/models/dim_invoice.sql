SELECT
  InvoiceId AS invoice_id,
  CustomerId AS customer_id,
  InvoiceDate,
  BillingAddress,
  BillingCity,
  BillingState,
  BillingCountry,
  BillingPostalCode,
  Total
FROM {{ source('raw', 'staging_invoice') }}
