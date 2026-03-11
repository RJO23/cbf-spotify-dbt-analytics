with source as (
    select * from {{ source('raw_spotify', 'tracks') }}
),

renamed as (
    select
        cast(track_id as string) as track_id,
        cast(track_name as string) as track_name,
        cast(artists as string) as artist_names,
        cast(album_name as string) as album_name,
        
        lower(trim(track_genre)) as track_genre,
        
        cast(popularity as int64) as popularity,
        
        cast(danceability as float64) as danceability,
        cast(energy as float64) as energy,
        cast(tempo as float64) as tempo,
        
        cast(duration_ms as int64) as duration_ms,
        
        {{ convert_ms_to_minutes('duration_ms') }} as duration_minutes

    from source
    where track_id is not null

    QUALIFY ROW_NUMBER() OVER (PARTITION BY track_id ORDER BY track_id) = 1
)

select * from renamed