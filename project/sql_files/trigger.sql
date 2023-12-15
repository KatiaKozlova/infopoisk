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