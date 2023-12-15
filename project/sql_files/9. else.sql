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
