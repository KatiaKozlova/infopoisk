-- FUNCTION:
-- Show the place of the most popular song of the specific artist (inserted by user).
DELIMITER $$
CREATE FUNCTION project.TheMostPopularSong(
	artist_value VARCHAR(100)
)
RETURNS BIGINT DETERMINISTIC
BEGIN
	DECLARE minimum SMALLINT;
	SET minimum = (SELECT MIN(track_popularity)
	FROM project.tracks
	WHERE track_artist = artist_value AND track_popularity != 0);
	RETURN minimum;
END $$
DELIMITER ;
