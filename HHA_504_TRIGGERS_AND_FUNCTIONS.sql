USE synthea;
SHOW Tables;

CREATE TABLE AHerrera_clinicaldata(
id INT AUTO_INCREMENT PRIMARY KEY,
patientUID INT NOT NULL,
lastname VARCHAR(50) NOT NULL,
systolic INT NOT NULL,
diastolic INT NOT NULL
);

INSERT INTO AHerrera_clinicaldata (patientUID, lastname, systolic,
diastolic) VALUES (246188, 'Herrera', 120, 70),
				  (249399, 'Herrera', 139, 82);

-- TRIGGER -- 
delimiter $$
CREATE TRIGGER qualitySystolic BEFORE INSERT ON clinical_data
FOR EACH ROW
BEGIN
IF NEW.systolic >= 300 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: Systolic BP MUST BE BELOW 300 mg!';
END IF;
END; $$
delimiter ;

-- FUNCTION --
DELIMITER $$
CREATE FUNCTION MedicationCost(
cost DECIMAL(10,2)
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
DECLARE drugCost VARCHAR(20);
IF cost > 200 THEN

SET drugCost = ‘expensive’;

ELSEIF (cost >= 10 AND
credit <= 200) THEN

SET drugCost = 'standard';
ELSEIF cost < 10 THEN
SET drugCost = 'cheap';
END IF;
-- return the drug cost category
RETURN (drugCost);
END$$
DELIMITER;

