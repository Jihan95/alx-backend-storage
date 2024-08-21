-- a SQL script that creates a trigger that decrease
-- the quantity of an item after adding a new order.
CREATE TRIGGER after_adding_new_order
AFTER INSERT ON orders
FOR EACH ROW
	UPDATE items
	SET quantity = quantity - NEW.number
	WHERE name = New.item_name;
