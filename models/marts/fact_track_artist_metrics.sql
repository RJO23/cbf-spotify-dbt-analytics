{{ config(materialized='table') }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['t.track_id']) }}  AS track_key,
    {{ dbt_utils.generate_surrogate_key(['a.artist_name']) }}  AS artist_key,
    
    t.track_id,
    t.popularity,
    t.danceability,
    t.energy,
    t.duration_minutes, -- Moved from dim_track
    t.tempo
FROM {{ ref('int_track_deduped') }} AS t
JOIN {{ ref('int_tracks_artists') }} AS a
    ON t.track_id = a.track_id