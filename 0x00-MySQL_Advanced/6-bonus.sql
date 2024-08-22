--  a SQL script that creates a stored procedure AddBonus
-- that adds a new correction for a student.
DROP PROCEDURE IF EXISTS AddBonus;
DELIMITER $$
CREATE PROCEDURE AddBonus(IN id INT, IN project_name varchar(255), IN score float)
BEGIN
	DECLARE project_id INT;
	SELECT id INTO project_id FROM projects
	WHERE project_name = name;
	IF project_id is NULL THEN
		INSERT INTO projects(name) VALUES (project_name);
		SET project_id = LAST_INSERT_ID();
	END IF;
	INSERT INTO corrections (user_id, project_id, score)
	VALUES (id, project_id, score);
END$$
DELIMITER ;
