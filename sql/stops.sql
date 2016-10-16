DROP TABLE IF EXISTS `stops`;

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
