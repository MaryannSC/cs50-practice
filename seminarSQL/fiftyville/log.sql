-- Keep a log of any SQL queries you execute as you solve the mystery.

SELECT * FROM crime_scene_reports WHERE month = 7 AND day = 28 AND street = "Chamberlin Street";

SELECT * FROM interviews WHERE month = 7 AND day = 28 AND transcript LIKE '%courthouse%';

SELECT * FROM courthouse_security_logs WHERE year = 2020 AND month = 7 AND day = 28
AND hour > 9 AND hour < 11 AND minute <= 25 AND activity = "exit";

SELECT people.name, courthouse_security_logs.license_plate, hour, minute
FROM courthouse_security_logs
JOIN people ON people.license_plate = courthouse_security_logs.license_plate
WHERE year = 2020 AND month = 7 AND day = 28 AND hour > 9 AND hour < 11 AND minute <= 25 AND activity = "exit";

SELECT * FROM atm_transactions WHERE year = 2020 AND month = 7 AND day = 28 AND transaction_type = "withdraw" AND atm_location = "Fifer Street";

SELECT people.name
FROM people
JOIN bank_accounts ON bank_accounts.person_id = people.id
JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
WHERE year = 2020 AND month = 7 AND day = 28 AND transaction_type = "withdraw" AND atm_location = "Fifer Street";

SELECT * FROM flights WHERE year = 2020 AND month = 7 AND day = 29 ORDER BY hour;

SELECT from_port.city, to_port.city, hour, minute
FROM flights
INNER JOIN
    airports AS from_port ON (from_port.id = flights.origin_airport_id)
INNER JOIN
    airports AS to_port ON (to_port.id = flights.destination_airport_id)
WHERE year = 2020 AND month = 7 AND day = 29 ORDER BY hour;

SELECT people.name, passengers.flight_id, from_port.city, to_port.city
FROM passengers
JOIN people ON passengers.passport_number = people.passport_number
JOIN flights ON passengers.flight_id = flights.id
JOIN airports AS from_port ON (from_port.id = flights.origin_airport_id)
JOIN airports AS to_port ON (to_port.id = flights.destination_airport_id)
WHERE year = 2020 AND month = 7 AND day = 29 ORDER BY hour;

SELECT * FROM phone_calls WHERE year = 2020 AND month = 7 AND day = 28 AND duration <= 60;

SELECT phone_calls.id, call_phone.name, phone_calls.caller, rcv_phone.name, phone_calls.receiver, duration
FROM phone_calls
JOIN people AS call_phone ON call_phone.phone_number = phone_calls.caller
JOIN people AS rcv_phone ON rcv_phone.phone_number = phone_calls.receiver
WHERE year = 2020 AND month = 7 AND day = 28 AND duration <= 60;

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

SELECT people.name, from_port.city, to_port.city, seat
FROM passengers
JOIN people ON passengers.passport_number = people.passport_number
JOIN flights ON passengers.flight_id = flights.id
JOIN airports AS from_port ON (from_port.id = flights.origin_airport_id)
JOIN airports AS to_port ON (to_port.id = flights.destination_airport_id)
WHERE people.name IN ('Ernest', 'Danielle', 'Elizabeth', 'Russell')
    AND year = 2020 AND month = 7 AND day = 29 ORDER BY hour;

SELECT people.name, passengers.flight_id, from_port.city, to_port.city, seat
FROM passengers
JOIN people ON passengers.passport_number = people.passport_number
JOIN flights ON passengers.flight_id = flights.id
JOIN airports AS from_port ON (from_port.id = flights.origin_airport_id)
JOIN airports AS to_port ON (to_port.id = flights.destination_airport_id)
WHERE year = 2020 AND month = 7 AND day = 29 AND to_port.city = 'London';




