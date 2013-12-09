DROP TABLE IF EXISTS `trips`;

CREATE TABLE `trips` (
    route_id INT(11),
	service_id VARCHAR(10),
	trip_id VARCHAR(20) PRIMARY KEY,
	trip_headsign VARCHAR(255),
	route_short_name VARCHAR(255),
	direction_id TINYINT(1),
	direction_name VARCHAR(255),
	block_id INT(11),
	shape_id INT(11),
	shape_code VARCHAR(50),
	trip_type VARCHAR(8),
	wheelchair_accessible INT(2),
	KEY `route_id` (route_id),
	KEY `service_id` (service_id),
	KEY `direction_id` (direction_id),
	KEY `block_id` (block_id),
	KEY `shape_id` (shape_id)
);
