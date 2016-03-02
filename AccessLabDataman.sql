DROP TRIGGER IF EXISTS driverInTrigger;
CREATE TRIGGER driverInTrigger
BEFORE INSERT ON Driver
FOR EACH ROW
BEGIN
 IF NEW.pointsNbr > 11 THEN
  SIGNAL SQLSTATE '80000'
  SET MESSAGE_TEXT = 'Points cannot be > 11';
  END IF;
END;

INSERT INTO Driver  (DriverID, Title, firstname, surname, pointsNBr)
VALUES ('D101', 'Mr', 'Fred', 'Bean', 22);


ALTER TABLE Delivery
ADD COLUMN firstname VARCHAR(15);

ALTER TABLE Delivery
ADD COLUMN surname VARCHAR(15);

UPDATE Driver, Delivery
SET Delivery.firstname = Driver.firstname
WHERE Driver.DriverID = Delivery.DriverID;

UPDATE Driver, Delivery
SET Delivery.Surname = Driver.Surname
WHERE Driver.DriverID = Delivery.DriverID;

UPDATE Driver, Delivery
SET Delivery.firstname = Driver.firstname
WHERE Driver.DriverID = Delivery.DriverID;

UPDATE Driver, Delivery
SET Delivery.Surname = Driver.Surname
WHERE Driver.DriverID = Delivery.DriverID;

DROP TRIGGER IF EXISTS driverTrigger;
CREATE TRIGGER driverTrigger
AFTER UPDATE ON Driver
FOR EACH ROW
BEGIN
  UPDATE Delivery
  SET Delivery.firstname = NEW.firstname
  WHERE Delivery.driverID = NEW.driverID;
  UPDATE Delivery
  SET Delivery.surname = NEW.surname
  WHERE Delivery.driverID = NEW.driverID;
END;

CREATE TRIGGER driverTrigger
AFTER UPDATE ON Driver

UPDATE Driver
SET surname = 'Pond'
WHERE driverID = 'D050';

DROP TRIGGER IF EXISTS deliveryTrigger;
CREATE TRIGGER deliveryTrigger
BEFORE INSERT ON Delivery
FOR EACH ROW
BEGIN
  SET NEW.firstname = (SELECT firstname
                      FROM Driver
                      WHERE driverID = NEW.DriverID);
  SET NEW.surname =    (SELECT surname
                      FROM Driver
                      WHERE driverID = NEW.DriverID);               
END;

SELECT firstname
                  FROM Driver
                  WHERE driverID = NEW.DriverID;
                  
  INSERT INTO Delivery (DeliveryNbr, driverID, customerID, vehicleNbr)
VALUES('DL00200', 'D020', 'C00030', 'L554 TTF');

CREATE TABLE pointsLog (
  DriverID VARCHAR(4),
  date  DATETIME,
  Points INT,
  CONSTRAINT pointsPK PRIMARY KEY (DriverID, date),
  CONSTRAINT pointsFK FOREIGN KEY (DriverID) REFERENCES Driver(DriverID) ON 
DELETE CASCADE
  );
  
  DROP TRIGGER IF EXISTS driverTrigger;
CREATE TRIGGER driverTrigger
AFTER UPDATE ON Driver
FOR EACH ROW
BEGIN
  IF NEW.pointsNbr > OLD.pointsNbr THEN
    INSERT INTO pointsLog 
    VALUES (NEW.driverID, NOW(), NEW.pointsNbr - OLD.pointsNbr);
  END IF;
END;

 INSERT INTO pointslog(DriverID,Date,points)
 VALUES('D010',NOW(),250);
 
  INSERT INTO pointslog(DriverID,Date,points)
  VALUES('D070',NOW(),12);
 
 INSERT INTO pointslog(DriverID,Date,points)
 VALUES('D020',NOW(),270);

UPDATE pointsLog
SET driverID = 'D070'
WHERE date = 'now'
and Points=270

CREATE TRIGGER driverTrigger
AFTER UPDATE ON Driver
FOR EACH ROW
BEGIN
  IF NEW.pointsNbr > OLD.pointsNbr THEN
    INSERT INTO pointsLog 
    VALUES (NEW.driverID, NOW(), NEW.pointsNbr - OLD.pointsNbr);
  END IF;
END;






