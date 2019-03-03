#1 -----------------------------
DELIMITER //
CREATE TRIGGER beforeInsertEmployee 
BEFORE INSERT 
ON employee FOR EACH ROW
BEGIN
	IF new.post != ALL((SELECT post FROM post)) OR new.pharmacy_id != ALL((SELECT id FROM pharmacy))
	THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Insertion Error!';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeUpdateEmployee
BEFORE UPDATE
ON employee FOR EACH ROW
BEGIN
	IF new.post != ALL((SELECT post FROM post)) OR new.pharmacy_id != ALL((SELECT id FROM pharmacy))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Update Error!';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeDeleteMedicine
BEFORE DELETE
ON medicine FOR EACH ROW
BEGIN
	IF old.id = ANY ((SELECT medicine_id FROM medicine_zone)) or old.id = ANY ((SELECT medicine_id FROM pharmacy_medicine))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Deletion Error!';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeInsertMedicineZone
BEFORE INSERT
ON medicine_zone FOR EACH ROW
BEGIN
	IF new.medicine_id != ALL ((SELECT id FROM medicine)) OR new.zone_id != ALL ((SELECT id FROM zone))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Insertion Error!';
	END IF;
END
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeUpdateMedicineZone
BEFORE UPDATE
ON medicine_zone FOR EACH ROW
BEGIN
	IF new.medicine_id != ALL ((SELECT id FROM medicine)) OR new.zone_id != ALL ((SELECT id FROM zone))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Update Error!';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeInsertPharmacy
BEFORE INSERT
ON pharmacy FOR EACH ROW
BEGIN
	IF 	new.street != ALL ((SELECT street FROM street))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Insertion Error!';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeUpdatePharmacy
BEFORE UPDATE
ON pharmacy FOR EACH ROW
BEGIN
	IF 	new.street != ANY ((SELECT street FROM street))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Update Error!';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER BeforeDeletePharmacy
BEFORE DELETE
ON pharmacy FOR EACH ROW
BEGIN
	IF id = ANY ((SELECT pharmacy_id FROM employee)) OR id = ANY ((SELECT pharmacy_id FROM pharmacy_medicine))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Deletion Error!';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeInsertPharmacyMedicine
BEFORE INSERT
ON pharmacy_medicine FOR EACH ROW
BEGIN
	IF new.medicine_id != ALL ((SELECT id FROM medicine)) OR new.pharmacy_id != ALL ((SELECT id FROM pharmacy))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Insertion Error!';
	END IF;
END
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeUpdatePharmacyMedicine
BEFORE UPDATE
ON phatmacy_medicine FOR EACH ROW
BEGIN
	IF new.medicine_id != ALL ((SELECT id FROM medicine)) OR new.pharmacy_id != ALL ((SELECT id FROM pharmacy))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Update Error!';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeDeletePost
BEFORE DELETE
ON post FOR EACH ROW
BEGIN
	IF old.post = ANY ((SELECT post FROM employee))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Deletion Error!';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeDeleteStreet
BEFORE DELETE
ON street FOR EACH ROW
BEGIN
	IF old.street = ANY ((SELECT street FROM pharmacy))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Deletion Error!';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeDeleteZone
BEFORE DELETE
ON zone FOR EACH ROW
BEGIN
	IF old.id = ANY ((SELECT zone_id FROM medicine_zone))
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Deletion Error!';
    END IF;
END //
DELIMITER ;



#2 -----------------------------
DELIMITER //
CREATE TRIGGER beforeInsertIdentityNumber
BEFORE INSERT
ON employee FOR EACH ROW
BEGIN
	IF new.identity_number LIKE('%00')
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Insertion Error! Identity number can not ends "00"!';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeUpdateIdentityNumber
BEFORE UPDATE
ON employee FOR EACH ROW
BEGIN
	IF new.identity_number LIKE('%00')
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Update Error! Identity number can not ends "00"!';
	END IF;
END //
DELIMITER ;



#3 -----------------------------
DELIMITER //
CREATE TRIGGER beforeInsertMinistryCode
BEFORE INSERT
ON medicine FOR EACH ROW
BEGIN
	IF new.ministry_code NOT RLIKE('^[А-Я&&[^МП]]{2}-\d{3}-\d{2}')
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Insertion Error! Ministry code is incorrect!';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER beforeUpdateMinistryCode
BEFORE UPDATE
ON medicine FOR EACH ROW
BEGIN
	IF new.ministry_code NOT RLIKE('^[А-Я&&[^МП]]{2}-\d{3}-\d{2}')
    THEN SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Update Error! Ministry code is incorrect';
	END IF;
END //
DELIMITER ;



#4 -----------------------------
DELIMITER //
CREATE TRIGGER stopInsertPost
BEFORE INSERT
ON post FOR EACH ROW
BEGIN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insertion Error!';
END //

CREATE TRIGGER stopUpdatePost
BEFORE UPDATE
ON post FOR EACH ROW
BEGIN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Update Error!';
END //

CREATE TRIGGER stopDeletePost
BEFORE DELETE
ON post FOR EACH ROW
BEGIN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deletion Error!';
END //
DELIMITER ;