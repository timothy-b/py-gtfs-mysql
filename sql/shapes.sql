DROP TABLE IF EXISTS `shapes`;

CREATE TABLE `shapes` (
	shape_id INT(11),
	shape_code VARCHAR(8),
	shape_pt_lat DECIMAL(8,6),
	shape_pt_lon DECIMAL(8,6),
	shape_pt_sequence INT(11),
	shape_dist_traveled DECIMAL(8,6),
	PRIMARY KEY (shape_id, shape_pt_sequence)
);