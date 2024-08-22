-- a SQL script that creates a stored procedure ComputeAverageWeightedScoreForUser
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUser;
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
	DECLARE total_weighted_score INT DEFAULT 0;
	DECLARE total_weight INT DEFAULT 0;

	SELECT SUM(corrections.score * projects.weight)
	INTO total_weighted_score
	FROM corrections INNER JOIN projects ON corrections.project_id = projects.id
	WHERE corrections.user_id = user_id;

	SELECT SUM(projects.weight)
	INTO total_weight
	FROM projects
	INNER JOIN corrections ON corrections.project_id = projects.id
	WHERE corrections.user_id = user_id;

	UPDATE users
	SET users.average_score = (
		total_weighted_score / total_weight
	)
	WHERE users.id = user_id;
END $$
DELIMITER ;
