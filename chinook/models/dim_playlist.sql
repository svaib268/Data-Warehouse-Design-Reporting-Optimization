SELECT
  PlaylistId AS playlist_id,
  Name AS playlist_name
FROM {{ source('raw', 'staging_playlist') }}
