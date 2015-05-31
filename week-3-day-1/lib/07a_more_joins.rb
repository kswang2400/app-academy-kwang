# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
    SELECT
      artist
    FROM
      albums
    JOIN
      tracks ON albums.asin = tracks.album
    WHERE
      song = 'Alison'
  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
    SELECT
      artist
    FROM
      albums
    JOIN
      tracks ON albums.asin = tracks.album
    WHERE
      song = 'Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
    SELECT
      song
    FROM
      tracks
    JOIN
      albums ON tracks.album = albums.asin
    WHERE
      title = 'Blur'
  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
    SELECT
      title, SUM(1)
    FROM
      albums
    JOIN
      tracks ON albums.asin = tracks.album
    WHERE
      song LIKE '%Heart%'
    GROUP BY
      title
    ORDER BY
      SUM DESC, title ASC

  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
    SELECT
      song
    FROM
      tracks
    JOIN
      albums ON tracks.album = albums.asin
    WHERE
      song = title
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
    SELECT
      title
    FROM
      albums
    WHERE
      title = artist
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
    SELECT
      song, SUM(1)
    FROM
      tracks
    JOIN
      albums ON tracks.album = albums.asin
    GROUP BY
      song
    HAVING
      SUM(1) >= 3


  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
    SELECT
      title, price, SUM(1)
    FROM
      albums
    JOIN
      tracks ON albums.asin = tracks.album
    GROUP BY
      title, price
    HAVING
      (price / SUM(1)) < .5
  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums in order of track count. Select both the
  # album title and the track count.
  execute(<<-SQL)
    SELECT
      title, SUM(1)
    FROM
      albums
    JOIN
      tracks ON albums.asin = tracks.album
    GROUP BY
      title
    ORDER BY
      SUM(1) DESC
    LIMIT
      10

  SQL
end

def soundtrack_wars
  # Select the artist who has recorded the most soundtracks, as well as the
  # number of albums. HINT: use LIKE '%Soundtrack%' in your query.
  execute(<<-SQL)
    SELECT
      artist, SUM(1)
    FROM
      albums
    JOIN
      styles ON styles.album = albums.asin
    WHERE
      style LIKE '%Soundtrack%'
    GROUP BY
      artist
    ORDER BY
      SUM(1) DESC
    LIMIT
      1
  SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track.

  execute(<<-SQL)
    -- SELECT
    --   style, AVG(albums.price / total_tracks) AS price_per_track
    -- FROM
    --   styles
    -- JOIN
    --   albums ON styles.album = albums.asin
    -- JOIN
    --   (
    --     SELECT
    --       asin, COUNT(*) AS total_tracks
    --     FROM
    --       albums
    --     JOIN
    --       tracks ON albums.asin = tracks.album
    --     GROUP BY
    --       asin
    --     HAVING
    --       COUNT(*) > 0
    --   ) AS tracks_per_album ON tracks_per_album.asin = styles.album
    -- WHERE
    --   albums.price IS NOT NULL
    -- GROUP BY
    --   style
    -- ORDER BY
    --   AVG(albums.price / total_tracks) DESC
    -- LIMIT
    --   5


    SELECT
      style, SUM(albums.price) / SUM(total_tracks) AS price_per_track
    FROM
      styles
    JOIN
      albums ON styles.album = albums.asin
    JOIN
      (
        SELECT
          asin, COUNT(*) AS total_tracks
        FROM
          albums
        JOIN
          tracks ON albums.asin = tracks.album
        GROUP BY
          asin
        HAVING
          COUNT(*) > 0
      ) AS tracks_per_album ON tracks_per_album.asin = styles.album
    WHERE
      albums.price IS NOT NULL
    GROUP BY
      style
    ORDER BY
      SUM(albums.price) / SUM(total_tracks) DESC
    LIMIT
      5

  SQL
end
