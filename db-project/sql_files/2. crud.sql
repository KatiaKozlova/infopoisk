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
