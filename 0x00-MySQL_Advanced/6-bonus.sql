--  a SQL script that creates a stored procedure AddBonus
-- that adds a new correction for a student.
DELIMITER $$
CREATE PROCEDURE AddBonus(IN id INT, IN project_name varchar(255), IN score float)
BEGIN
	UPDATE corrections SET corrections.score = score
	WHERE corrections.user_id = id 
END$$
DELIMITER ;
