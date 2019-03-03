#1 -----------------------------
DELIMITER //
CREATE FUNCTION minExperience() 
RETURNS DECIMAL(10, 1)
READS SQL DATA DETERMINISTIC
BEGIN
	RETURN (SELECT MIN(experience) AS 'min_experience' FROM employee);
END //
DELIMITER ;
SELECT * FROM employee WHERE experience = minEXperience();

#2 -----------------------------
DELIMITER //
CREATE FUNCTION getPharmacyAddress(p_id INT(11))
RETURNS VARCHAR(30)
READS SQL DATA DETERMINISTIC
BEGIN
	RETURN (SELECT CONCAT(name, ' ', building_number) AS 'address' FROM pharmacy WHERE id = p_id);
END //
DELIMITER ;
SELECT *, getPharmacyAddress(pharmacy_id) FROM employee;