sqlite> .schema
CREATE TABLE crime_scene_reports (
    id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    street TEXT,
    description TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE interviews (
    id INTEGER,
    name TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    transcript TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE courthouse_security_logs (
    id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    minute INTEGER,
    activity TEXT,
    license_plate TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE atm_transactions (
    id INTEGER,
    account_number INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    atm_location TEXT,
    transaction_type TEXT,
    amount INTEGER,
    PRIMARY KEY(id)
);
CREATE TABLE bank_accounts (
    account_number INTEGER,
    person_id INTEGER,
    creation_year INTEGER,
    FOREIGN KEY(person_id) REFERENCES people(id)
);
CREATE TABLE airports (
    id INTEGER,
    abbreviation TEXT,
    full_name TEXT,
    city TEXT,
    PRIMARY KEY(id)
);
CREATE TABLE flights (
    id INTEGER,
    origin_airport_id INTEGER,
    destination_airport_id INTEGER,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    hour INTEGER,
    minute INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(origin_airport_id) REFERENCES airports(id),
    FOREIGN KEY(destination_airport_id) REFERENCES airports(id)
);
CREATE TABLE passengers (
    flight_id INTEGER,
    passport_number INTEGER,
    seat TEXT,
    FOREIGN KEY(flight_id) REFERENCES flights(id)
);
CREATE TABLE phone_calls (
    id INTEGER,
    caller TEXT,
    receiver TEXT,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    duration INTEGER,
    PRIMARY KEY(id)
);
CREATE TABLE people (
    id INTEGER,
    name TEXT,
    phone_number TEXT,
    passport_number INTEGER,
    license_plate TEXT,
    PRIMARY KEY(id)
);


************* Investigate crime on July 28 on Chamberlin Street ****************************


SELECT * FROM crime_scene_reports WHERE month = 7 AND day = 28 AND street = "Chamberlin Street";

    id | year | month | day | street | description
    295 | 2020 | 7 | 28 | Chamberlin Street | Theft of the CS50 duck took place at 10:15am
    at the Chamberlin Street courthouse. Interviews were conducted today with three witnesses
    who were present at the time — each of their interview transcripts mentions the courthouse.

SELECT * FROM interviews WHERE month = 7 AND day = 28 AND transcript LIKE '%courthouse%';

    id | name | year | month | day | transcript
    161 | Ruth | 2020 | 7 | 28 | Sometime within ten minutes of the theft, I saw the thief get into a car in the courthouse parking lot and drive away.
        If you have security footage from the courthouse parking lot, you might want to look for cars that left the parking lot in that time frame.
    162 | Eugene | 2020 | 7 | 28 | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at the courthouse,
        I was walking by the ATM on Fifer Street and saw the thief there withdrawing some money.
    163 | Raymond | 2020 | 7 | 28 | As the thief was leaving the courthouse, they called someone who talked to them for less than a minute. In the call,
        I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other
        end of the phone to purchase the flight ticket.


SELECT * FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28
AND hour > 9 AND hour < 11 AND minute <= 25 AND activity = "exit";

    id | year | month | day | hour | minute | activity | license_plate
    260 | 2020 | 7 | 28 | 10 | 16 | exit | 5P2BI95
    261 | 2020 | 7 | 28 | 10 | 18 | exit | 94KL13X
    262 | 2020 | 7 | 28 | 10 | 18 | exit | 6P58WS2
    263 | 2020 | 7 | 28 | 10 | 19 | exit | 4328GD8
    264 | 2020 | 7 | 28 | 10 | 20 | exit | G412CB7
    265 | 2020 | 7 | 28 | 10 | 21 | exit | L93JTIZ
    266 | 2020 | 7 | 28 | 10 | 23 | exit | 322W7JE
    267 | 2020 | 7 | 28 | 10 | 23 | exit | 0NTHK55

SELECT people.name, courthouse_security_logs.license_plate, hour, minute
FROM courthouse_security_logs
JOIN people ON people.license_plate = courthouse_security_logs.license_plate
WHERE year = 2020 AND month = 7 AND day = 28 AND hour > 9 AND hour < 11 AND minute <= 25 AND activity = "exit";

    name | license_plate | hour | minute
    Patrick | 5P2BI95 | 10 | 16
    Ernest | 94KL13X | 10 | 18
    Amber | 6P58WS2 | 10 | 18
    Danielle | 4328GD8 | 10 | 19
    Roger | G412CB7 | 10 | 20
    Elizabeth | L93JTIZ | 10 | 21
    Russell | 322W7JE | 10 | 23
    Evelyn | 0NTHK55 | 10 | 23


SELECT * FROM atm_transactions WHERE year = 2020 AND month = 7 AND day = 28 AND transaction_type = "withdraw" AND atm_location = "Fifer Street";

    id | account_number | year | month | day | atm_location | transaction_type | amount
    246 | 28500762 | 2020 | 7 | 28 | Fifer Street | withdraw | 48
    264 | 28296815 | 2020 | 7 | 28 | Fifer Street | withdraw | 20
    266 | 76054385 | 2020 | 7 | 28 | Fifer Street | withdraw | 60
    267 | 49610011 | 2020 | 7 | 28 | Fifer Street | withdraw | 50
    269 | 16153065 | 2020 | 7 | 28 | Fifer Street | withdraw | 80
    288 | 25506511 | 2020 | 7 | 28 | Fifer Street | withdraw | 20
    313 | 81061156 | 2020 | 7 | 28 | Fifer Street | withdraw | 30
    336 | 26013199 | 2020 | 7 | 28 | Fifer Street | withdraw | 35

SELECT people.name, amount
FROM people
JOIN bank_accounts ON bank_accounts.person_id = people.id
JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
WHERE year = 2020 AND month = 7 AND day = 28 AND transaction_type = "withdraw" AND atm_location = "Fifer Street";

    name | amount
    Ernest | 50
    Russell | 35
    Roy | 80
    Bobby | 20
    Elizabeth | 20
    Danielle | 48
    Madison | 60
    Victoria | 30


SELECT * FROM flights WHERE year = 2020 AND month = 7 AND day = 29 ORDER BY hour;

    id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
    36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20
    43 | 8 | 1 | 2020 | 7 | 29 | 9 | 30
    23 | 8 | 11 | 2020 | 7 | 29 | 12 | 15
    53 | 8 | 9 | 2020 | 7 | 29 | 15 | 20
    18 | 8 | 6 | 2020 | 7 | 29 | 16 | 0

SELECT from_port.city, to_port.city, hour, minute
FROM flights
INNER JOIN
    airports AS from_port ON (from_port.id = flights.origin_airport_id)
INNER JOIN
    airports AS to_port ON (to_port.id = flights.destination_airport_id)
WHERE year = 2020 AND month = 7 AND day = 29 ORDER BY hour;

    city | city | hour | minute
    Fiftyville | London | 8 | 20
    Fiftyville | Chicago | 9 | 30
    Fiftyville | San Francisco | 12 | 15
    Fiftyville | Tokyo | 15 | 20
    Fiftyville | Boston | 16 | 0

SELECT people.name, passengers.flight_id, from_port.city, to_port.city
FROM passengers
JOIN people ON passengers.passport_number = people.passport_number
JOIN flights ON passengers.flight_id = flights.id
JOIN airports AS from_port ON (from_port.id = flights.origin_airport_id)
JOIN airports AS to_port ON (to_port.id = flights.destination_airport_id)
WHERE year = 2020 AND month = 7 AND day = 29 ORDER BY hour;

    name | flight_id | city | city
    Doris | 36 | Fiftyville | London
    Roger | 36 | Fiftyville | London
    Ernest | 36 | Fiftyville | London
    Edward | 36 | Fiftyville | London
    Evelyn | 36 | Fiftyville | London
    Madison | 36 | Fiftyville | London
    Bobby | 36 | Fiftyville | London
    Danielle | 36 | Fiftyville | London
    Daniel | 43 | Fiftyville | Chicago
    Carol | 43 | Fiftyville | Chicago
    Rebecca | 43 | Fiftyville | Chicago
    Sophia | 43 | Fiftyville | Chicago
    Heather | 43 | Fiftyville | Chicago
    Marilyn | 43 | Fiftyville | Chicago
    Dennis | 23 | Fiftyville | San Francisco
    Jose | 23 | Fiftyville | San Francisco
    Jennifer | 23 | Fiftyville | San Francisco
    Brandon | 23 | Fiftyville | San Francisco
    Matthew | 23 | Fiftyville | San Francisco
    Emily | 23 | Fiftyville | San Francisco
    Douglas | 23 | Fiftyville | San Francisco
    Jordan | 23 | Fiftyville | San Francisco
    Richard | 53 | Fiftyville | Tokyo
    Thomas | 53 | Fiftyville | Tokyo
    Roy | 53 | Fiftyville | Tokyo
    Larry | 53 | Fiftyville | Tokyo
    Steven | 53 | Fiftyville | Tokyo
    John | 53 | Fiftyville | Tokyo
    Pamela | 53 | Fiftyville | Tokyo
    Melissa | 53 | Fiftyville | Tokyo
    Gloria | 18 | Fiftyville | Boston
    Diana | 18 | Fiftyville | Boston
    Douglas | 18 | Fiftyville | Boston
    Russell | 18 | Fiftyville | Boston
    Christian | 18 | Fiftyville | Boston
    Michael | 18 | Fiftyville | Boston
    Ethan | 18 | Fiftyville | Boston
    Charles | 18 | Fiftyville | Boston

SELECT people.name, passengers.flight_id, from_port.city, to_port.city, seat
FROM passengers
JOIN people ON passengers.passport_number = people.passport_number
JOIN flights ON passengers.flight_id = flights.id
JOIN airports AS from_port ON (from_port.id = flights.origin_airport_id)
JOIN airports AS to_port ON (to_port.id = flights.destination_airport_id)
WHERE year = 2020 AND month = 7 AND day = 29 AND to_port.city = 'London';

    name | flight_id | city | city | seat
    Doris | 36 | Fiftyville | London | 2A
    Roger | 36 | Fiftyville | London | 3B
    Ernest | 36 | Fiftyville | London | 4A
    Edward | 36 | Fiftyville | London | 5C
    Evelyn | 36 | Fiftyville | London | 6C
    Madison | 36 | Fiftyville | London | 6D
    Bobby | 36 | Fiftyville | London | 7A
    Danielle | 36 | Fiftyville | London | 7B

SELECT * FROM phone_calls WHERE year = 2020 AND month = 7 AND day = 28 AND duration <= 60;

    id | caller | receiver | year | month | day | duration
    221 | (130) 555-0289 | (996) 555-8899 | 2020 | 7 | 28 | 51
    224 | (499) 555-9472 | (892) 555-8872 | 2020 | 7 | 28 | 36
    233 | (367) 555-5533 | (375) 555-8161 | 2020 | 7 | 28 | 45
    234 | (609) 555-5876 | (389) 555-5198 | 2020 | 7 | 28 | 60
    251 | (499) 555-9472 | (717) 555-1342 | 2020 | 7 | 28 | 50
    254 | (286) 555-6063 | (676) 555-6554 | 2020 | 7 | 28 | 43
    255 | (770) 555-1861 | (725) 555-3243 | 2020 | 7 | 28 | 49
    261 | (031) 555-6622 | (910) 555-3251 | 2020 | 7 | 28 | 38
    279 | (826) 555-1652 | (066) 555-9701 | 2020 | 7 | 28 | 55
    281 | (338) 555-6650 | (704) 555-2131 | 2020 | 7 | 28 | 54

SELECT phone_calls.id, call_phone.name, phone_calls.caller, rcv_phone.name, phone_calls.receiver, duration
FROM phone_calls
JOIN people AS call_phone ON call_phone.phone_number = phone_calls.caller
JOIN people AS rcv_phone ON rcv_phone.phone_number = phone_calls.receiver
WHERE year = 2020 AND month = 7 AND day = 28 AND duration <= 60;

    id | name | caller | name | receiver | duration
    221 | Roger | (130) 555-0289 | Jack | (996) 555-8899 | 51
    224 | Evelyn | (499) 555-9472 | Larry | (892) 555-8872 | 36
    233 | Ernest | (367) 555-5533 | Berthold | (375) 555-8161 | 45
    234 | Kathryn | (609) 555-5876 | Danielle | (389) 555-5198 | 60
    251 | Evelyn | (499) 555-9472 | Melissa | (717) 555-1342 | 50
    254 | Madison | (286) 555-6063 | James | (676) 555-6554 | 43
    255 | Russell | (770) 555-1861 | Philip | (725) 555-3243 | 49
    261 | Kimberly | (031) 555-6622 | Jacqueline | (910) 555-3251 | 38
    279 | Bobby | (826) 555-1652 | Doris | (066) 555-9701 | 55
    281 | Victoria | (338) 555-6650 | Anna | (704) 555-2131 | 54

SELECT people.name
FROM courthouse_security_logs
JOIN people ON people.license_plate = courthouse_security_logs.license_plate
WHERE year = 2020 AND month = 7 AND day = 28 AND hour > 9 AND hour < 11 AND minute <= 25 AND activity = "exit"
AND people.name IN(
    SELECT people.name
    FROM people
    JOIN bank_accounts ON bank_accounts.person_id = people.id
    JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
    WHERE year = 2020 AND month = 7 AND day = 28 AND transaction_type = "withdraw" AND atm_location = "Fifer Street");

    name
    Ernest
    Danielle
    Elizabeth
    Russell

SELECT people.name, from_port.city, to_port.city, seat
FROM passengers
JOIN people ON passengers.passport_number = people.passport_number
JOIN flights ON passengers.flight_id = flights.id
JOIN airports AS from_port ON (from_port.id = flights.origin_airport_id)
JOIN airports AS to_port ON (to_port.id = flights.destination_airport_id)
WHERE people.name IN ('Ernest', 'Danielle', 'Elizabeth', 'Russell')
    AND year = 2020 AND month = 7 AND day = 29 ORDER BY hour;

    name | city | city | seat
    Ernest | Fiftyville | London | 4A
    Danielle | Fiftyville | London | 7B
    Russell | Fiftyville | Boston | 4C

First flight out of Fiftyville is London, therefore cannot be Russell
Danielle received a call and did not make one, therefore it must be
Ernest!


The THIEF is: Ernest
The thief ESCAPED TO: London
The ACCOMPLICE is: Berthold


**************************** NOTES ******************************
SELECT table1.column1, table2.column2...
FROM table1
INNER JOIN table2
ON table1.common_field = table2.common_field;

SELECT name
FROM people
JOIN stars ON people.id = stars.person_id
JOIN movies ON movies.id = stars.movie_id
WHERE title = "Toy Story";




