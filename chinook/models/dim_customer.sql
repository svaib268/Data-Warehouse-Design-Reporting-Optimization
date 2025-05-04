SELECT
  CustomerId AS customer_id,
  FirstName,
  LastName,
  Company,
  Address,
  City,
  State,
  Country,
  PostalCode,
  Phone,
  Fax,
  Email,
  SupportRepId AS support_employee_id
FROM {{ source('raw', 'staging_customer') }}
