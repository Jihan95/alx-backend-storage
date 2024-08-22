DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE total_weight INT DEFAULT 0;

    -- Create a temporary table to store total_weighted_score
    CREATE TEMPORARY TABLE temp_users (
        user_id INT PRIMARY KEY,
        total_weighted_score INT
    );

    -- Insert total weighted score for each user into the temporary table
    INSERT INTO temp_users (user_id, total_weighted_score)
    SELECT u.id, SUM(c.score * p.weight)
    FROM users u
    LEFT JOIN corrections c ON u.id = c.user_id
    LEFT JOIN projects p ON c.project_id = p.id
    GROUP BY u.id;

    -- Update the average score for each user in the users table
    UPDATE users u
    JOIN temp_users t ON u.id = t.user_id
    SET u.average_score = t.total_weighted_score / (
        SELECT SUM(p.weight)
        FROM projects p
        INNER JOIN corrections c ON c.project_id = p.id
        WHERE c.user_id = u.id
    );

    -- Drop the temporary table
    DROP TEMPORARY TABLE temp_users;
END $$

DELIMITER ;

