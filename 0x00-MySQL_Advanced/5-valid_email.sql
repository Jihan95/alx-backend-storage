--  a SQL script that creates a trigger that resets the attribute
-- valid_email only when the email has been changed
DELIMITER $$
CREATE TRIGGER before_email_changed
BEFORE UPDATE ON users
FOR EACH ROW
	IF  NEW.email <> OLD.email THEN
		SET New.valid_email = 0;
	END IF$$
DELIMITER ;
