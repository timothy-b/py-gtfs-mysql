DROP TABLE IF EXISTS `routes`;

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
