SELECT
  EmployeeId AS employee_id,
  LastName,
  FirstName,
  Title,
  ReportsTo,
  BirthDate,
  HireDate,
  Address,
  City,
  State,
  Country,
  PostalCode,
  Phone,
  Fax,
  Email
FROM {{ source('raw', 'staging_employee') }}
