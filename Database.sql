CREATE TABLE flights (
    icao24 TEXT PRIMARY KEY,
    callsign TEXT,
    origin_country TEXT,
    time_position BIGINT,
    longitude FLOAT,
    latitude FLOAT,
    velocity FLOAT,
    altitude FLOAT,
    on_ground BOOLEAN
);
SELECT * FROM flights WHERE latitude IS NOT NULL AND latitude != 0
AND longitude IS NOT NULL AND longitude != 0;
UPDATE flights 
DELETE FROM flights
WHERE icao24 IS NULL 
   OR callsign IS NULL 
   OR origin_country IS NULL 
   OR time_position IS NULL 
   OR longitude IS NULL 
   OR latitude IS NULL 
   OR velocity IS NULL 
   OR altitude IS NULL 
   OR on_ground IS NULL;
ALTER TABLE flights ADD COLUMN flight_time TIMESTAMP;
CREATE OR REPLACE FUNCTION convert_time_position()
RETURNS TRIGGER AS $$
BEGIN
    NEW.flight_time = TO_TIMESTAMP(NEW.time_position);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER update_flight_time
BEFORE INSERT OR UPDATE ON flights
FOR EACH ROW
EXECUTE FUNCTION convert_time_position();
UPDATE flights 
SET flight_time = TO_TIMESTAMP(time_position)
WHERE flight_time IS NULL;
SELECT * FROM Flights;



