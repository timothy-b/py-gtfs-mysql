/*

Script contributed by Michael Perkins
updated on 10/16/16 by Timothy Baumgartner

example usage:
cat load.sql | mysql -u root
(assumes user is in same directory as GTFS source files)

*/

DROP DATABASE IF EXISTS gtfs;

CREATE DATABASE gtfs;

USE gtfs;


CREATE TABLE `agency` (
    agency_id VARCHAR(10) PRIMARY KEY,
    agency_name VARCHAR(255) NOT NULL,
    agency_url VARCHAR(255) NOT NULL,
    agency_timezone VARCHAR(50) NOT NULL,
    agency_lang CHAR(2),
    agency_phone VARCHAR(32),
    agency_fare_url VARCHAR(255),
    agency_email VARCHAR(255)
);

CREATE TABLE `routes` (
  route_id VARCHAR(10) PRIMARY KEY,
	agency_id VARCHAR(10),
	route_short_name VARCHAR(50) NOT NULL,
	route_long_name VARCHAR(255) NOT NULL,
  route_desc VARCHAR(255),
	route_type TINYINT(1) NOT NULL,
  route_url VARCHAR(255),
  route_color CHAR(6) DEFAULT 'FFFFFF',
  route_text_color CHAR(6) DEFAULT '000000',
	KEY `agency_id` (agency_id),
	KEY `route_type` (route_type),

  CHECK (route_type >=0 && route_type <= 7),

  FOREIGN KEY (agency_id)
    REFERENCES agency(agency_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `calendar` (
  service_id INTEGER(10) PRIMARY KEY,
	monday TINYINT(1) NOT NULL,
	tuesday TINYINT(1) NOT NULL,
	wednesday TINYINT(1) NOT NULL,
	thursday TINYINT(1) NOT NULL,
	friday TINYINT(1) NOT NULL,
	saturday TINYINT(1) NOT NULL,
	sunday TINYINT(1) NOT NULL,
	start_date VARCHAR(8) NOT NULL,
	end_date VARCHAR(8) NOT NULL,
	KEY `service_id` (service_id)
);

CREATE TABLE `calendar_dates` (
    service_id INTEGER(10) NOT NULL,
    `date` VARCHAR(8) NOT NULL,
    exception_type TINYINT(1) NOT NULL,

    CHECK (exception_type = 1 || exception_type = 2),

    PRIMARY KEY (service_id, `date`, exception_type),

    FOREIGN KEY (service_id)
      REFERENCES calendar(service_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `fare_attributes` (
  fare_id VARCHAR(255) PRIMARY KEY,
  price DECIMAL (4,2) NOT NULL,
  currency_type VARCHAR(3) NOT NULL,
  payment_method TINYINT(1) NOT NULL,
  transfers TINYINT(1) NOT NULL,
  transfer_duration INTEGER(5) UNSIGNED,

  CHECK (payment_method = 0 || payment_method = 1),
  CHECK (transfers >= 0 && transfers <= 2)
);

CREATE TABLE `fare_rules` (
  fare_id VARCHAR(255) NOT NULL,
  route_id VARCHAR(10),
  origin_id VARCHAR(10),
  destination_id VARCHAR(10),
  contains_id VARCHAR(10),

  FOREIGN KEY (fare_id)
    REFERENCES fare_attributes(fare_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `feed_info` (
  feed_publisher_name VARCHAR(255) NOT NULL,
  feed_publisher_url VARCHAR(255) NOT NULL,
  feed_lang CHAR(2) NOT NULL,
  feed_start_date VARCHAR(8),
  feed_end_date VARCHAR(8),
  feed_version VARCHAR(255),

  CONSTRAINT uc_feedPub UNIQUE (feed_publisher_name, feed_publisher_url, feed_lang, feed_start_date, feed_end_date, feed_version)
);

CREATE TABLE `shapes` (
  shape_id VARCHAR(10) NOT NULL,
  shape_pt_lat DECIMAL(9,6) NOT NULL,
  shape_pt_lon DECIMAL(9,6) NOT NULL,
  shape_pt_sequence INTEGER(5) NOT NULL,
  shape_dist_traveled DECIMAL(7,4),
  PRIMARY KEY (shape_id, shape_pt_sequence)
);

CREATE TABLE `stops` (
  stop_id VARCHAR(10) PRIMARY KEY,
  stop_code INTEGER(10) UNIQUE,
	stop_name VARCHAR(255) NOT NULL,
	stop_desc VARCHAR(255),
	stop_lat DECIMAL(9,6) NOT NULL,
	stop_lon DECIMAL(9,6) NOT NULL,
  zone_id INTEGER(10),
  stop_url VARCHAR(255),
  location_type TINYINT(1) DEFAULT 0,
  parent_station TINYINT(1) DEFAULT 0,
  stop_timezone VARCHAR(50),
  wheelchair_boarding TINYINT(1) DEFAULT 0,

  CHECK (location_type = 0 || location_type = 1),
  CHECK (wheelchair_boarding = 0 || wheelchair_boarding = 1 || wheelchair_boarding = 2),

  CONSTRAINT uc_location UNIQUE (stop_lat, stop_lon)
);

CREATE TABLE `transfers` (
  from_stop_id VARCHAR(10) NOT NULL,
  to_stop_id VARCHAR(10) NOT NULL,
  transfer_type TINYINT(1) DEFAULT 0,
  min_transfer_time INTEGER(5) UNSIGNED,
  CHECK (transfer_type >= 0 && transfer_type <= 3),

  FOREIGN KEY (from_stop_id)
    REFERENCES stops(stop_id)
    ON UPDATE CASCADE ON DELETE CASCADE,

  FOREIGN KEY (to_stop_id)
    REFERENCES stops(stop_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `trips` (
  route_id VARCHAR(10) NOT NULL,
	service_id INTEGER(10) NOT NULL,
	trip_id INTEGER(10) PRIMARY KEY,
	trip_headsign VARCHAR(255),
  trip_short_name VARCHAR(50),
	direction_id TINYINT(1),
	block_id INTEGER(10),
  shape_id VARCHAR(10),
  wheelchair_accessible TINYINT(1),
  bikes_allowed TINYINT(2),

	KEY `route_id` (route_id),
	KEY `service_id` (service_id),
	KEY `direction_id` (direction_id),
	KEY `block_id` (block_id),

  CHECK (direction_id = 0 || direction_id = 1),
  CHECK (wheelchair_accessible >= 0 && wheelchair_accessible <= 2),
  CHECK (bikes_allowed >= 0 && bikes_allowed <= 2),

  FOREIGN KEY (route_id)
    REFERENCES routes(route_id)
    ON UPDATE CASCADE ON DELETE CASCADE,

  FOREIGN KEY (service_id)
    REFERENCES calendar(service_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `frequencies` (
  trip_id INTEGER(10) NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  headway_secs INTEGER(5) UNSIGNED NOT NULL,
  exact_times TINYINT(1) DEFAULT 0,

  CHECK (exact_times = 0 || exact_times = 1),

  FOREIGN KEY (trip_id)
    REFERENCES trips(trip_id)
    ON UPDATE CASCADE ON DELETE CASCADE,

  CONSTRAINT uc_tripFreq UNIQUE (trip_id, start_time, end_time)
);

CREATE TABLE `stop_times` (
  trip_id INTEGER(10) NOT NULL,
	arrival_time TIME NOT NULL,
	departure_time TIME NOT NULL,
	stop_id VARCHAR(10) NOT NULL,
	stop_sequence INTEGER(10),
  stop_headsign VARCHAR(255),
	pickup_type INTEGER(2) DEFAULT 0,
	drop_off_type INTEGER(2) DEFAULT 0,
  shape_dist_traveled DECIMAL(7,4),
  timepoint TINYINT(1) DEFAULT 1,
	KEY `trip_id` (trip_id),
	KEY `stop_id` (stop_id),
	KEY `stop_sequence` (stop_sequence),
	KEY `pickup_type` (pickup_type),
	KEY `drop_off_type` (drop_off_type),

  CHECK (pickup_type >= 0 && pickup_type <= 3),
  CHECK (drop_off_type >= 0 && drop_off_type <= 3),
  CHECK (timepoint = 0 || timepoint = 1),

  FOREIGN KEY (trip_id)
    REFERENCES trips(trip_id)
    ON UPDATE CASCADE ON DELETE CASCADE,

  FOREIGN KEY (stop_id)
    REFERENCES stops(stop_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);


LOAD DATA LOCAL INFILE 'agency.txt' INTO TABLE agency FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'routes.txt' INTO TABLE routes FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'calendar.txt' INTO TABLE calendar FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'calendar_dates.txt' INTO TABLE calendar_dates FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'fare_attributes.txt' INTO TABLE fare_attributes FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'fare_rules.txt' INTO TABLE fare_rules FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'feed_info.txt' INTO TABLE feed_info FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'shapes.txt' INTO TABLE shapes FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'stops.txt' INTO TABLE stops FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'transfers.txt' INTO TABLE transfers FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'trips.txt' INTO TABLE trips FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'frequencies.txt' INTO TABLE frequencies FIELDS TERMINATED BY ',' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'stop_times.txt' INTO TABLE stop_times FIELDS TERMINATED BY ',' IGNORE 1 LINES;
