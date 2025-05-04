SELECT
  AlbumId AS album_id,
  Title AS album_title,
  ArtistId AS artist_id
FROM {{ source('raw', 'staging_album') }}
