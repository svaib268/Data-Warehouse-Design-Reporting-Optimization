SELECT
  ArtistId AS artist_id,
  Name AS artist_name
FROM {{ source('raw', 'staging_artist') }}
