with staged_tracks as (

    select * from {{ ref('stg_tracks') }}
),

enriched as (
    select
       
        track_id,
        track_name,
        artist_names,
        album_name,
        track_genre,
        popularity,
        danceability,
        energy,
        tempo,
        duration_minutes,

        -- Popularity Buckets
        case
            when popularity >= 80 then 'High'
            when popularity >= 50 then 'Medium'
            else 'Low'
        end as popularity_bucket,

        -- Duration Categories
        case
            when duration_minutes < 3.0 then 'Short (< 3 mins)'
            when duration_minutes <= 5.0 then 'Standard (3-5 mins)'
            else 'Long (> 5 mins)'
        end as duration_category,

        -- Tempo Groupings
        case
            when tempo >= 120.0 then 'Fast'
            when tempo >= 90.0 then 'Medium'
            else 'Slow'
        end as tempo_category

    from staged_tracks
)

select * from enriched