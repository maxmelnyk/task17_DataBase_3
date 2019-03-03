#1 -----------------------------
DELIMITER //
CREATE PROCEDURE addEmployee(
	IN surname VARCHAR(30),
    IN name CHAR(30),
    IN midle_name VARCHAR(30),
    IN identity_number CHAR(10),
    IN passport CHAR(10),
    IN experience DECIMAL(10, 1),
    IN birthday DATE,
    IN post VARCHAR(15),
    IN pharmacy_id INT(11))
BEGIN
	IF post != ALL ((SELECT post FROM post)) OR pharmacy_id != ALL ((SELECT id FROM pharmacy))
    THEN SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Adding Error!';
    ELSE INSERT INTO employee (surname, name, midle_name, identity_number, passport, experience, birthday, post, pharmacy_id)
		VALUES (surname, name, midle_name, identity_number, passport, experience, birthday, post, pharmacy_id);
    END IF;
END//
DELIMITER ;


#2 -----------------------------
DELIMITER //
CREATE PROCEDURE addMedicineZone(
	IN medicine_id INT(10),
    IN zone_id INT(10))
BEGIN
	IF medicine_id != ALL ((SELECT id FROM medicine)) OR zone_id != ALL ((SELECT id FROM zone))
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Adding Error!';
    ELSE INSERT INTO medicine_zone VALUES (medicine_id, zone_id);
    END IF;
END //
DELIMITER ;

#3 -----------------------------
DELIMITER //
CREATE PROCEDURE createEmployeeTables()
BEGIN
	DECLARE done INT DEFAULT false;
	DECLARE nameT, surnameT VARCHAR(25);

	DECLARE empl_cursor CURSOR FOR SELECT surname, name FROM employee;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = true;
    
    OPEN empl_cursor;
    my_loop: LOOP
		FETCH empl_cursor into surnameT, nameT;
        IF done = true THEN LEAVE my_loop;
		END IF;
        SET @temp_query = CONCAT('CREATE TABLE ', surnameT, nameT);
        PREPARE myquery FROM @temp_query;
        EXECUTE myquery;
        DEALLOCATE PREPARE myquery;
	END LOOP;
    CLOSE empl_cursor;
END //
DELIMITER ;