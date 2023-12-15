-- SELECT + filtration (aka WHERE):
-- Find all top-10 tracks which name starts with T.
SELECT * FROM project.tracks
WHERE track_popularity < 10 AND track_popularity > 0 AND track_name LIKE 'T%'
ORDER BY track_popularity ASC;