-- models/fact_playlist_engagement.sql

SELECT
  p.playlist_id,
  p.playlist_name,
  t.track_id,
  t.track_name,
  t.genre_id,
  g.genre_name,
  t.album_id,
  al.album_title,
  al.artist_id,
  ar.artist_name,
  t.milliseconds,
  t.unitprice
FROM {{ ref('dim_playlist') }} p
JOIN {{ ref('dim_track') }} t ON p.playlist_id = t.track_id
LEFT JOIN {{ ref('dim_genre') }} g ON t.genre_id = g.genre_id
LEFT JOIN {{ ref('dim_album') }} al ON t.album_id = al.album_id
LEFT JOIN {{ ref('dim_artist') }} ar ON al.artist_id = ar.artist_id
