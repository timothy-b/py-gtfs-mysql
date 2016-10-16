DROP TABLE IF EXISTS `shapes`;

CREATE TABLE `shapes` (
  shape_id VARCHAR(10) NOT NULL,
  shape_pt_lat DECIMAL(9,6) NOT NULL,
  shape_pt_lon DECIMAL(9,6) NOT NULL,
  shape_pt_sequence INTEGER(5) NOT NULL,
  shape_dist_traveled DECIMAL(7,4),
	PRIMARY KEY (shape_id, shape_pt_sequence)
);
