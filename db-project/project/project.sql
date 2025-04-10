-- Creating project-schema
CREATE SCHEMA project;

-- Creating table for tracks
CREATE TABLE IF NOT EXISTS project.tracks
(
	track_id VARCHAR(25) PRIMARY KEY NOT NULL,
	track_name VARCHAR(255) NOT NULL,
	track_artist VARCHAR(255) NOT NULL,
	track_popularity SMALLINT,
	duration_ms BIGINT NOT NULL
);

-- Uploading table for tracks from local CSV
LOAD DATA LOCAL INFILE '[path_to_file]/tracks.csv'  -- You need to change the path...
INTO TABLE project.tracks 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Creating table for albums
CREATE TABLE IF NOT EXISTS project.albums
(
	track_album_id VARCHAR(25) PRIMARY KEY NOT NULL,
	track_album_name VARCHAR(255) NOT NULL,
	track_album_release_date DATE NOT NULL
);

-- Uploading table for albums from local CSV
LOAD DATA LOCAL INFILE '[path_to_file]/albums.csv'  -- You need to change the path...
INTO TABLE project.albums 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Creating table for playlists
CREATE TABLE IF NOT EXISTS project.playlists
(
	playlist_id VARCHAR(25) PRIMARY KEY NOT NULL,
	playlist_name VARCHAR(255) NOT NULL,
	playlist_genre VARCHAR(255) NOT NULL,
    playlist_subgenre VARCHAR(255)
);

-- Uploading table for playlists from local CSV
LOAD DATA LOCAL INFILE '[path_to_file]/playlists.csv'  -- You need to change the path...
INTO TABLE project.playlists 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Creating table for tracks' characteristics
CREATE TABLE IF NOT EXISTS project.track_characteristics
(
	track_id VARCHAR(25) PRIMARY KEY NOT NULL,
	danceability DOUBLE NOT NULL,
	energy DOUBLE NOT NULL,
    key_ SMALLINT NOT NULL,
    loudness DOUBLE NOT NULL,
    mode SMALLINT NOT NULL,
    speechiness DOUBLE NOT NULL,
    acousticness DOUBLE NOT NULL,
    instrumentalness DOUBLE NOT NULL,
    liveness DOUBLE NOT NULL,
    valence DOUBLE NOT NULL,
    tempo DOUBLE NOT NULL
);

-- Uploading table for tracks' characteristics from local CSV
LOAD DATA LOCAL INFILE '[path_to_file]/track_characteristics.csv'  -- You need to change the path...
INTO TABLE project.track_characteristics 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Creating table for track-to-album connection
CREATE TABLE IF NOT EXISTS project.track_to_album
(
	id_table SMALLINT PRIMARY KEY NOT NULL,
	track_id VARCHAR(25) NOT NULL,
	track_album_id VARCHAR(25) NOT NULL
);

-- Uploading table for track-to-album connection from local CSV
LOAD DATA LOCAL INFILE '[path_to_file]/track_to_album.csv'  -- You need to change the path...
INTO TABLE project.track_to_album
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Creating table for track-to-playlist connection
CREATE TABLE IF NOT EXISTS project.track_to_playlist
(
	id_table SMALLINT PRIMARY KEY NOT NULL,
	track_id VARCHAR(25) NOT NULL,
	playlist_id VARCHAR(25) NOT NULL
);

-- Uploading table for track-to-playlist connection from local CSV
LOAD DATA LOCAL INFILE '[path_to_file]/track_to_playlist.csv'  -- You need to change the path...
INTO TABLE project.track_to_playlist
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- CRUD
	-- Create aka INSERT & Read aka SELECT
INSERT INTO project.tracks VALUES
	('52NczVizsfo25zI403QkdU', 'Seven', 'Andrew Animal', 100, 408512);
SELECT * FROM project.tracks
WHERE track_id = '52NczVizsfo25zI403QkdU';
	-- Update aka UPDATE
UPDATE project.tracks
SET track_name = 'Eight', track_artist = 'Andrew Bird'
WHERE track_id = '52NczVizsfo25zI403QkdU';
SELECT * FROM project.tracks
WHERE track_id = '52NczVizsfo25zI403QkdU';
	-- Delete aka DELETE
DELETE FROM project.tracks
WHERE track_id = '52NczVizsfo25zI403QkdU';
SELECT * FROM project.tracks
WHERE track_id = '52NczVizsfo25zI403QkdU';

-- SELECT + filtration (aka WHERE):
-- Find all top-10 tracks which name starts with T.
SELECT * FROM project.tracks
WHERE track_popularity < 10 AND track_popularity > 0 AND track_name LIKE 'T%'
ORDER BY track_popularity ASC;

-- SELECT + grouping (aka GROUP BY) + aggregation (aka COUNT):
-- How many songs each artist have in this table (in descending order)?
SELECT track_artist, COUNT(track_name) as n_songs FROM project.tracks
GROUP BY track_artist
ORDER BY n_songs DESC;

-- SELECT + subquery:
-- Show name, artist and popularity of the speechful songs (>0.8).
SELECT track_name, track_artist, track_popularity FROM project.tracks 
WHERE tracks.track_id IN 
	(SELECT track_id 
	FROM track_characteristics 
	WHERE speechiness > 0.8);

-- SELECT + JOIN + else:
-- Show at least a little bit acoustic (>0.2) songs released in summer 2019.
SELECT track_name, track_artist, track_album_name, track_popularity
FROM project.tracks
JOIN project.track_to_album ON 
    tracks.track_id = track_to_album.track_id
JOIN project.albums ON
	track_to_album.track_album_id = albums.track_album_id
WHERE track_album_release_date BETWEEN '2019-06-01' AND '2019-08-31'
	AND tracks.track_id IN 
		(SELECT track_id 
		FROM track_characteristics 
		WHERE acousticness > 0.2)
ORDER BY track_popularity DESC;

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
-- Call for function
SELECT project.TheMostPopularSong('Ed Sheeran');

-- TRIGGER:
-- Checks that user inserts the duration of the song in ms (not in min or sec) and converts them if it's needed.
DELIMITER $$
CREATE TRIGGER upd_tracks BEFORE INSERT ON project.tracks
       FOR EACH ROW
       BEGIN
           IF NEW.duration_ms < 100 THEN
               SET NEW.duration_ms = NEW.duration_ms * 60000;
           ELSEIF NEW.duration_ms > 100 AND NEW.duration_ms < 1000 THEN
               SET NEW.duration_ms = NEW.duration_ms * 1000;
           END IF;
       END $$
DELIMITER ;
-- Checking the trigger
INSERT INTO project.tracks VALUES 
	('3cPoiK69oQ1SdbB2j2ulGm', 'The Hardest Part', 'Olivia Dean', 2, 3),
    ('1lD6h2A4xBeETmLmUiq5MM', 'Eyes Shut', 'Acopia', 1, 206);
SELECT * FROM project.tracks
WHERE track_id = '3cPoiK69oQ1SdbB2j2ulGm' OR track_id = '1lD6h2A4xBeETmLmUiq5MM';

-- Something else:
-- Converts pitch classes to normal tonal counterparts.
SELECT track_name, track_artist, key_,
CASE
    WHEN key_ = 0 THEN 'The key is C (do)'
    WHEN key_ = 1 THEN 'The key is C♯ or D♭'
    WHEN key_ = 2 THEN 'The key is D (re)'
    WHEN key_ = 3 THEN 'The key is D♯ or E♭'
    WHEN key_ = 4 THEN 'The key is E (mi)'
    WHEN key_ = 5 THEN 'The key is F (fa)'
    WHEN key_ = 6 THEN 'The key is F♯ or G♭'
    WHEN key_ = 7 THEN 'The key is G (sol)'
    WHEN key_ = 8 THEN 'The key is G♯ or A♭'
    WHEN key_ = 9 THEN 'The key is A (la)'
    WHEN key_ = 10 THEN 'The key is A♯ or B♭'
    WHEN key_ = 11 THEN 'The key is B (si)'
    ELSE 'The key is unknown'
END AS key_meaning
FROM project.track_characteristics
JOIN project.tracks ON tracks.track_id = track_characteristics.track_id;