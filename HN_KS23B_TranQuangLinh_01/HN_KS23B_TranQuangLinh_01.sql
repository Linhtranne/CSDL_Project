DROP DATABASE Project;
CREATE DATABASE Project;
USE Project;
CREATE TABLE Flight (
    flight_id VARCHAR(10) PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL,
    departure_airport VARCHAR(100) NOT NULL,
    arrival_airport VARCHAR(100) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    ticket_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Passenger (
    passenger_id VARCHAR(10) PRIMARY KEY,
    passenger_full_name VARCHAR(150) NOT NULL,
    passenger_email VARCHAR(255) UNIQUE NOT NULL,
    passenger_phone VARCHAR(15) UNIQUE NOT NULL,
    passenger_bod DATE NOT NULL
);

CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id VARCHAR(10) NOT NULL,
    flight_id VARCHAR(10) NOT NULL,
    booking_date DATE NOT NULL,
    booking_status ENUM('Confirmed', 'Cancelled', 'Pending') NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flight(flight_id)
);

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    payment_method ENUM('Credit Card', 'Bank Transfer', 'Cash') NOT NULL,
	payment_amount DECIMAL(10, 2),
    payment_date DATE NOT NULL,
    payment_status ENUM('Success', 'Failed', 'Pending') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

ALTER TABLE Passenger ADD COLUMN passenger_gender ENUM('Nam', 'Nữ', 'Khác') NOT NULL;
ALTER TABLE Booking ADD COLUMN ticket_quantity INT NOT NULL DEFAULT(1);
ALTER TABLE Payment MODIFY COLUMN payment_amount DECIMAL(10, 2) CHECK (payment_amount > 0);

INSERT INTO Passenger(passenger_id,passenger_full_name,passenger_email,passenger_phone,passenger_bod,passenger_gender) VALUES
	('P0001','Nguyen Anh Tuan','tuan.nguyen@example.com','0901234567','1995-05-15','Nam'),
	('P0002','Tran Thi Mai','mai.tran@example.com','0912345678','1996-06-16','Nu'),
	('P0003','Le Minh Tuan','tuan.le@example.com','0923456789','1997-07-17','Nam'),
	('P0004','Pham Hong Son','son.pham@example.com','0934567890','1998-08-18','Nam'),
	('P0005','Nguyen Thi Lan','lan.nguyen@example.com','0945678901','1999-09-19','Nu'),
	('P0006','Vu Thi Bao','bao.vu@example.com','0956789012','2000-10-20','Nu'),
	('P0007','Doan Minh Hoang','hoang.doan@example.com','0967890123','2001-11-21','Nam'),
	('P0008','Nguyen Thi Thanh','thanh.nguyen@example.com','0978901234','2002-12-22','Nu'),
	('P0009','Trinh Bao Vy','vy.trinh@example.com','0989012345','2003-01-23','Nu'),
	('P0010','Bui Hoang Nam','nam.bui@example.com','0990123456','2004-02-24','Nam');

INSERT INTO Flight(flight_id,airline_name,departure_airport,arrival_airport,departure_time,arrival_time,ticket_price) VALUES
	('F001','VietJet Air','Tan Son Nhat','Nha Trang','2025-03-01 08:00:00','2025-03-01 10:00:00', '150.5'),
	('F002','Vietnam Airlines','Noi Bai','Hanoi','2025-03-01 09:00:00','2025-03-01 11:30:00', '200.0'),
	('F003','Bamboo Airways','Da Nang','Phu Quoc','2025-03-01 10:00:00','2025-03-01 12:00:00', '120.8'),
	('F004','Vietravel Airlines','Can Tho','Ho Chi Minh','2025-03-01 11:00:00','2025-03-01 12:30:00', '180.0');
    
INSERT INTO Booking(passenger_id,flight_id,booking_date,booking_status,ticket_quantity) VALUES
	('P0001','F001','2025-02-20','Confirmed',1),
	('P0002','F002','2025-02-21','Cancelled',2),
    ('P0003','F003','2025-02-22','Pending',1),
    ('P0004','F004','2025-02-23','Confirmed',3),
    ('P0005','F001','2025-02-24','Pending',1),
    ('P0006','F002','2025-02-25','Confirmed',2),
    ('P0007','F003','2025-02-26','Cancelled',1),
    ('P0008','F004','2025-02-27','Pending',4),
    ('P0009','F001','2025-02-28','Confirmed',1),
    ('P0010','F002','2025-02-28','Pending',1),
    ('P0001','F003','2025-03-01','Confirmed',3),
    ('P0002','F004','2025-03-02','Cancelled',1),
    ('P0003','F001','2025-03-03','Pending',2),
    ('P0004','F002','2025-03-04','Confirmed',1),
    ('P0005','F003','2025-03-05','Cancelled',2),
    ('P0006','F004','2025-03-06','Pending',1),
    ('P0007','F001','2025-03-07','Confirmed',3),
    ('P0008','F002','2025-02-08','Cancelled',2),
    ('P0009','F003','2025-02-09','Pending',1),
    ('P0010','F004','2025-02-10	','Confirmed',1);

INSERT INTO Payment(payment_id,booking_id,payment_method,payment_amount,payment_date,payment_status) VALUES
	(1,1,'Credit Card','150.5','2025-02-20','Success'),
    (2,2,'Bank Transfer','200.0','2025-02-21','Failed'),
    (3,3,'Cash','120.8','2025-02-22','Pending'),
    (4,4,'Credit Card','180.0','2025-02-23','Success'),
    (5,5,'Bank Transfer','150.5','2025-02-24','Pending'),
    (6,6,'Cash','200.0','2025-02-25','Success'),
    (7,7,'Credit Card','120.8','2025-02-26','Failed'),
    (8,8,'Bank Transfer','180.0','2025-02-27','Pending'),
    (9,9,'Cash','150.5','2025-02-28','Success'),
    (10,10,'Credit Card','200.0','2025-03-01','Pending');

-- PHẦN 3: CẬP NHẬT DỮ LIỆU

UPDATE Payment
SET payment_status = 'Success'
WHERE payment_amount > 0 AND payment_method = 'Credit Card' AND payment_date < CURRENT_DATE;

UPDATE Payment
SET payment_status = 'Pending'
WHERE payment_method = 'Bank Transfer' AND payment_amount < 100 AND payment_date < CURRENT_DATE;

DELETE FROM Payment
WHERE payment_status = 'Pending' AND payment_method = 'Cash';

-- PHẦN 4: TRUY VẤN DỮ LIỆU

SELECT passenger_id, passenger_full_name, passenger_email, passenger_bod, passenger_gender 
FROM Passenger 
ORDER BY passenger_full_name ASC 
LIMIT 5;

SELECT flight_id, airline_name, departure_airport, arrival_airport
FROM Flight 
ORDER BY ticket_price DESC;

SELECT p.passenger_id, p.passenger_full_name, b.flight_id
FROM Passenger p
JOIN Booking b ON p.passenger_id = b.passenger_id
WHERE b.booking_status = 'Cancelled';

SELECT 
    b.booking_id, 
    b.passenger_id, 
    b.flight_id, 
    b.ticket_quantity
FROM Booking b
WHERE b.booking_status = 'Confirmed'
ORDER BY b.ticket_quantity DESC;

SELECT 
    b.booking_id, 
    p.passenger_full_name, 
    b.flight_id, 
    b.ticket_quantity
FROM Booking b
JOIN Passenger p ON b.passenger_id = p.passenger_id
WHERE b.ticket_quantity BETWEEN 2 AND 3
ORDER BY p.passenger_full_name ASC;

-- 6. Lấy danh sách hành khách đã đặt ít nhất 2 vé và có trạng thái thanh toán là "Pending"
SELECT 
    p.passenger_id, 
    p.passenger_full_name, 
    SUM(b.ticket_quantity) AS total_tickets
FROM Booking b
JOIN Passenger p ON b.passenger_id = p.passenger_id
JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE pay.payment_status = 'Pending'
GROUP BY p.passenger_id, p.passenger_full_name
HAVING total_tickets >= 2;

-- 7. Lấy danh sách hành khách và số tiền thanh toán cho các giao dịch có trạng thái "Success"
SELECT 
    p.passenger_id, 
    p.passenger_full_name, 
    pay.payment_amount
FROM Payment pay
JOIN Booking b ON pay.booking_id = b.booking_id
JOIN Passenger p ON b.passenger_id = p.passenger_id
WHERE pay.payment_status = 'Success';

-- 8. Lấy danh sách 5 hành khách đầu tiên có số lượng vé đặt lớn hơn 1, sắp xếp theo số lượng vé giảm dần
SELECT 
    b.passenger_id, 
    p.passenger_full_name, 
    b.ticket_quantity, 
    b.booking_status
FROM Booking b
JOIN Passenger p ON b.passenger_id = p.passenger_id
WHERE b.ticket_quantity > 1
ORDER BY b.ticket_quantity DESC
LIMIT 5;

-- 9. Lấy danh sách các chuyến bay có số lượng vé đặt nhiều nhất
SELECT 
    f.flight_id, 
    f.airline_name, 
    SUM(b.ticket_quantity) AS total_tickets
FROM Booking b
JOIN Flight f ON b.flight_id = f.flight_id
GROUP BY f.flight_id, f.airline_name
ORDER BY total_tickets DESC;

-- 10. Lấy danh sách hành khách có ngày sinh trước năm 2000, gồm số tiền thanh toán và trạng thái thanh toán, sắp xếp theo tên
SELECT 
    p.passenger_full_name, 
    pay.payment_amount, 
    pay.payment_status
FROM Passenger p
JOIN Booking b ON p.passenger_id = b.passenger_id
JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE p.passenger_bod < '2000-01-01'
ORDER BY p.passenger_full_name;









-- PHẦN 4: TẠO VIEW

CREATE VIEW view_all_passenger_booking AS
SELECT p.passenger_id, p.passenger_full_name, b.booking_id, b.flight_id, b.ticket_quantity
FROM Passenger p
JOIN Booking b ON p.passenger_id = b.passenger_id;

CREATE VIEW view_successful_payment AS
SELECT p.passenger_id, p.passenger_full_name, py.payment_amount
FROM Passenger p
JOIN Booking b ON p.passenger_id = b.passenger_id
JOIN Payment py ON b.booking_id = py.booking_id
WHERE py.payment_status = 'Success';

-- PHẦN 5: TẠO TRIGGER

DELIMITER //
CREATE TRIGGER check_ticket_quantity BEFORE UPDATE ON Booking
FOR EACH ROW
BEGIN
    IF NEW.ticket_quantity < 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số lượng vé không thể nhỏ hơn 1';
    END IF;
END;//
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_booking_status AFTER INSERT ON Payment
FOR EACH ROW
BEGIN
    IF NEW.payment_status = 'Success' THEN
        UPDATE Booking SET booking_status = 'Confirmed' WHERE booking_id = NEW.booking_id;
    END IF;
END;//
DELIMITER ;

-- PHẦN 6: TẠO STORED PROCEDURE

DELIMITER //
CREATE PROCEDURE GetAllPassengerBookings()
BEGIN
    SELECT p.passenger_id, p.passenger_full_name, b.booking_id, b.flight_id, b.ticket_quantity
    FROM Passenger p
    JOIN Booking b ON p.passenger_id = b.passenger_id;
END;//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddBooking(
    IN p_booking_id INT,
    IN p_passenger_id VARCHAR(10),
    IN p_flight_id VARCHAR(10),
    IN p_ticket_quantity INT,
    IN p_payment_method ENUM('Credit Card', 'Bank Transfer', 'Cash'),
    IN p_payment_amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO Booking (passenger_id, flight_id, booking_date, booking_status, ticket_quantity)
    VALUES (p_passenger_id, p_flight_id, CURDATE(), 'Pending', p_ticket_quantity);
    
    INSERT INTO Payment (booking_id, payment_method, payment_amount, payment_date, payment_status)
    VALUES (LAST_INSERT_ID(), p_payment_method, p_payment_amount, CURDATE(), 'Pending');
END;//
DELIMITER ;
