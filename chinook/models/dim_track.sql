
SELECT
  TrackId AS track_id,
  Name AS track_name,
  AlbumId AS album_id,
  MediaTypeId AS media_type_id,
  GenreId AS genre_id,
  Composer,
  Milliseconds,
  Bytes,
  UnitPrice
FROM {{ source('raw', 'staging_track') }}
