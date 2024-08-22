-- Add the column before creating the procedure
ALTER TABLE users ADD total_weighted_score INT DEFAULT 0;

DELIMITER $$

DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE total_weight INT DEFAULT 0;

    -- Update total weighted score for each user
    UPDATE users
    SET users.total_weighted_score = (
        SELECT SUM(corrections.score * projects.weight)
        FROM corrections
        INNER JOIN projects ON corrections.project_id = projects.id
        WHERE corrections.user_id = users.id
    );

    -- Calculate and update the average score for each user
    UPDATE users
    SET users.average_score = (
        SELECT users.total_weighted_score / SUM(projects.weight)
        FROM projects
        INNER JOIN corrections ON corrections.project_id = projects.id
        WHERE corrections.user_id = users.id
    );
END $$

DELIMITER ;

-- Drop the column after executing the procedure
ALTER TABLE users DROP COLUMN total_weighted_score;
