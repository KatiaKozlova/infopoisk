-- SELECT + JOIN + else:
-- Show at least a little bit acoustic (>0.2) songs released in summer 2019.
SELECT track_name, track_artist, track_album_name, track_popularity
FROM sys.tracks
JOIN sys.track_to_album ON 
    tracks.track_id = track_to_album.track_id
JOIN sys.albums ON
	track_to_album.track_album_id = albums.track_album_id
WHERE track_album_release_date BETWEEN '2019-06-01' AND '2019-08-31'
	AND tracks.track_id IN 
		(SELECT track_id 
		FROM track_characteristics 
		WHERE acousticness > 0.2)
ORDER BY track_popularity DESC;
