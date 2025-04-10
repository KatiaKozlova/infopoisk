-- Checking the trigger
INSERT INTO project.tracks VALUES 
	('3cPoiK69oQ1SdbB2j2ulGm', 'The Hardest Part', 'Olivia Dean', 2, 3),
    ('1lD6h2A4xBeETmLmUiq5MM', 'Eyes Shut', 'Acopia', 1, 206);
SELECT * FROM project.tracks
WHERE track_id = '3cPoiK69oQ1SdbB2j2ulGm' OR track_id = '1lD6h2A4xBeETmLmUiq5MM';
