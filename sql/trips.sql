DROP TABLE IF EXISTS `trips`;

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
