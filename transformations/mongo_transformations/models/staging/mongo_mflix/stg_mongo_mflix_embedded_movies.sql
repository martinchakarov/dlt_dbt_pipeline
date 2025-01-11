WITH SOURCE AS (

        SELECT 
            _ID,
            PLOT,
            GENRES,
            RUNTIME,
            RATED,
            "CAST",
            POSTER,
            TITLE,
            FULLPLOT,
            LANGUAGES,
            RELEASED,
            DIRECTORS,
            WRITERS,
            AWARDS,
            LASTUPDATED,
            YEAR,
            IMDB,
            COUNTRIES,
            TYPE,
            TOMATOES,
            NUM_MFLIX_COMMENTS,
            PLOT_EMBEDDING,
            _DLT_LOAD_ID,
            _DLT_ID,
            METACRITIC,
            YEAR__V_TEXT
        FROM {{ source('mongo_mflix', 'embedded_movies') }}
        
),

FINAL AS (

        SELECT
            _ID AS MOVIE_ID,
            PLOT AS MOVIE_PLOT,
            GENRES AS MOVIE_GENRES,
            RUNTIME AS MOVIE_RUNTIME,
            RATED AS MOVIE_RATING,
            "CAST" AS CAST_NAMES,
            POSTER AS MOVIE_POSTER_URL,
            TITLE AS MOVIE_TITLE,
            FULLPLOT AS MOVIE_FULL_PLOT,
            LANGUAGES AS MOVIE_LANGUAGES,
            RELEASED::DATE AS MOVIE_RELEASE_DATE,
            DIRECTORS AS MOVIE_DIRECTORS_NAMES,
            WRITERS AS MOVIE_WRITERS_NAMES,
            AWARDS AS MOVIE_AWARDS_DETAILS,
            LASTUPDATED AS LAST_UPDATED_AT,
            YEAR AS MOVIE_RELEASE_YEAR,
            IMDB AS IMDB_DETAILS,
            COUNTRIES AS MOVIE_RELEASE_COUNTRIES,
            TYPE AS MOVIE_TYPE,
            TOMATOES AS ROTTEN_TOMATOES_DETAILS,
            NUM_MFLIX_COMMENTS AS COMMENT_COUNT,
            METACRITIC AS METACRITIC_SCORE,
            _DLT_LOAD_ID,
            _DLT_ID,
        FROM SOURCE

)

SELECT * FROM FINAL
  