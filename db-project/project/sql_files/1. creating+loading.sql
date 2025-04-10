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
