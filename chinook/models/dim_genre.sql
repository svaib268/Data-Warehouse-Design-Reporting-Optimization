SELECT
  GenreId AS genre_id,
  Name AS genre_name
FROM {{ source('raw', 'staging_genre') }}
