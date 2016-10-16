DROP TABLE IF EXISTS `stop_times`;

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
