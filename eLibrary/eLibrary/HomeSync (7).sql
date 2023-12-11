CREATE DATABASE HomeSync
USE HomeSync
SELECT * FROM Tasks
SELECT * FROM Assigned_to
SELECT * FROM Users
CREATE TABLE Room(
	room_id INT,
	type VARCHAR(50),
	floor INT,
	status VARCHAR(40),

	PRIMARY KEY(room_id)
);

CREATE TABLE Users(
	user_id INT IDENTITY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	password VARCHAR(10),
	email VARCHAR(50),
	preference VARCHAR(40),
	room INT,
	type VARCHAR(50) DEFAULT 'Guest',
	birthdate DATE,
	age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(birthdate)),
	
	PRIMARY KEY(user_id),
	FOREIGN KEY (room) REFERENCES Room ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Admin(
	admin_id INT,
	no_of_guests_allowed INT DEFAULT 30,
	salary DECIMAL(13,2),

	PRIMARY KEY(admin_id),
	FOREIGN KEY(admin_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Guest(
	guest_id INT,
	guest_of INT,
	address VARCHAR(80),
	arrival_date DATETIME,
	departure_date DATETIME,
	residential VARCHAR(80),

	PRIMARY KEY(guest_id),
	FOREIGN KEY(guest_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(guest_of) REFERENCES Admin
);

CREATE TABLE Tasks(
	task_id INT IDENTITY,
	name VARCHAR(80),
	creation_date DATETIME,
	due_date DATETIME,
	category VARCHAR(80),
	creator INT,
	status VARCHAR(50),
	reminder_date DATETIME,
	priority INT,

	PRIMARY KEY(task_id),
	FOREIGN KEY(creator) REFERENCES Admin ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Assigned_to(
	admin_id INT NOT NULL,
	task_id INT NOT NULL,
	user_id INT,

	CONSTRAINT [PK_Assigned_to] PRIMARY KEY CLUSTERED (task_id, user_id, admin_id),
	FOREIGN KEY(user_id) REFERENCES Users ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(task_id) REFERENCES Tasks,
	FOREIGN KEY(admin_id) REFERENCES Admin(admin_id) 
);

CREATE TABLE Calender(
	event_id INT IDENTITY,
	user_assigned_to INT,
	name VARCHAR(80),
	description VARCHAR(80),
	location VARCHAR(100), 
	reminder_date DATETIME,

	PRIMARY KEY(event_id,user_assigned_to),
	FOREIGN KEY(user_assigned_to) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Notes(
	note_id INT IDENTITY,
	user_id INT,
	content VARCHAR(100),
	creation_date DATETIME,
	title VARCHAR(50),

	PRIMARY KEY(note_id),
	FOREIGN KEY (user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Travel(
	trip_no INT,
	hotel_name VARCHAR(50),
	destination VARCHAR(60),
	ingoing_flight_num INT,
	outgoing_flight_num INT,
	ingoing_flight_date DATETIME,
	outgoing_flight_date DATETIME,
	ingoing_flight_airport VARCHAR(50),
	outgoing_flight_airport VARCHAR(50),
	transport VARCHAR(50),

	PRIMARY KEY(trip_no)
);

CREATE TABLE User_trip(
	trip_no INT NOT NULL,
	user_id INT NOT NULL,
	hotel_room_no INT,
	in_going_flight_seat_number INT,
	out_going_flight_seat_number INT,

	PRIMARY KEY(trip_no,user_id),
	FOREIGN KEY(trip_no) REFERENCES Travel ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Finance(
	payement_id INT IDENTITY PRIMARY KEY,
	user_id INT,
	type VARCHAR(50),
	amount DECIMAL(13,2),
	currency VARCHAR(30),
	method VARCHAR(60),
	status VARCHAR(50),
	date DATE,
	receipt_no INT,
	deadline DATETIME,
	penalty VARCHAR(50),

	FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Health(
	date DATETIME NOT NULL,
	activity VARCHAR(30) NOT NULL,
	user_id INT, 
	hours_slept INT,
	description VARCHAR(70),
	food VARCHAR(60),
	
	CONSTRAINT [PK_Health] PRIMARY KEY CLUSTERED (date, activity),
	FOREIGN KEY(user_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Communication(
	message_id INT IDENTITY,
	sender_id INT,
	receiver_id INT , 
	content VARCHAR(50),
	time_sent DATETIME,
	time_received DATETIME,
	time_read DATETIME,
	title VARCHAR(60),

	PRIMARY KEY(message_id),
	FOREIGN KEY(sender_id) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(receiver_id) REFERENCES Users
);


CREATE TABLE Device(
	device_id INT,
	room INT,
	type VARCHAR(50),
	status VARCHAR(50),
	battery_status INT,

	PRIMARY KEY(device_id),
	FOREIGN KEY(room) REFERENCES Room ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE RoomSchedule (
	creator_id INT,
	action VARCHAR(50),
	room INT,
	start_time DATETIME,
	end_time DATETIME,

	PRIMARY KEY(creator_id, start_time),
	FOREIGN KEY(creator_id) REFERENCES Users ON DELETE CASCADE,
	FOREIGN KEY(room) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Log (
	room_id INT,
	device_id INT NOT NULL,
	user_id INT NOT NULL,
	activity VARCHAR(50),
	date DATETIME NOT NULL,
	duration VARCHAR(70),

	CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED (room_id, device_id, user_id, date),
	FOREIGN KEY(room_id) REFERENCES Room ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY(device_id) REFERENCES Device ON DELETE CASCADE,
	FOREIGN KEY(user_id) REFERENCES Users
);

CREATE TABLE Consumption(
	device_id INT NOT NULL,
	consumption INT,
	date DATETIME NOT NULL,

	CONSTRAINT [PK_Consumption] PRIMARY KEY CLUSTERED (device_id, date),
	FOREIGN KEY(device_id) REFERENCES Device ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Preferences (
	user_id INT,
	category VARCHAR(50),
	preference_no INT,
	content VARCHAR(80),

	CONSTRAINT [PK_Preferences] PRIMARY KEY CLUSTERED (user_id, preference_no),
	FOREIGN KEY(user_id) REFERENCES Users ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Recommendation (
	recommendation_id INT PRIMARY KEY IDENTITY,
	user_id INT,
	category VARCHAR(50),
	preference_no INT,
	content VARCHAR(50),

	FOREIGN KEY(user_id, preference_no) REFERENCES Preferences(user_id, preference_no) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Inventory(
	supply_id INT PRIMARY KEY,
	name VARCHAR(50),
	quantity INT,
	expiry_date DATETIME,
	price decimal(13,2),
	manufacturer VARCHAR(50),
	category VARCHAR(50)
);


CREATE TABLE Camera(
    monitor_id INT NOT NULL,
    camera_id INT NOT NULL,
	status VARCHAR(50),
	room_id INT,

    CONSTRAINT PK_Camera PRIMARY KEY (monitor_id, camera_id),
	FOREIGN KEY(room_id) REFERENCES Room ON DELETE CASCADE ON UPDATE CASCADE 
);


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Procedures ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Unregistered Users:
--Yahya 
-- 1
GO
CREATE PROCEDURE UserRegister
	@usertype VARCHAR(20), 
	@email VARCHAR(50), 
	@first_name VARCHAR(20),
	@last_name VARCHAR(20), 
	@birth_date DATE, 
	@password VARCHAR(10),
	@user_id INT OUTPUT

	AS
	BEGIN
		INSERT INTO Users(first_name, last_name, password, email, type, birthdate) 
		VALUES(@first_name, @last_name, @password, @email, @usertype, @birth_date)

		SELECT @user_id = user_id
		FROM Users
		WHERE email = @email AND password = @password

		IF(@usertype = 'Admin')
			INSERT INTO Admin(admin_id) VALUES(@user_id)
		ELSE
			INSERT INTO Guest(guest_id) VALUES(@user_id)
END


-- Registered Users:
--Yahya 
-- 1 
GO
CREATE PROCEDURE UserLogin
	@email VARCHAR(50), 
	@password VARCHAR(10),
	@success BIT OUTPUT,
	@user_id INT OUTPUT
	
	AS
	BEGIN
		SET @success = 0;
		SELECT @user_id = user_id FROM Users WHERE @email = email AND @password = password
		IF(@user_id IS NOT NULL)
			SET @success = 1
END

--Islam 
-- 2 
GO
CREATE PROCEDURE ViewProfile
	@user_id INT

	AS
	BEGIN
		SELECT *
		FROM Users
		WHERE user_id = @user_id
END

--Yahya
-- 3	REMOVED
GO
CREATE PROCEDURE ViewRooms
	@age INT,
	@user_id INT

	AS
	BEGIN
		IF(@user_id IS NOT NULL AND @age IS NOT NULL)
			SELECT r.*
			FROM Users u INNER JOIN Room r ON u.room = r.room_id
			WHERE user_id = @user_id
			ORDER BY u.age
		ELSE IF(@age IS NULL)
			SELECT r.*
			FROM Users u INNER JOIN Room r ON u.room = r.room_id
			WHERE user_id = @user_id
		ELSE IF(@user_id IS NULL)
			SELECT *
			FROM Room
END

--Maryam kashif
-- 4
GO
CREATE PROCEDURE ViewMyTask
	@user_id INT

	AS 
	BEGIN
		UPDATE Tasks
		SET status = 'done'
		WHERE due_date <= CONVERT(DATETIME, CURRENT_TIMESTAMP)
		
		SELECT * 
		FROM TASKS
		WHERE creator = @user_id
END
--Maryam kashif
-- 5
GO
CREATE PROCEDURE FinishMyTask
	@user_id INT,
	@title VARCHAR(50)

	AS 
	BEGIN
		UPDATE Tasks
		SET status = 'done'
		WHERE creator = @user_id AND name = @title
END

--Yahya
-- 6

GO
CREATE PROCEDURE ViewTask
	@user_id INT,
	@creator INT

	AS
	BEGIN
		SELECT t.*
		FROM Tasks t INNER JOIN Assigned_to a ON t.task_id = a.task_id
		WHERE a.user_id = @user_id AND a.admin_id = @creator
		ORDER BY creation_date DESC
END

--Maryam Kashif
-- 7
GO
CREATE PROCEDURE ViewMyDeviceCharge
	@device_id INT,  
	@charge INT OUTPUT, 
	@location INT OUTPUT 

	AS 
	BEGIN
		SELECT @charge = battery_status ,@location = room
		FROM Device
		WHERE device_id = @device_id
END

--Islam 
-- 8
GO
CREATE PROCEDURE AssignRoom
	@user_id INT,
	@room_id INT

	AS
	BEGIN
		UPDATE Users
		SET room = @room_id
		WHERE user_id = @user_id
END

--Yahya 
-- 9
GO 
CREATE PROCEDURE CreateEvent
	@user_id INT, 
	@name VARCHAR(50), 
	@description VARCHAR(200), 
	@location VARCHAR(40),
	@reminder_date DATETIME,
	@other_user_id INT

	AS
	BEGIN
		INSERT INTO Calender(user_assigned_to, name, description, location, reminder_date)
		VALUES(@user_id, @name, @description, @location, @reminder_date)
		INSERT INTO Calender(user_assigned_to, name, description, location, reminder_date)
		VALUES(@other_user_id, @name, @description, @location, @reminder_date)
	
END

--Yahya 
-- 10
GO
CREATE PROCEDURE AssignUser
	 @user_id INT, 
	 @event_id INT

	 AS
	 BEGIN
		UPDATE Calender
		SET user_assigned_to = @user_id
		WHERE event_id = @event_id

		SELECT * 
		FROM Calender
		WHERE user_assigned_to = @user_id AND event_id = @event_id
END

--Maryam kashif
--11
GO
CREATE PROCEDURE AddReminder 
    @task_id INT,
    @reminder DATETIME

	AS
	BEGIN
		UPDATE Tasks
		SET reminder_date = @reminder
		WHERE task_id = @task_id
END

--Maryam kashif
--12
GO
CREATE PROCEDURE Uninvited
	@event_id INT, 
	@user_id INT

	AS
	BEGIN
		DELETE FROM Calender
		WHERE event_id = @event_id AND user_assigned_to = @user_id
END
--Maryam kashif
--13
GO 
CREATE PROCEDURE UpdateTaskDeadline 
	@deadline DATETIME, 
	@task_id INT

	AS
	BEGIN 
		UPDATE Tasks
		SET due_date = @deadline
		WHERE task_id = @task_id
END

--Yahya 
-- 14
GO 
CREATE PROCEDURE ViewEvent
	@user_id INT, 
	@event_id INT

	AS 
	BEGIN
		IF(EXISTS(SELECT * FROM Calender WHERE user_assigned_to = @user_id AND event_id = @event_id))
			SELECT *
			FROM Calender 
			WHERE user_assigned_to = @user_id AND event_id = @event_id
		ELSE
			SELECT *
			FROM Calender 
			WHERE user_assigned_to = @user_id
			ORDER BY reminder_date
END

--Maryam kashif
--15
GO
CREATE PROCEDURE ViewRecommendation
	AS
	BEGIN
		SELECT first_name, last_name 
		FROM Users
		WHERE user_id NOT IN (SELECT user_id FROM Recommendation)
END

--Maryam kashif
-- 16
GO
CREATE PROCEDURE CreateNote
	@user_id INT, 
	@title VARCHAR(50), 
	@Content VARCHAR(500), 
	@creation_date DATETIME

	AS
	BEGIN 
		INSERT INTO Notes(user_id, title, content, creation_date) VALUES(@user_id, @title,@Content, @creation_date)
END

--Yahya 
-- 17
GO
CREATE PROCEDURE ReceiveMoney
	@receiver_id INT, 
	@type VARCHAR(30), 
	@amount DECIMAL(13,2), 
	@description VARCHAR(10), 
	@date DATETIME

	AS
	BEGIN
		INSERT INTO Finance(user_id, type, amount, method, date, status) 
		VALUES(@receiver_id, @type, @amount, @description, @date, 'Incoming')
END

--Yahya 
-- 18
GO
CREATE PROCEDURE PlanPayment
	@sender_id INT, 
	@reciever_id INT, 
	@amount DECIMAL(13,2),
	@status VARCHAR(10),
	@deadline DATETIME
	
	AS
	BEGIN
		INSERT INTO Finance(user_id, type, amount,deadline, status) 
		VALUES(@sender_id, 'Outgoing', @amount, @deadline, @status)

		INSERT INTO Finance(user_id, type, amount,deadline, status) 
		VALUES(@reciever_id, 'Incoming', @amount, @deadline, @status)
END

--Yahya 
-- 19
GO
CREATE PROCEDURE SendMessage
	@sender_id INT, 
	@receiver_id INT, 
	@title VARCHAR(30), 
	@content VARCHAR(200), 
	@timesent TIME, 
	@timereceived TIME

	AS 
	BEGIN
		INSERT INTO Communication(sender_id, receiver_id, content, time_sent, time_received, title)
		VALUES (@sender_id, @receiver_id, @content, @timesent, @timereceived, @title)
END

--Maryam kashif
--20
GO
CREATE PROCEDURE NoteTitle
	@user_id INT, 
	@note_title VARCHAR(50)

	AS
	BEGIN
		UPDATE Notes
		SET title = @note_title
		WHERE user_id  = @user_id
END

--Islam 
-- 21
GO 
CREATE PROCEDURE ShowMessages
	@user_id INT, 
	@sender_id INT

	AS
	BEGIN
		SELECT * 
		FROM Communication
		WHERE sender_id = @sender_id AND receiver_id = @user_id
END


-- Registered Admins:
-- 1 Ahmed Alaa and Gamal Sheta
GO
CREATE PROCEDURE ViewUsers
    @user_type VARCHAR(20)

	AS
	BEGIN
		IF(@user_type='Admin')
			BEGIN
				SELECT * FROM Admin a INNER JOIN Users U ON a.admin_id = u.user_id
			END
		ELSE IF(@user_type='Guest')
			BEGIN
				SELECT *
				FROM Guest g INNER JOIN Users U ON g.guest_id = u.user_id
			END
END;

-- 2 Ahmed Alaa And Gamal Sheta
 GO
 CREATE PROCEDURE RemoveEvent
    @event_id INT,
    @user_id INT

	AS
	BEGIN
		DELETE FROM Calender
		WHERE event_id = @event_id AND user_assigned_to = @user_id;
END

--Maryam kashif  And Gamal Sheta
-- 3 
GO
CREATE PROCEDURE CreateSchedule
    @creator_id INT,
	@room_id INT,
    @start_time TIME,
    @end_time TIME,
    @action VARCHAR(20)

	AS
	BEGIN
		INSERT INTO RoomSchedule (creator_id, action, room, start_time, end_time)
		VALUES (@creator_id, @action, @room_id, @start_time, @end_time)
END
-- 4 Ahmed Alaa And Gamal Sheta
GO
 CREATE PROCEDURE GuestRemove
    @guest_id INT,
    @admin_id INT,
    @number_of_allowed_guests INT OUTPUT
	AS
	BEGIN
		IF(EXISTS(SELECT * FROM Guest WHERE guest_id = @guest_id)) BEGIN
			DECLARE @current_number_of_guests INT;
			SELECT @current_number_of_guests = no_of_guests_allowed
			FROM Admin
			WHERE admin_id = @admin_id;
			DELETE FROM Guest
			WHERE guest_id = @guest_id;
			SET @number_of_allowed_guests = @current_number_of_guests + 1;
			UPDATE Admin
			SET no_of_guests_allowed = @number_of_allowed_guests
			WHERE admin_id = @admin_id;
		END
END;

--Yahya 
-- 5
GO
CREATE PROCEDURE RecommendTD
	@Guest_id INT, 
	@destination VARCHAR(10), 
	@age INT,
	@preference_id INT

	AS
	BEGIN
		IF((SELECT age FROM Users WHERE user_id = @Guest_id) < @age AND EXISTS(SELECT * FROM Preferences WHERE preference_no = @preference_id AND user_id = @Guest_id))
		Begin
			INSERT INTO Recommendation(user_id, preference_no ,content) VALUES(@Guest_id, @preference_id,@destination)
		END
END;

--Yahya 
-- 6
GO
CREATE PROCEDURE Servailance
	@user_id INT, 
	@location INT,
	@camera_id INT

	AS 
	BEGIN
		SELECT *
		FROM Camera 
		WHERE room_id = @location AND monitor_id = @user_id AND camera_id = @camera_id
END

--Maryam kashif
-- 7
GO
CREATE PROCEDURE RoomAvailability
	@location INT, 
	@status VARCHAR(40)

	AS 
	BEGIN
		UPDATE Room
		SET status = @status
		WHERE room_id = @location
END


-- 8 Ahmed Alaa And Gamal Sheta
Go 
CREATE PROCEDURE Sp_Inventory
	@item_id INT,
	@name VARCHAR(30), 
	@quantity INT, 
	@expirydate DATETIME, 
	@price DECIMAL(10,2),
	@manufacturer VARCHAR(30),
	@category VARCHAR(20)

	AS
	BEGIN
		INSERT INTO Inventory(supply_id,name, quantity, expiry_date, price, manufacturer, category)
		VALUES(@item_id, @name, @quantity, @expirydate, @price, @manufacturer, @category)
END

--Maryam kashif
-- 9
GO
CREATE PROCEDURE Shopping
	@id INT, 
	@quantity INT, 
	@total_price DECIMAL(10,2) OUTPUT

	AS
	BEGIN
	SET @total_price = 0

	SELECT @total_price = SUM(price * @quantity)
	FROM Inventory 
	WHERE @id = supply_id


END


-- 10 Ahmed Alaa And Gamal Sheta
GO
CREATE PROCEDURE LogActivityDuration
    @room_id INT,
	@device_id INT, 
	@user_id INT,
	@date DATETIME, 
	@duration VARCHAR(50)

	AS
	BEGIN
	IF(NOT EXISTS(SELECT * FROM Log WHERE room_id = @room_id AND device_id = @device_id AND user_id = @user_id))
		INSERT INTO LOG(room_id, device_id, user_id, date, duration)
		VALUES(@room_id, @device_id, @user_id, @date, @duration)
END

-- 11 Ahmed Alaa And Gamal Sheta
GO
CREATE PROCEDURE TabletConsumption
    @consumption INT
AS
BEGIN
    UPDATE Consumption
    SET consumption = @consumption
    WHERE device_id IN (SELECT device_id FROM Device WHERE type = 'Tablet');
END;

-- 12 Ahmed Alaa And Gamal Sheta
GO
CREATE PROCEDURE MakePreferencesRoomTemp
	@user_id INT,
	@category VARCHAR(20), 
	@preferences_number INT

	AS
	BEGIN
		IF(EXISTS(SELECT * FROM Preferences WHERE preference_no = @preferences_number)) BEGIN
			UPDATE Preferences 
			SET content = 'Room Temprature = 30', category = @category
			WHERE user_id = @user_id AND preference_no = @preferences_number AND
				EXISTS(SELECT * FROM Preferences p INNER JOIN Users u ON p.user_id = u.user_id WHERE u.age > 40) 
		END
		ELSE
			INSERT INTO Preferences(user_id, category, preference_no, content)
			VALUES(@user_id, @category, @preferences_number, 'Room Temprature = 30')
END

--13 Ahmed Alaa And Gamal Sheta
GO
CREATE PROCEDURE ViewMyLogEntry
    @user_id INT
AS
BEGIN
     SELECT *
    FROM Log
    WHERE user_id = @user_id;
END;

--Yahya 
--14
GO
CREATE PROCEDURE UpdateLogEntry
    @user_id INT,
    @room_id INT,
    @device_id INT,
    @activity VARCHAR(30)
AS
BEGIN
     UPDATE Log
    SET activity = @activity
    WHERE user_id = @user_id
        AND room_id = @room_id
        AND device_id = @device_id;
END;

--Yahya 
--15
GO
CREATE PROCEDURE ViewRoom
AS
BEGIN
     SELECT *
    FROM Room
    WHERE room_id NOT IN (
        SELECT DISTINCT room_id
        FROM Log
    )
END


--16 Ahmed Alaa and Gamal Sheta
GO
CREATE PROCEDURE ViewMeeting
    @room_id INT,
    @user_id INT
AS
BEGIN
    IF(EXISTS(SELECT * FROM RoomSchedule WHERE room = @room_id AND creator_id = @user_id)) BEGIN
		SELECT *
		FROM Room
		WHERE room_id = @room_id

		SELECT u.first_name, u.last_name
		FROM RoomSchedule r INNER JOIN Users u ON r.room = u.room
		WHERE r.room = @room_id AND r.creator_id = @user_id
	END
	ELSE
		SELECT * 
		FROM RoomSchedule
		WHERE creator_id = @user_id
END

--Yahya 
--17

GO
CREATE PROCEDURE AdminAddTask
    @user_id INT,
    @creator INT,
    @name VARCHAR(30),
    @category VARCHAR(20),
    @priority INT,
    @status VARCHAR(20),
    @reminder DATETIME,
    @deadline DATETIME,
    @other_user INT
	AS
	BEGIN
		DECLARE @current_date DATETIME
		SET @current_date = CURRENT_TIMESTAMP

		INSERT INTO Tasks(creator, name, category, priority, status, reminder_date, due_date, creation_date) 
		VALUES(@creator, @name, @category, @priority, @status, @reminder, @deadline, @current_date)

		DECLARE @task_id INT
		SET @task_id = 0

		SELECT @task_id = task_id
		FROM Tasks
		WHERE creator = @creator AND name = @name AND creation_date = @current_date AND due_date = @deadline

		INSERT INTO Assigned_to VALUES(@creator, @task_id, @user_id)
		IF(@other_user IS NOT NULL) BEGIN
			INSERT INTO Assigned_to VALUES(@creator, @task_id, @other_user)
		END
END;


--Yahya 
--18
GO
 CREATE PROCEDURE AddGuest
    @email VARCHAR(30), 
	@first_name VARCHAR(10),
	@address VARCHAR (30),
	@password VARCHAR(10),
	@guest_of INT,
	@room_id INT,
	@number_of_allowed_guests INT OUTPUT

	AS
	BEGIN
		IF(EXISTS(SELECT * FROM Admin WHERE admin_id = @guest_of AND no_of_guests_allowed > 0)) BEGIN
			DECLARE @id INT

			INSERT INTO Users(email, first_name, password, room) VALUES(@email, @first_name, @password, @room_id)

			SELECT @id = user_id
			FROM Users
			WHERE email = @email AND password = @password

			INSERT INTO Guest(guest_id, guest_of, address) VALUES(@id, @guest_of, @address)

			SELECT @number_of_allowed_guests = no_of_guests_allowed
			FROM Admin
			WHERE admin_id = @guest_of

			SET @number_of_allowed_guests = @number_of_allowed_guests - 1

			UPDATE Admin
			SET no_of_guests_allowed = @number_of_allowed_guests
		END
END

--Yahya And Ahmed Alaa
-- 19 
GO
CREATE PROCEDURE AssignTask
    @user_id INT,
    @task_id INT,
	@creator_id INT

	AS
	BEGIN
		IF(EXISTS(SELECT * FROM Guest WHERE guest_id = @user_id) AND EXISTS(SELECT * FROM Admin WHERE admin_id = @creator_id) AND EXISTS(SELECT * FROM Tasks WHERE task_id = @task_id))
			INSERT INTO Assigned_to VALUES(@creator_id,	@task_id, @user_id)
END;

--Yahya And Ahmed Alaa
--20 
GO
CREATE PROCEDURE DeleteMsg
AS
BEGIN
     DELETE FROM Communication
    WHERE message_id = (
        SELECT TOP 1 message_id
        FROM Communication
    );
END;

--Maryam kashif
--21
GO
CREATE PROCEDURE AddItinerary
    @trip_no INT,
	@flight_num VARCHAR(30),
	@flight_date DATETIME,
	@destination VARCHAR(40)

	AS
	BEGIN
		UPDATE Travel
		SET outgoing_flight_num = @flight_num, outgoing_flight_date = @flight_date, destination = @destination
		WHERE trip_no = @trip_no
END

--Maryam kashif
--22
GO
CREATE PROCEDURE ChangeFlight
	AS
	BEGIN
		UPDATE Travel
		SET outgoing_flight_date = DATEADD(YEAR,1,outgoing_flight_date)
		WHERE YEAR(outgoing_flight_date) = YEAR(GETDATE())
END

--Maryam kashif
--23
GO
CREATE PROCEDURE UpdateFlight
    @date DATETIME,
    @destination VARCHAR(15),
	@trip_no INT

	AS
	BEGIN
		UPDATE Travel
		SET ingoing_flight_date = @date, destination = @destination
		WHERE trip_no = @trip_no
END

--Maryam kashif And Ahmed Alaa
--24
GO
CREATE PROCEDURE AddDevice
	@device_id INT, 
	@status VARCHAR(20), 
	@battery INT,
	@location INT, 
	@type VARCHAR(20)

	AS
	BEGIN
		IF(NOT EXISTS(SELECT * FROM Device WHERE device_id = @device_id))
			INSERT INTO Device(device_id, status, battery_status, room, type) VALUES(@device_id, @status, @battery, @location, @type)
END

--Maryam kashif
-- 25
GO
CREATE PROCEDURE OutOfBattery
	AS
	BEGIN
		SELECT room
		FROM Device
		WHERE status = 'Out of battery'
END

--Maryam kashif
--26
GO
CREATE PROCEDURE Charging 
AS
BEGIN 

UPDATE Device
SET status = 'Charging'
WHERE status = 'Out of battery'

END



--Maryam kashif
--27
GO
CREATE PROCEDURE GuestsAllowed
@admin_id INT,@number_of_guests INT
AS
BEGIN
UPDATE Admin
SET no_of_guests_allowed = @number_of_guests
WHERE admin_id = @admin_id
END

--Maryam kashif And Ahmed Alaa
--28
GO
CREATE PROCEDURE Penalize
	@penalty_amount INT 

	AS
	BEGIN
		UPDATE Finance 
		SET amount += @penalty_amount 
		
		WHERE status = 'unpaid' AND date >= deadline

		UPDATE Finance
		SET penalty = @penalty_amount
		WHERE status = 'unpaid' AND date >= deadline
END;


--Maryam kashif
--29	
GO
CREATE PROCEDURE GuestNumber
	@admin_id INT,
	@guest_num INT OUTPUT

	AS
	BEGIN
		SET @guest_num = 0
		SELECT @guest_num = COUNT(*)
		FROM Guest
		GROUP BY guest_of
		HAVING guest_of = @admin_id
END

--Maryam kashif
-- 30
GO
CREATE PROCEDURE Youngest
	AS
	BEGIN

		SELECT TOP 1 first_name, last_name
		FROM Users
		where age = (select min(age) from Users)
		
END
--Maryam kashif, Ahmed Alaa, and Gamel Sheta 
--31	
GO
CREATE PROCEDURE AveragePayement
	@amount DECIMAL(10,2)

	AS 
	BEGIN
		SELECT user_id, first_name, last_name, AVG(a.salary) AS 'Average Salary'
		FROM Admin a INNER JOIN Users u ON a.admin_id = u.user_id
		GROUP BY user_id, first_name,last_name
		HAVING AVG(a.salary) > @amount
END

--Maryam kashif And Ahmed Alaa
-- 32
GO
CREATE PROCEDURE Purchase
	@sum INT OUTPUT

	AS
	BEGIN
		SET @sum = 0
		SELECT @sum = @sum + (price*quantity)
		FROM Inventory
END;

--Maryam kashif
-- 33
GO
CREATE PROCEDURE NeedCharge
	AS
	BEGIN
		SELECT room, COUNT(*) AS 'Number of dead devices'
		FROM Device 
		WHERE battery_status <= 0
		GROUP BY room
		HAVING COUNT(*) > 2
END


-- 34 Ahmed Alaa And Gamal Sheta
GO
CREATE PROCEDURE Admins
	AS
	BEGIN
		SELECT u.user_id, COUNT(g.guest_id) AS 'Number of Guests'
		FROM (Guest g INNER JOIN Admin a ON g.guest_of = a.admin_id) INNER JOIN Users u ON a.admin_id = u.user_id
		GROUP BY u.user_id
		HAVING COUNT(*) > 2
END


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Triggers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--Yahya 

-- DELETE ROOM, SET NULL IN TABLES THAT REFERENCE IT
GO
CREATE TRIGGER delete_Room ON Room
	AFTER DELETE

	AS
	BEGIN
		DECLARE @roomId INT
		SELECT @roomId = room_id FROM deleted

		IF(EXISTS(SELECT * FROM Users WHERE room = @roomId))
			UPDATE Users
			SET room = NULL
			WHERE room = @roomId

		IF(EXISTS(SELECT * FROM Device WHERE room = @roomId))
			UPDATE Device
			SET room = NULL
			WHERE room = @roomId

		IF(EXISTS(SELECT * FROM RoomSchedule WHERE room = @roomId))
			DELETE FROM RoomSchedule WHERE room = @roomId

		IF(EXISTS(SELECT * FROM Log WHERE room_id = @roomId))
			DELETE FROM Log WHERE room_id = @roomId

		IF(EXISTS(SELECT * FROM Camera WHERE room_id = @roomId))
			DELETE FROM Camera WHERE room_id = @roomId
END

-- DELETE A USER, DELETE SAME USER FROM GUEST OR ADMIN AND TABLES THAT REFERENCE IT
GO 
CREATE TRIGGER delete_User ON Users
	AFTER DELETE

	AS
	BEGIN
		DECLARE @userId INT
		SELECT @userId = user_id FROM deleted

		IF(EXISTS(SELECT * FROM Guest WHERE guest_id = @userId)) BEGIN
			DELETE FROM Guest WHERE guest_id = @userId
		END
		ELSE IF(EXISTS(SELECT * FROM Admin WHERE admin_id = @userId)) BEGIN
			DELETE FROM Admin WHERE admin_id = @userId

			IF(EXISTS(SELECT * FROM Guest WHERE guest_of = @userId))
				UPDATE Guest
				SET guest_of = NULL
				WHERE guest_of = @userId

			IF(EXISTS(SELECT * FROM Tasks WHERE creator = @userId))
				DELETE FROM Tasks WHERE creator = @userId

			IF(EXISTS(SELECT * FROM Assigned_to WHERE admin_id = @userId))
				DELETE FROM Assigned_to WHERE admin_id = @userId
		END

		IF(EXISTS(SELECT * FROM Assigned_to WHERE user_id = @userId))
			DELETE FROM Assigned_to WHERE user_id = @userId

		IF(EXISTS(SELECT * FROM Calender WHERE user_assigned_to = @userId))
			DELETE FROM Calender WHERE user_assigned_to = @userId

		IF(EXISTS(SELECT * FROM Notes WHERE user_id = @userId))
			DELETE FROM Notes WHERE user_id = @userId

		IF(EXISTS(SELECT * FROM User_trip WHERE user_id = @userId))
			DELETE FROM User_trip WHERE user_id = @userId

		IF(EXISTS(SELECT * FROM Finance WHERE user_id = @userId))
			DELETE FROM Finance WHERE user_id = @userId

		IF(EXISTS(SELECT * FROM Health WHERE user_id = @userId))
			DELETE FROM Health WHERE user_id = @userId

		IF(EXISTS(SELECT * FROM Communication WHERE sender_id = @userId OR receiver_id = @userId))
			DELETE FROM Communication WHERE sender_id = @userId OR receiver_id = @userId

		IF(EXISTS(SELECT * FROM RoomSchedule WHERE creator_id = @userId))
			DELETE FROM RoomSchedule WHERE creator_id = @userId

		IF(EXISTS(SELECT * FROM Log WHERE user_id = @userId))
			DELETE FROM Log WHERE user_id = @userId

		IF(EXISTS(SELECT * FROM Preferences WHERE user_id = @userId))
			DELETE FROM Preferences WHERE user_id = @userId

		IF(EXISTS(SELECT * FROM Recommendation WHERE user_id = @userId))
			DELETE FROM Recommendation WHERE user_id = @userId
END


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Insertions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

INSERT INTO Users(first_name, last_name, password, email) Values('Bob','Bobby', '123456', 'bob@gmail.com');
INSERT INTO Users(first_name, last_name, password, email) Values('Giga','Chad', '9876', 'chad@gmail.com');

INSERT INTO Inventory (supply_id, name, quantity, expiry_date, price, manufacturer, category)
VALUES
(1, 'Yoghurt', 100, '2023-12-31', 19.99, 'Dairy land', 'Dairy products'),
(2, 'Coffee', 50, '2024-06-15', 29.95, 'Coffee Company', 'Dairy products'),
(3, 'Hair spray', 75, '2023-10-20', 49.99, 'SunSlik', 'Hair products'),
(5, 'Hair Conditioner', 200, '2023-11-30', 9.99, 'Bath and body works.', 'Hair products'),
(9, 'IPhone X', 30, '2024-04-25', 149.99, 'Tech Solutions', 'Apple Electronics')

INSERT INTO Room VALUES(138291,'1 Bedroom', 3,'Available');   --5 bedrooms living room a kitchen a garden 
INSERT INTO Room VALUES(1831,'Living room', 4,'Not available');
INSERT INTO Room VALUES(1889,'2 Bedroom', 2,'Available');
INSERT INTO Room VALUES(1601,'3 Bedroom', 4,'Not available');
INSERT INTO Room VALUES(1402,'4 Bedroom', 3,'Available');
INSERT INTO Room VALUES(1599,'5 Bedroom', 4,'Not available');
INSERT INTO Room VALUES(1300,'Kitchen', 4,'Not available');
INSERT INTO Room VALUES(1425,'Garden', 4,'Not available');
INSERT INTO Room VALUES(1500,'Balcony', 4,'Not available');
INSERT INTO Room VALUES(1888,'Bathroom', 4,'Available');

INSERT INTO Users VALUES('Yahya', 'Elnahas', 12345, 'yahya@gmail.com', NULL, 1831, 'Admin', '8/22/2004')
INSERT INTO Users VALUES('Maryam', 'Kashif', 67890, 'maryam@gmail.com', NULL, 1599, 'Guest', '1/1/2004')
INSERT INTO Users VALUES('Mohamed', 'Gamal', 102938, 'gamal@gmail.com', NULL, 1402, 'Guest', '10/10/2004')

INSERT INTO Travel(trip_no,hotel_name, destination, ingoing_flight_num, outgoing_flight_num, 
	ingoing_flight_date, outgoing_flight_date, ingoing_flight_airport, outgoing_flight_airport, transport)
VALUES
    (1000,'Nile River Hotel ', 'Destination A', 1234, 5678, '2022-10-01', '2022-10-05', 'Airport A', 'Airport B', 'Flight A'),
    (1002,'Hilton Hotel ', 'Destination B', 4321, 8765, '2022-10-02', '2022-10-06', 'Airport C', 'Airport D', 'Flight B'),
    (1004,'The Grand Pyramind', 'Destination C', 9876, 6543, '2022-10-03', '2022-10-07', 'Airport E', 'Airport F', 'Flight C'),
    (1032,'Tulip Hotel ', 'Destination D', 6789, 3456, '2022-10-04', '2022-10-08', 'Airport G', 'Airport H', 'Flight D'),
    (7832,'Panaroma', 'Destination E', 2345, 7890, '2022-10-05', '2022-10-09', 'Airport I', 'Airport J', 'Flight E');


SET IDENTITY_INSERT Users ON
INSERT INTO Users(user_id, first_name, last_name, password, email, preference, room, birthdate, type)
VALUES(19291,'Maryam','Kashif',64287,'maryamkashif2012@gmail.com','Hotel suit',1888,'2003/7/19','Admin');
INSERT INTO Users(user_id, first_name, last_name, password, email, preference, room, birthdate, type)
VALUES(1909,'Clara','Amir',00487,'ClaraAmir2019@gmail.com','Hotel suit',1402,'2003/7/19','Admin');
INSERT INTO Users(user_id, first_name, last_name, password, email, preference, room, birthdate, type)
VALUES(11001929,'Rahma','Rahma',654287,'Rahmaaaa2012@gmail.com','Normal',1889,'2003/7/19','Guest');
INSERT INTO Users(user_id, first_name, last_name, password, email, preference, room, birthdate, type)
VALUES(18731,'Maryam','Kashif',642287,'maryamkashif2012@gmail.com','suit',1599,'2003/7/19','Guest');
INSERT INTO Users(user_id, first_name, last_name, password, email, preference, room, birthdate, type)
VALUES(1900,'Nancy','Nancy',345287,'Nancy5453@gmail.com','suit',1831,'2003/7/19','Admin');
INSERT INTO Users(user_id, first_name, last_name, password, email, preference, room, birthdate, type)
VALUES(1322,'Karim','Ahmed',345287,'KimoKono@gmail.com','suit',1300,'2003/7/19','Guest');
INSERT INTO Users(user_id, first_name, last_name, password, email, preference, room, birthdate, type)
VALUES(1389,'Sandra','Sandra',345287,'SandraSandra@gmail.com','suit',1500,'2003/3/17','Guest');
INSERT INTO Users(user_id, first_name, last_name, password, email, preference, room, birthdate, type)
VALUES(1452,'Hana','Sawi',345287,'HanaSawi@gmail.com','suit',1500,'2003/8/13','Guest');
INSERT INTO Users(user_id, first_name, last_name, password, email, preference, room, birthdate, type)
VALUES(1101,'Nour','Tamer',345287,'NourTamer@gmail.com','suit',1425,'2006/5/13','Admin');
INSERT INTO Users(user_id, first_name, last_name, password, email, preference, room, birthdate, type)
VALUES(1884,'Joy','Grace',345287,'JoyGrace@gmail.com','suit',1888,'2002/5/10','Admin');
SET IDENTITY_INSERT Users OFF

INSERT INTO Admin(admin_id,no_of_guests_allowed,salary) VALUES (1900,10,10000);
INSERT INTO Admin(admin_id,no_of_guests_allowed,salary) VALUES (1101,20,2000);
INSERT INTO Admin(admin_id,no_of_guests_allowed,salary) VALUES (1884,30,5000);
INSERT INTO Admin(admin_id,no_of_guests_allowed,salary) VALUES (1909,20,6000);
INSERT INTO Admin(admin_id,no_of_guests_allowed,salary) VALUES (19291,10,8000);

INSERT INTO Guest(guest_id,guest_of,address,arrival_date,departure_date,residential) VALUES(1452,1900,'Masr gadeda','2023/5/4','2005/6/3','flat 5');
INSERT INTO Guest(guest_id,guest_of,address,arrival_date,departure_date,residential) VALUES(1322,1909,'Madinty','2023/5/7','2005/6/3','Villa 230');
INSERT INTO Guest(guest_id,guest_of,address,arrival_date,departure_date,residential) VALUES(1389,1884,'El Sherouk','2023/9/6','2005/6/3','flat 6');
INSERT INTO Guest(guest_id,guest_of,address,arrival_date,departure_date,residential) VALUES(18731,1909,'El Rehab','2023/3/1','2005/6/3','flat 5');
INSERT INTO Guest(guest_id,guest_of,address,arrival_date,departure_date,residential) VALUES(1884,19291,'Madinty','2023/5/4','2005/6/3','Villa 9');

INSERT INTO Device (device_id, type, status, battery_status, room) VALUES
    (1, 'Camera', 'Out of battery', 0, 1300),
    (2, 'Camera', 'Charging', 0, 1402),
    (3, 'Phone', 'Charging', 0, 1425),
    (4, 'Laptop', 'Out of battery', 0, 1500),
    (5, 'Camera', 'Charging', 1, 1601)

INSERT INTO Device(device_id, room, type, status, battery_status) 
VALUES (6, 1300, 'PC', 'Out of battery', 0), 
		(7, 1300, 'Mobile', 'Charging', 0),
		(8, 1300, 'Tablet', 'Out of battery', 50)

INSERT INTO Consumption(device_id, date, consumption) VALUES(8, '2/3/2023', 3), (1, '5/7/2023', 40)

INSERT INTO Calender(user_assigned_to, name, description, location, reminder_date)
VALUES
	(19291, 'Event 1', 'Event 1 description', 'Location 1', '12/12/2023'),
	(1909, 'Event 2', 'Event 2 description', 'Location 2', '1/2/2024')

SET IDENTITY_INSERT Calender ON
INSERT INTO Calender(event_id, user_assigned_to, name, description, location, reminder_date)
VALUES
	(1000 ,1101, 'Event 1000', 'Event 1000 description', 'Location 1000', '12/9/2023')
SET IDENTITY_INSERT Calender OFF

INSERT INTO Tasks(name, creation_date, due_date, category, creator, status, reminder_date, priority)
VALUES
	('Task 1', '1/1/2023', '12/12/2023', 'Category 1', 19291, 'unfinished', '5/5/2023', 3),
	('Task 2', '1/3/2023', '1/11/2023', 'Category 2', 1909, 'finshed', '3/7/2023', 1),
	('Task 3', '1/5/2023', '5/6/2023', 'Category 3', 1900, 'unfinished', '4/5/2023', 2)

INSERT INTO Assigned_to(admin_id, task_id, user_id) VALUES(1900, 2, 1452)

INSERT INTO Finance(user_id, amount, status, date, deadline) VALUES(1900, 5000, 'unpaid', '5/5/2023', '1/5/2023')

INSERT INTO RoomSchedule(creator_id, room, start_time) VALUES(1900, 1599, '2/3/2024')

INSERT INTO Camera(monitor_id, camera_id, room_id) VALUES(1101, 1, 1425), (1884, 2, 1888)


INSERT INTO Communication(sender_id, receiver_id, content, time_sent, time_received, time_read, title) VALUES(1,5,'Hii test',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,'test')

INSERT INTO Preferences(user_id, category, preference_no, content) VALUES(1900, 'ABC', 1, 'ABCD')


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Executions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Unregistered Users:
-- 1
DECLARE @user_id INT
EXEC UserRegister 'Admin','abcd', 'abc@gmail.com', 'cd','2-1-2001', '123456', @user_id OUTPUT
PRINT @user_id

-- Registered Users:

-- 1
DECLARE @success BIT, @user_id INT;
EXEC userLogin 'bob@gmail.com', '123456', @success OUTPUT, @user_id OUTPUT;
PRINT 'success: ' + CAST(@success AS VARCHAR(10))
PRINT 'user ID: ' + CAST(@user_id AS VARCHAR(20))

DECLARE @success BIT, @user_id INT;
EXEC userLogin 'chad@gmail.com', '9876', @success OUTPUT, @user_id OUTPUT;
PRINT 'success: ' + CAST(@success AS VARCHAR(10))
PRINT 'user ID: ' + CAST(@user_id AS VARCHAR(20))

-- 2
EXEC ViewProfile 2

-- 3
EXEC ViewRooms 18, 3
EXEC ViewRooms NULL, 4
EXEC ViewRooms 20, NULL

-- 4
EXEC ViewMyTask 1900

-- 5
EXEC FinishMyTask 19291, 'Task 1'
SELECT * FROM Tasks

-- 6
EXEC ViewTask 1452, 1900


-- 7
DECLARE @charge INT, @location INT
EXEC ViewMyDeviceCharge 5, @charge OUTPUT, @location OUTPUT
PRINT @charge
PRINT @location

-- 8
EXEC AssignRoom 1900, 1500
SELECT * FROM Users


-- 9
EXEC CreateEvent 4, 'Event Event', 'Event 12345', 'under the bridge', '11/23/2023', 1
SELECT * FROM Calender

-- 10
EXEC AssignUser 5, 2

-- 11
EXEC AddReminder 2, '2/3/2024'
SELECT * FROM Tasks

-- 12
EXEC Uninvited 2, 5


-- 13
EXEC UpdateTaskDeadline '5/2/2024', 2

-- 14
EXEC ViewEvent 1, 4
EXEC ViewEvent 1, 5

-- 15
EXEC ViewRecommendation

-- 16
EXEC CreateNote 3, 'Note 1', 'ABCD', '11/23/2023'
SELECT * FROM Notes

-- 17
EXEC ReceiveMoney 3, 'Fees 1', 75000, 'Uni Fees 1', '11/23/2023'
SELECT * FROM Finance

-- 18
EXEC PlanPayment 3, 1, 100000, 'Aid 111', '11/23/2024'

-- 19
EXEC SendMessage 3, 2, 'Msg 1', 'Hello', '6:45:00', '6:50:00'
SELECT * FROM Communication

-- 20
EXEC NoteTitle 3, 'Updated Note'
EXEC NoteTitle @user_id = 3 , @note_title = 'Birthday plans'

-- 21
EXEC ShowMessages 2, 3


-- Registered Admin:

-- 1
EXEC ViewUsers 'Admin'
EXEC ViewUsers 'Guest'

-- 2
EXEC RemoveEvent 1000, 1101
SELECT * FROM Calender

-- 3
EXEC CreateSchedule 1900, 1300, '2/2/2023', '5/2/2023', 'Cook'
SELECT * FROM RoomSchedule

-- 4
DECLARE @num INT
EXEC GuestRemove 1389, 1884, @num OUTPUT
PRINT @num
SELECT * FROM Guest
SELECT * FROM Admin

-- 5
EXEC RecommendTD 1900, 'Dubai', 30, 1
SELECT * FROM Recommendation
SELECT * FROM Users
-- 6
EXEC Servailance 1101, 1425, 1
SELECT * FROM Camera

-- 7
EXEC RoomAvailability 1300, 'Available'
SELECT * FROM Room
-- 8
EXEC Sp_Inventory 2231,'Todo',42131,'2023/12/2',1000,'Bakery','Desert'
EXEC Sp_Inventory @item_id = 7, @name = 'Potatoes', @quantity = 10, @expirydate = '2023-12-31',@price = 25.99, @manufacturer = 'Potato Farm',@category = 'Vegetables ';
SELECT * FROM Inventory



-- 9
DECLARE @total DECIMAL(10,2)
EXEC Shopping 1, 5, @total OUTPUT
PRINT @total

SELECT * FROM Inventory

-- 10
EXEC LogActivityDuration 1300, 1, 1900, '11/24/2023', '1 hour'
SELECT * FROM Log


--11
EXEC TabletConsumption @consumption = 50;
SELECT * FROM Consumption

--12
EXEC MakePreferencesRoomTemp @user_id = 1900 , @category = 'Bedroom' , @preferences_number= 30
SELECT * FROM Preferences

--13
EXEC ViewMyLogEntry @user_id = 1900;
SELECT * FROM Log

--14
EXEC UpdateLogEntry 
@user_id = 1900, 
@room_id = 1300, 
@device_id = 1,  
@activity = 'Playing golf'; 
SELECT * FROM Log

--15
EXEC ViewRoom;
--16

EXEC ViewMeeting @room_id =1599 ,@user_id = 1900


--17
EXEC AdminAddTask
@user_id = 1909,  
@creator = 1900,  
@name = 'Clean BedRoom',  
@category = 'Hygeneic', 
@priority = 1,  
@status = 'Pending', 
@reminder = '2023/12/4',
@deadline = '2023/3/3',  
@other_user = 1389; 

DECLARE @user_id1 INT = 19291; 
DECLARE @creator1 INT = 1900; 
DECLARE @name1 VARCHAR(30) = 'Grocery shopping';
DECLARE @category1 VARCHAR(20) = 'Daily tasks';
DECLARE @priority1 INT = 1; 
DECLARE @status1 VARCHAR(20) = 'Pending';
DECLARE @reminder1 DATETIME = '2023/1/01'; 
DECLARE @deadline1 DATETIME = '2023/1/15'; 
DECLARE @other_user1 INT = 1900; 

EXEC AdminAddTask
    @user_id = @user_id1,
    @creator = @creator1,
    @name = @name1,
    @category = @category1,
    @priority = @priority1,
    @status = @status1,
    @reminder = @reminder1,
    @deadline = @deadline1,
    @other_user = @other_user1;

select * from Tasks
SELECT * FROM Assigned_to
SELECT * FROM Room

--18
DECLARE @number_of_allowed_guests INT
EXEC AddGuest 'marayam@student.giu-uni.de', 'Maryam', 'Madinty' ,'1234', 1900 ,1300 ,
@number_of_allowed_guests output
PRINT @number_of_allowed_guests

SELECT * FROM Guest
SELECT * FROM Users

--19
EXEC AssignTask 1452 ,1,1900
SELECT * FROM Assigned_to
SELECT * FROM Tasks
--20
EXEC DeleteMsg

--21
EXEC AddItinerary @trip_no = 1000, @flight_num = 55 , @flight_date = '2023/2/2', @destination = 'Brazil'

--22
EXEC ChangeFlight
SELECT * FROM Travel

--23
EXEC UpdateFlight @date = '2023/2/3' , @destination = 'Cairo', @trip_no = 1000

--24
EXEC AddDevice @device_id = 9, @status = 'Out of battery',@battery = 0,@location = 1601, @type = 'Tablet';
EXEC AddDevice @device_id = 10, @status = 'Out of battery',@battery = 90,@location = 1601, @type = 'Tablet';
EXEC AddDevice @device_id = 19, @status = 'Charged',@battery = 90,@location = 1888, @type = 'Tablet';
EXEC AddDevice 12, 'Charged', 80, 1402, 'Laptop'
SELECT *  FROM Device
--25
EXEC OutOfBattery
--26
EXEC Charging
select * from Users
--27 
EXEC GuestsAllowed @admin_id = 11001930, @number_of_guests = 30
EXEC GuestsAllowed 1900, 5
SELECT no_of_guests_allowed from Admin where admin_id = 1101
SELECT * FROM Admin


--28
DECLARE @penalty_amount INT = 300;
EXEC Penalize @penalty_amount;
--29
DECLARE @admin_id INT = 1900; 
DECLARE @guest_num INT;
EXEC GuestNumber @admin_id, @guest_num OUTPUT;
PRINT 'Number of Guests for Admin ' + CAST(@admin_id AS VARCHAR(10)) + ': ' + CAST(@guest_num AS VARCHAR(10));

 --30
EXEC Youngest

--31

DECLARE @amount DECIMAL(10, 2);
SET @amount = 7000.00; -- You can set your desired amount EXEC AveragePayement @amount;
EXEC AveragePayement @amount = 508
--32
DECLARE @sum INT
EXEC Purchase @sum OUTPUT
SELECT @sum AS TotalSumOfPurchases;

-- 33
SELECT * FROM Device
EXEC NeedCharge

--34
EXEC Admins




























